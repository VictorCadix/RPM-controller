#define pinIR 2
#define pinINA 8
#define pinINB 9
#define pinMotorPWM 10

volatile unsigned long tiempoPalas;
volatile unsigned long last_tiempoPalas;
volatile unsigned int vueltas;
int last_vueltas;

typedef struct Velocidad{
  float real;
  float target;
  float error;
  float last_error;
  float last_real;
  float errorSum;   //Para integrador
  float errorDeriv; //Para derivador
};

Velocidad RPM;

int Kp;
int Ki;
int velocidad;
long errorRegulador;

//Time variables.
unsigned long previousMillis = 0;
float sampleTime;
unsigned long currentMillis;

void doIR (){
  long now = micros();
  unsigned long aux = now - last_tiempoPalas;
  if(aux > 3000){
    vueltas ++;
    tiempoPalas = aux;
    last_tiempoPalas = now;
  }
}

void giraMotor(bool direccion, int velocidad) { // 0->CW 1->CCW / (0-255) velocidad
  if (direccion == 0) { //CW
    digitalWrite(pinINA, HIGH);
    digitalWrite(pinINB, LOW);
  }
  else { //CCW
    digitalWrite(pinINA, LOW);
    digitalWrite(pinINB, HIGH);
  }
  if (velocidad >= 0 && velocidad <= 255) {
    analogWrite(pinMotorPWM, velocidad);
  }
  else if (velocidad > 255) {
    analogWrite(pinMotorPWM, 255);
  }
  else{
    digitalWrite(pinMotorPWM, LOW);
  }
}

void computeRPM (){
  int diff = vueltas - last_vueltas;
  last_vueltas = vueltas;
  
  if (diff == 0){
    RPM.real = 0;
  }
  else{
    long tiempoPorVuelta;
    long aux;
    aux = tiempoPalas;
    tiempoPorVuelta = aux * 2;  //2 palas (helice)
    RPM.real = 60000000 / tiempoPorVuelta;
  }
}

float Compute_Regulador(){
    RPM.error = RPM.target - RPM.real;
    RPM.errorSum += RPM.error*sampleTime/1000;
    
    float result = (long)(Kp * RPM.error + Ki * RPM.errorSum);
    return result;
}

void setup() {
  Serial.begin(19200);
  pinMode(13,OUTPUT);
  pinMode(pinIR, INPUT);
  attachInterrupt(0, doIR, FALLING); //Pin 2

  //Setup Motor
  pinMode(pinINA,OUTPUT);
  pinMode(pinINB,OUTPUT);
  pinMode(pinMotorPWM,OUTPUT);

  //Setup variables 
  vueltas = 0;
  last_vueltas = 0;
  last_tiempoPalas = 0;
  RPM.real = 0;
  RPM.target = 0;

  Kp = 3;
  Ki = 2;
  sampleTime = 200; //ms
}

void loop() {
  currentMillis = millis();
  
  if(currentMillis >= 1000){
    RPM.target = 5000;
  }
  
  if (currentMillis - previousMillis >= sampleTime) {
    previousMillis = currentMillis;

    computeRPM();
    errorRegulador = Compute_Regulador();

    velocidad = errorRegulador * 0.000574 * 51; //Pasamos de RPM a tension en PWM
    giraMotor(1,velocidad);
    
    //Prints
    Serial.print (currentMillis);
    Serial.print (",");
    Serial.print (RPM.target);
    Serial.print (",");
    Serial.print (RPM.real);
    Serial.print (",");
    Serial.print (velocidad);
    Serial.print (",");
    Serial.print (Kp * RPM.error);
    Serial.print (",");
    Serial.println (Ki * RPM.errorSum);
  }
}

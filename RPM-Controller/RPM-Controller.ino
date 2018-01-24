#define pinIR 2
#define pinINA 8
#define pinINB 9
#define pinMotorPWM 10

volatile int vueltas;
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

//Time variables.
unsigned long previousMillis = 0;
float sampleTime;
unsigned long currentMillis;

void doIR (){
  vueltas ++;
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
  RPM.real = (vueltas - last_vueltas);
  last_vueltas = vueltas;
  RPM.real = RPM.real * 300; // 300=60*10/2 donde 60 segundos/min * 10 medidas/seg / 2 palas (helice)
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
  sampleTime = 100; //ms
}

void loop() {
  currentMillis = millis();
  
  if (currentMillis - previousMillis >= sampleTime) {
    previousMillis = currentMillis;

    computeRPM();
    giraMotor(1,200);
    
    //Prints
    Serial.print (currentMillis);
    Serial.print (",");
    Serial.println(RPM.real);
  }
}

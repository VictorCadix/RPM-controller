#define pinIR 2
#define pinINA 8
#define pinINB 9
#define pinMotorPWM 10

volatile int vueltas;
//Time variables.
unsigned long previousMillis = 0;
float sampleTime;
unsigned long currentMillis;

void doIR (){
  vueltas ++;
}

void setup() {
  Serial.begin(9600);
  pinMode(13,OUTPUT);
  pinMode(pinIR, INPUT);
  attachInterrupt(0, doIR, FALLING); //Pin 2

  //Setup Motor
  pinMode(pinINA,OUTPUT);
  pinMode(pinINB,OUTPUT);
  pinMode(pinMotorPWM,OUTPUT);

  //Setup variables 
  vueltas = 0;
  sampleTime = 100; //ms
}

void loop() {
  digitalWrite(pinMotorPWM,HIGH);
  digitalWrite(pinINA,HIGH);
  digitalWrite(pinINB,LOW);
  currentMillis = millis();
  
  if (currentMillis - previousMillis >= sampleTime) {
    previousMillis = currentMillis;
    
    //Prints
    Serial.print (currentMillis);
    Serial.print (",");
    Serial.println(vueltas);
  }
}

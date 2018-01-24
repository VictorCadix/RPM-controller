#define pinIR 2
#define pinINA 8
#define pinINB 9
#define pinMotorPWM 10

volatile int vueltas;

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

  //Variable initialisation
  vueltas = 0;
  
}

void loop() {
  digitalWrite(pinMotorPWM,HIGH);
  digitalWrite(pinINA,HIGH);
  digitalWrite(pinINB,LOW);
  Serial.println(vueltas);
  //Serial.print("/");
 
}

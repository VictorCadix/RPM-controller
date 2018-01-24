#define pinIR 2

volatile int vueltas;

void doIR (){
  vueltas ++;
}

void setup() {
  Serial.begin(9600);
  pinMode(13,OUTPUT);
  pinMode(pinIR, INPUT);
  attachInterrupt(0, doIR, FALLING); //Pin 2

  vueltas = 0;
  
}

void loop() {
  
  Serial.println(vueltas);
  //Serial.print("/");
 
}

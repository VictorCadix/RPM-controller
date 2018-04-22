import processing.serial.*;

Serial port;

void setup(){
  println(Serial.list());
  port = new Serial (this, Serial.list()[0],115200);
}

void draw(){
  
}

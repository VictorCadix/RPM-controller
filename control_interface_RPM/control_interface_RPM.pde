import processing.serial.*;

int millis;
float target;
float real;
float proportional;
float integral;
int velocidad;
int vueltas;

boolean arduSetupDone = false;

Serial port;

Button button1;

void setup() {
  size(600,300);
  println(Serial.list());
  port = new Serial (this, Serial.list()[0], 1000000);
  port.bufferUntil('\n');
  button1 = new Button (50,50,75,75);
  button1.text = "BUTTON";
  button1.setColor(255,0,0);
}

void draw() {
  background(200);
  button1.draw();
}

void serialEvent(Serial port) {
  String str = trim(port.readString());
  println(str);
  if (arduSetupDone == true) {
    stringParse(str);
  } else {
    String comp = "Setup done";
    if (str.equals(comp)==true) {
      arduSetupDone = true;
      println("Start");
    }
  }
}

void stringParse(String str) {
  int tot = 7;  //Total of data transmited
  int lastCommaPos = 0;
  for (int cont = 0; cont<tot; cont++) {
    int commaPos = str.indexOf(',', lastCommaPos);
    String auxStr;
    if (commaPos == -1) {
      //commaPos = str.length();
      println("LastElement");
      auxStr = str.substring(lastCommaPos, str.length()-1);//, commaPos);
    } else {
      println("Comma pos at: " + commaPos);
      auxStr = str.substring(lastCommaPos, commaPos);
      lastCommaPos = commaPos+1;
    }
    if (cont == 0) {
      millis = Integer.parseInt(auxStr);
      println("millis " + millis);
      if (millis != 100) {
        break;
      }
    } else if (cont == 1) {
      target = Float.parseFloat(auxStr);
      println(target);
    } else if (cont == 2) {
      real = Float.parseFloat(auxStr);
      println(real);
    } else if (cont == 3) {
      velocidad = Integer.parseInt(auxStr);
      println(velocidad);
    } else if (cont == 4) {
      proportional = Float.parseFloat(auxStr);
      println(proportional);
    } else if (cont == 5) {
      integral = Float.parseFloat(auxStr);
      println(integral);
    } else if (cont == 6) {
      vueltas = Integer.parseInt(auxStr);
      println(vueltas);
    }
  }
}

void mousePressed(){
  button1.isPressed();
}

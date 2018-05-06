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

void setup() {
  println(Serial.list());
  port = new Serial (this, Serial.list()[0], 1000000);
  port.bufferUntil('\n');
}

void draw() {
}

void serialEvent(Serial port) {
  String str = port.readString();
  println(str);
  //if (str.equals("Setup done\n")) {
  //  arduSetupDone = true;
  //  println("Start");
  //}
  //if (arduSetupDone == true) {
    stringParse(str);
  //}
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
      auxStr = str.substring(lastCommaPos);//, commaPos);
    } else {
      println("Comma pos at: " + commaPos);
      auxStr = str.substring(lastCommaPos, commaPos);
      lastCommaPos = commaPos+1;
    }
    if (cont == 0) {
      millis = Integer.parseInt(auxStr);
      println(millis);
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

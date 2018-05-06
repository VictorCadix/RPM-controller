import processing.serial.*;
import grafica.*;

int millis;
float target;
float real;
float proportional;
float integral;
int velocidad;
int vueltas;

boolean arduSetupDone = false;

//Plot
int nPoints = 0;
GPointsArray points = new GPointsArray(nPoints);

Serial port;

void setup() {
  
  //Serial
  println(Serial.list());
  port = new Serial (this, Serial.list()[0], 1000000);
  port.bufferUntil('\n');
  
  //Window
  size(600,400);
}

void draw() {
  GPointsArray points = new GPointsArray(nPoints);
  points.add(nPoints, target);
  
  GPlot plot = new GPlot(this);
  plot.setPos(25, 25);
  
  plot.setPoints(points);
  plot.defaultDraw();
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
  nPoints++;
}

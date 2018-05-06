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
FloatList l_target;

Serial port;

PFont fTarget;

void setup() {
  
  //Serial
  println(Serial.list());
  port = new Serial (this, Serial.list()[0], 1000000);
  port.bufferUntil('\n');
  
  //Window
  size(600,400);
  
  //Text
  fTarget = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  l_target = new FloatList();
}

void draw() {
  background(200);
  textFont(fTarget,16);
  fill(0);
  text("Target: " + target,10,15);
  GPointsArray points = new GPointsArray(nPoints);
  for(int i=0; i<nPoints; i++){
    points.add(i, target);
  }
  
  GPlot plot = new GPlot(this);
  plot.setPos(50, 50);
  
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
      l_target.append(target);
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

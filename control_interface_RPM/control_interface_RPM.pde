import processing.serial.*;

//int millis;

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
  stringParse(str);
}

void stringParse(String str) {
  int tot = 7;  //Total of data transmited
  int lastCommaPos = 0;
  for (int cont = 0; cont<tot; cont++) {
    int commaPos = str.indexOf(',', lastCommaPos);
    if (commaPos == -1) {
      commaPos = str.length();
      println("LastElement");
      String auxStr = str.substring(lastCommaPos, commaPos);
      println(auxStr);
    } else {
      println("Comma pos at: " + commaPos);
      String auxStr = str.substring(lastCommaPos, commaPos);
      println(auxStr);
      lastCommaPos = commaPos+1;
    }
  }
}

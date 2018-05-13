
class Button {
  //Position
  float posX;
  float posY;
  //Size
  float sizeX;
  float sizeY;
  
  String text;
  
  //Color
  int r;
  int g;
  int b;
  
  //Functions
  
  Button(float posx, float posy, float sizex, float sizey){
    this.posX = posx;
    this.posY = posy;
    this.sizeX = sizex;
    this.sizeY = sizey;
    this.text = "";
  }
  
  void setColor(int red, int green, int blue){
    this.r = red;
    this.g = green;
    this.b = blue;
  }
}


class Button {
  //Position
  float posX;
  float posY;
  //Size
  float sizeX;
  float sizeY;
  
  PFont font;
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
    
    font = createFont("Arial",14,true);
  }
  
  void setColor(int red, int green, int blue){
    this.r = red;
    this.g = green;
    this.b = blue;
  }
  
  void draw(){
    fill(r,g,b);
    //noStroke();
    rect(posX,posY,sizeX,sizeY, 5);
    fill(0);
    textAlign(CENTER,CENTER);
    textFont(font);
    text(text,posX+sizeX/2, posY+sizeY/2);
    
  }
  
  boolean isPressed(){
    if (mouseX > posX && mouseX < posX+sizeX){
      if (mouseY >posY && mouseY < posY+sizeY){
        this.text = "PRESSED";
        return true;
      }
    }
    return false;
  }
}
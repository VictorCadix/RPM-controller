
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
  
  float scale;
  
  //Functions
  
  Button(float posx, float posy, float sizex, float sizey){
    this.posX = posx;
    this.posY = posy;
    this.sizeX = sizex;
    this.sizeY = sizey;
    this.text = "";
    
    this.scale = 1;
    
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
    isMouseOver();
    rectMode(CENTER);
    rect(posX,posY,sizeX*scale,sizeY*scale, 5);
    fill(0);
    textAlign(CENTER,CENTER);
    textFont(font);
    text(text,posX, posY);
    
  }
  
  boolean isMouseOver(){
    if (mouseX > posX-sizeX/2 && mouseX < posX+sizeX/2){
      if (mouseY >posY-sizeY/2 && mouseY < posY+sizeY/2){
        //scale = 0.9;
        return true;
      }
    }
    scale = 1;
    text = "BUTTON";
    return false;
  }
}

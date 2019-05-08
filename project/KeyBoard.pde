class KeyPad{

  ArrayList buttons;

  KeyPad(){
    buttons = new ArrayList<Button>();
    buttons.add(new Button(width/2, height/3-100, 'W'));  
    buttons.add(new Button(width/2, 2*height/3-130, 'A'));  
    buttons.add(new Button(width/2-230, 2*height/3-130, 'S'));  
    buttons.add(new Button(width/2+230, 2*height/3-130, 'D'));  
    buttons.add(new Button(width/2, 4*height/5-30, 660, 160, ' '));  
    
  }
  
  Button press(PVector pos){
        
    for(Button b: (ArrayList<Button>)buttons){
     if(b.hover(pos)){
        return b;
     }
    }
    return null;
  
  }
  
  void display(){
  
    for(Button b: (ArrayList<Button>)buttons){
      b.display();
    }
  }
}


class Button {
  
  int x, y, w, h;
  char text;
  String name;
  
  Button(int x, int y, char text){
    this.text = text;
    this.w = 200;
    this.h = 200;
    this.x = x - w/2;
    this.y = y - h/2;
    this.name = Character.toString(text);
  }

  Button(int x, int y, int w, int h, char text){
    this.text = text;
    this.w = w;
    this.h = h;
    this.x = x - w/2;
    this.y = y - h/2;
    this.name = "SPACE BAR";
  }  
  
  void display(){
    noFill();
    strokeWeight(3);
    textSize(60);

    rect(x, y, w, h, 10);
    text(this.text, this.x+w/2-20, this.y+h/2);
  }
  
  boolean hover(PVector pos) {
    if (pos.x > this.x && pos.x < this.x+this.w) {
      if (pos.y > this.y && pos.y < this.y+this.h) {
        return true;
      }
      return false;
    }
    return false;
  }   
}

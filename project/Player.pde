

class Player {
  
   PVector pos;
   
   Player(){
     
     // TODO: Noise is symmetric around (0,0). Figure out why and fix it
     this.pos = new PVector((int)random(40000, 60000), (int)random(40000, 60000)); 
 }

  /*
    Move the player in the world. Assumes that the move is valid according to the rules of Game.
  */
  void move(PVector move){
    pos.add(move); 
  }
  
  //void moveUp(){
  // pos.add(new PVector(0, -1));
  //}
  
  //void moveDown(){
  // pos.add(new PVector(0, 1));
  //}
 
  //void moveLeft(){
  // pos.add(new PVector(-1, 0));

  //}
 
  //void moveRight(){
  //  pos.add(new PVector(1, 0));
  //}
 
 void display(){
   
    fill(200);
    textSize(12);
    text('@', TILE_WIDTH*HRAD, TILE_HEIGHT*VRAD); 
 }
}

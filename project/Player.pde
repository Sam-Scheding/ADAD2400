

class Player {
  
   PVector pos;
   
   Player(PVector pos){
     
     this.pos = pos; 
 
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
    text('@', TILE_WIDTH*SCREEN_WIDTH, TILE_HEIGHT*SCREEN_HEIGHT); 
 }
}

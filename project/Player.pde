

class Player {

   PVector pos;
   PVector screenPos;
   int attackStrength;
   
   Player(PVector pos, PVector screenPos){
     this.pos = pos; 
     this.attackStrength = 30;
     this.screenPos = screenPos;
   }
  /*
    Move the player in the world. Assumes that the move is valid according to the rules of Game.
  */
  void move(PVector move){
    pos.add(move); 
  }
  
  void attack(){
    ExplosionAnimation ea = new ExplosionAnimation(screenPos, attackStrength);

  }
  
  void display(){
   
    fill(200);
    textSize(12);
    text('@', screenPos.x, screenPos.y); 
 }
}

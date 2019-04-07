

class Player {
   ExplosionAnimation ea;

   PVector pos;
   PVector screenPos;
   int attackStrength;
   
   Player(PVector pos, PVector screenPos){
     this.pos = pos; 
     this.attackStrength = 5;
     this.screenPos = screenPos;
     this.ea = new ExplosionAnimation(this.screenPos, 50);
   }
  /*
    Move the player in the world. Assumes that the move is valid according to the rules of Game.
  */
  void move(PVector move){
    pos.add(move); 
  }
  
  void attack(){
    int x = 0;
    while(x < ea.directions.length){
      ea.addParticle();
      x++;
    }

  }
  
  void display(){
   
    fill(200);
    textSize(12);
    text('@', screenPos.x, screenPos.y); 
 }
}

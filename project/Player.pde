

class Player extends Mob{

  Player(PVector location, float maxHealth){
     super('@', location, 30, maxHealth);
     this.icon = '@';
   }

  
  void attack(){
    // Creating the animation is as simple as this. 
    // It will be auto added to the list of things to animate, 
    // and then removed when it's finished.
    new ExplosionAnimation(screenPos, attackStrength);
    
  }
  
  void update(){
  
  }
  
  void display(){
   
    fill(200);
    textSize(12);
    text(this.icon, screenPos.x, screenPos.y); 
 }
 

}

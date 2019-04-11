

class Player extends Mob{
  
  float attackRadius = 4; // NUmber of tiles the attack should extend for
  float hunger;
  float maxHunger = 100;
  
  Player(PVector location, float maxHealth){
     super(Faces.PLAYER, location, 5, maxHealth);
     this.icon = Faces.PLAYER;
     this.hunger = 0;
  }

  
  void attack(){
    // Creating the animation is as simple as this. 
    // It will be auto added to the list of things to animate, 
    // and then removed when it's finished.
    new ExplosionAnimation(screenPos, attackRadius);
    entities.damage(location, attackRadius);
  }
  void update(){
  
  } 

  void display(){
   
    fill(200);
    textSize(12);
    text(this.icon, screenPos.x, screenPos.y); 
 }
 
 void move(PVector location){
   super.move(location);

   hud.setMessage(map.getOrCreateTile(this.location).message);
   this.hunger += 0.2;
 }
 
  void eat(float amount){
    this.hunger -= amount;
    this.hunger = constrain(this.hunger, 0, maxHunger);
  }
}

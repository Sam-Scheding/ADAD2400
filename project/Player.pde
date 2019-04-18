

class Player extends Entity{
  
  float attackRadius = 4; // NUmber of tiles the attack should extend for
  float hunger;
  float maxHunger = 100;
  
  Player(PVector location, float maxHealth){
     super(new PlayerTile(location), 5, maxHealth);
     this.hunger = 0;
  }

  
  void attack(){
    // Creating the animation is as simple as this. 
    // It will be auto added to the list of things to animate, 
    // and then removed when it's finished.
    new ExplosionAnimation(screen.playerPos, attackRadius);
    enemies.damage(this.location(), attackRadius);
  }
  void update(){
  
  } 

  void display(){
   
    fill(200);
    textSize(12);
    PVector pos = screen.getPosition(this.location());
    text(this.icon(), pos.x, pos.y); 
 }
 
 void move(PVector location){

   if(game.validMove(player.location(), location)){
     hud.setMessage(map.getOrCreateTile(PVector.add(player.location(), location)).message);
    
    if(DEBUG){ hud.currentTile = map.getOrCreateTile(PVector.add(player.location(), location)); }
   }
   super.move(location);
  
   this.hunger += 0.2;
 }
 
  void eat(float amount){
    this.hunger -= amount;
    this.hunger = constrain(this.hunger, 0, maxHunger);
  }
}

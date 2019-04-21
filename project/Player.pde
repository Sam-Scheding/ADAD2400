

class Player extends Entity{
  
  float attackRadius = 4; // NUmber of tiles the attack should extend for
  float attackStrength = 5; // Damage the attack does to entities inside the radius
  float hunger;
  float maxHunger = 100;
  float maxHealth;
  
  Player(PVector location, float maxHealth){
     super(location, new PlayerOverlay());
     this.hunger = 0;
     this.maxHealth = maxHealth;
     this.movable = true;
  }

  
  void attack(){
    // Creating the animation is as simple as this. 
    // It will be auto added to the list of things to animate, 
    // and then removed when it's finished.
    new ExplosionAnimation(screen.playerPos, attackRadius);
    entities.damage(this.location, attackRadius);
  }
 
 boolean move(PVector location){
   boolean success = super.move(location);
   if(success){
     hud.setMessage(map.getOrCreateTile(PVector.add(player.location, location)).message);
     if(DEBUG){ hud.currentTile = map.getOrCreateTile(PVector.add(player.location, location)); } // Show the tile the player is walking on in the HUD
   }
   this.hunger += 0.2;
   return success;
 }
 
  void eat(float amount){
    this.hunger -= amount;
    this.hunger = constrain(this.hunger, 0, maxHunger);

  }
  
  void tick(){};
}

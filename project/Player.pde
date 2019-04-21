float PLAYER_HEALTH = 100;
float PLAYER_MIN_HEALTH = 0;
float PLAYER_MAX_HEALTH = 100;
float MIN_HUNGER = 0;
float MAX_HUNGER = 100;

class Player extends LivingEntity{
  
  float attackRadius = 4; // NUmber of tiles the attack should extend for
  float attackStrength = 5; // Damage the attack does to entities inside the radius
  float hunger, minHunger, maxHunger;
  
  Player(PVector location){
     super(location, new PlayerOverlay(), PLAYER_HEALTH);
     this.hunger = 0;
     this.minHunger = MIN_HUNGER;
     this.maxHunger = MAX_HUNGER;
     this.minHealth = PLAYER_MIN_HEALTH;
     this.maxHealth = PLAYER_MAX_HEALTH;
     this.health = PLAYER_HEALTH;
     this.movable = true;
  }

  
  void attack(){
    // Creating the animation is as simple as this. 
    // It will be auto added to the list of things to animate, 
    // and then removed when it's finished.
    new ExplosionAnimation(screen.playerPos, attackRadius);

    // Next, cycle through enemies and damage any inside the player's attack radius
    Iterator itr = Store.getEnemies().iterator(); 
    Enemy e;
    
    // TODO: Rather than iterating over every entity, it's probably faster to get every entity within the radius
    while (itr.hasNext()){ 
      e = (Enemy)itr.next();
      float dist = PVector.dist(this.location, e.location);
      if(dist >= 0 && dist < this.attackRadius){
        e.takeDamage(this.attackStrength); // Deplete the enemy's health
      }
    }  
  }
 
 boolean move(PVector location){
   boolean success = super.move(location);
   if(success){
     hud.setMessage(map.getOrCreateTile(PVector.add(player.location, location)).message);
     if(DEBUG){ hud.currentTile = map.getOrCreateTile(PVector.add(player.location, location)); } // Show the tile the player is walking on in the HUD
   }
   return success;
 }
 
  void eat(float amount){
    this.hunger = constrain(this.hunger - amount, 0, maxHunger);

  }
  
  void tick(){
    
    // Check whether the player has died from injuries
    if(this.health <= this.minHealth){
      game.gameOver();
    }
 
   
    this.hunger = constrain(this.hunger + 0.2, this.minHunger, this.maxHunger);

    // Check whether the player has starved to death
    if(this.hunger >= this.maxHunger){
      game.gameOver();
    }
  }
}

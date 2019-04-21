import java.util.Iterator; 

float ENEMY_ATTACK_STRENGTH = 5;
float ENEMY_MAX_HEALTH = 4;

class Entities{
  
  void display(){
    for(Entity e: Store.getEntities()){
      e.display();
    }
  }
  
  void generate(PVector location){
    
    Tile tile = map.getOrCreateTile(location);
    // if an enemy should be generated
    if (random(1) > 1-ENEMY_PROB && tile.walkable) { 
      Store.saveEnemy(new Enemy(location));
    }
    
    // Scatter Food around the map
    if (random(1) > 1-FOOD_PROB) { 
      Store.saveFood(new Food(location));
    }
  }

  void tick(){
    
    Iterator itr = Store.getEnemies().iterator(); 
    Enemy e;
    
    while (itr.hasNext()){ 
      e = (Enemy)itr.next();
      e.tick();
    }
  }
}


abstract class Entity{

  PVector location;
  Overlay overlay;
  boolean movable;
  
  Entity(PVector location, Overlay overlay){
     this.location = location;
     this.overlay = overlay;
  }

  // Getters
  String icon(){ return this.overlay.face; }
  int x(){ return (int)this.location.x; }
  int y(){ return (int)this.location.y; }
  
  void display(){
    fill(200);
    textSize(12);
    PVector pos = screen.getPosition(this.location);
    //println(String.format("Drawing: %s at (%d, %d)", this.icon(), (int)pos.x, (int)pos.y));
    text(this.icon(), pos.x, pos.y); 
  }
}

class EdibleEntity extends Entity{
  
  float amount;
  
  EdibleEntity(PVector location, Overlay overlay){
    super(location, overlay);
    this.movable = false;
  }
  
}

class LivingEntity extends Entity{

  PVector startingLocation;
  float attackStrength;
  float attackRadius;
  float health;
  float minHealth = 0;
  float maxHealth;

  LivingEntity(PVector location, Overlay overlay, float maxHealth){
    super(location, overlay);
    this.startingLocation = location.copy();
    this.movable = true;
    this.health = maxHealth;
    this.maxHealth = maxHealth;
  }

  /*
    Move the entity in the world
  */
  boolean move(PVector direction){
    boolean valid = game.validMove(this.location, direction);
    if(valid && this.movable){ 
      this.location.add(direction);
    }
    return valid && this.movable;
  }
  
  void takeDamage(float amount){
    //println(String.format("%f < %f - %f < %f", this.minHealth, this.health, amount, this.maxHealth));
    this.health = constrain(this.health - amount, this.minHealth, this.maxHealth);
    if(this.health <= minHealth){
      Store.removeEnemy(this.startingLocation);
      Store.saveDeadEnemy(new DeadEnemy(this.location));
    }
  }
}

class Food extends EdibleEntity {
  
  PVector location;
  
  Food(PVector location){
    super(location, new FoodOverlay());
    this.amount = 5;
  }
}


class DeadEnemy extends EdibleEntity {
  
  DeadEnemy(PVector location){
    super(location, new DeadEnemyOverlay());
    this.amount = 10;
  }
}


class Enemy extends LivingEntity {
  
  float moveProb = 0.1;
  int state; // WANDER|ATTACK
  
  Enemy(PVector location){
    super(location, new EnemyOverlay(), ENEMY_MAX_HEALTH);
    this.state = MobStates.WANDER;
    this.movable = true;
    this.attackRadius = 1;
    this.attackStrength = ENEMY_ATTACK_STRENGTH;
  }
  
  void attack(){
    if(PVector.dist(this.location, player.location) <= this.attackRadius){
      println("HERE: " + this.attackStrength);
      player.takeDamage(this.attackStrength);
    }
  }
  
  void tick(){
    
      PVector direction = new PVector(0,0);
  
      // Decide whether the enemy should try to attack the player
      if(PVector.dist(this.location, player.location) < 10){
        state = MobStates.ATTACK;
      } else {
        state = MobStates.WANDER;
      }
      
      // Decide whether the enemy wanders this turn
      if(state == MobStates.WANDER && random(1) > 1-moveProb){
        direction = DIRECTIONS[(int)random(DIRECTIONS.length)];      
      } else if(state == MobStates.ATTACK){
        direction = PVector.sub(this.location, player.location);
        direction.limit(1.49);
        direction.rotate(PI);
        direction.x = (int)direction.x;
        direction.y = (int)direction.y;
        //println(direction);
        if(random(1) > 1-moveProb){ 
          direction = DIRECTIONS[(int)random(DIRECTIONS.length)];  // Enemies are too good, so slow them down a little
        }
      }
          
      this.move(direction);
      this.attack();
  }
}

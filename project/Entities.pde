import java.util.Iterator; 
/*
  
  
*/
class Entities{
  
  // This desperately needs to be done with a DB
  public ArrayList<Enemy> monsters;
  public ArrayList<DeadEnemy> corpses;
  
  Entities(){   
    monsters = new ArrayList<Enemy>();
    corpses = new ArrayList<DeadEnemy>();
  }
  
  void display(){
    for(Entity e: getEntities()){
      e.display();
    }
  }
  
  void generate(PVector location){
    
    // if an enemy should be generated
    if (random(1) > 1-ENEMY_PROB) { 
      println("Generated a new enemy");
      Enemy enemy = new Enemy(location); // Added to the list of entities in the constructor
      this.addEnemy(enemy);
    }
  }

  void tick(){
    
    Iterator itr = this.getEntities().iterator(); 
    Entity e;
    
    while (itr.hasNext()){ 
      e = (Entity)itr.next();
      e.tick();
    }
  }
  
  void addEnemy(Enemy e){
    this.monsters.add(e);
  }
  
  
   ArrayList<Entity> getEntities(){
   
     ArrayList<Entity> entities = new ArrayList<Entity>();
     entities.addAll(monsters);
     entities.addAll(corpses);
     //entities.addAll(food); // TODO
     return entities;
   }

  void damage(PVector location, float radius){
    Iterator itr = monsters.iterator(); 
    Enemy e;
    
    while (itr.hasNext()){ 
      e = (Enemy)itr.next();
      float dist = PVector.dist(location, e.location);
      if(dist > 0 && dist < radius){
        e.health -= player.attackStrength; // Deplete the enemy's health
        // If it has died, remove it from the entities list
        if(e.health <= 0){
          corpses.add(new DeadEnemy(e.location));
          itr.remove(); 
        }
      }
    }  
  }
  
  Entity get(PVector location){
    for(Entity e: this.getEntities()){
      if(e.location == location){
        return e;
      }
    }    
    return null;
  }
  
  void remove(PVector location){
    Iterator itr = this.getEntities().iterator(); 
    Entity e;
    
    while (itr.hasNext()){ 
      e = (Entity)itr.next();
      if(e.location == location && e.icon() != Faces.PLAYER){
        println("Removed: " + e.icon());
        itr.remove();
      }
    }
  }

}


abstract class Entity{

  PVector location;
  Overlay overlay;
  float health;
  float maxHealth;
  boolean movable;
  
  Entity(PVector location, Overlay overlay){
     this.location = location;
     this.overlay = overlay;
     this.health = maxHealth;
  }
  
  /*
    Move the entity in the world
  */
  boolean move(PVector move){
    boolean valid = game.validMove(this.location, move);
    if(valid && this.movable){ 
      this.location.add(move);
    }
    return valid && this.movable;
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
  
  abstract void tick();


}

class DeadEnemy extends Entity {

  
  DeadEnemy(PVector location){
    super(location, new DeadEnemyOverlay());
    this.movable = false;
  }
  
  void tick(){
  
  }
}


class Enemy extends Entity {
  
  float moveProb = 0.1;
  int state;
  int attackStrength = 5;
  int attackRadius = 1;
  int health = 5;
  int maxHealth = 5;
  
  Enemy(PVector location){
    super(location, new EnemyOverlay());
    this.state = MobStates.WANDER;
    this.movable = true;
  }
  
  void attack(){
  
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
        direction.normalize(); 
        direction.rotate(PI);
        //println(direction);
        if(random(1) > 1-moveProb){ 
          direction = DIRECTIONS[(int)random(DIRECTIONS.length)];  // Enemies are too good, so slow them down a little
        }
      }
          
      this.move(direction);
  }
}

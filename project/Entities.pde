import java.util.Iterator; 
/*
  Entities are objects that move independently in the world, such as enemies
*/
class Entities{
  
  ArrayList<Mob> entities;
  
  Entities(){
    entities = new ArrayList<Mob>();
  }

  void tick(){
    Iterator itr = entities.iterator(); 
    while (itr.hasNext()){ 
      Mob m = (Mob)itr.next();
      m.tick();
    }  
  }
  
  void add(Mob mob){
    entities.add(mob);
  }
  
  void damage(PVector location, float radius){
    Iterator itr = entities.iterator(); 
    while (itr.hasNext()){ 
      Mob m = (Mob)itr.next();
      float dist = PVector.dist(location, m.location);
      if(dist > 0 && dist < radius){
        m.health -= player.attackStrength; // Deplete the enemy's health
        // If it has died, remove it from the entities list
        if(m.isDead()){ 
          Store.saveTile(m.location, new DeadEnemyTile(m.location));
          itr.remove(); 
        
        }
      }
    }  
  }
}

abstract class Mob{

  String icon;
  PVector location;
  PVector screenPos;
  float attackStrength;
  float health;
  float maxHealth;
  
  Mob(String icon, PVector location, float attackStrength, float maxHealth){
     this.icon = icon;
     this.location = location;
     this.attackStrength = attackStrength;
     this.maxHealth = maxHealth;
     this.health = maxHealth;
     entities.add(this);
  }
  /*
    Move the entity in the world
  */
  void move(PVector move){
    if(game.validMove(location, move)){ 
      location.add(move); 
    }
  }
  
  void tick(){
    update();
    display();
  }
  
  boolean isDead(){
    if(health <= 0){
       return true;
    }
    return false;
  }
 
 abstract void update();
 abstract void display();


}

class Enemy extends Mob {
  
  float moveProb = 0.1;
  int state = MobStates.WANDER;
  
  Enemy(PVector location){
    super(Faces.ENEMY, location, 5, 1);
    
  }
  
  void attack(){
  
  }
  
  void update(){
    // Decide whether the enemy moves this turn
    if(random(1) > 1-moveProb){
      Tile tile = map.getOrCreateTile(location);
      move(DIRECTIONS[(int)random(DIRECTIONS.length)]);
      tile.face = Faces.LAND;
    }


  }
  
  void display(){
    Tile t = map.getOrCreateTile(location);   
    t.face = icon;
  }
  
  
}

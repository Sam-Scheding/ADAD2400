import java.util.Iterator; 
/*
  
  
*/
class Enemies{
  
  public ArrayList<Enemy> enemies;
  
  Enemies(){
    enemies = new ArrayList<Enemy>();
  }
  

  void tick(){
    
    Iterator itr = enemies.iterator(); 
    Entity ntt;
    
    while (itr.hasNext()){ 
      ntt = (Entity)itr.next();
      ntt.tick();
    }  
  }
  
  void add(Enemy mob){
    enemies.add(mob);
  }
  
  void damage(PVector location, float radius){
    Iterator itr = enemies.iterator(); 
    Enemy e;
    
    while (itr.hasNext()){ 
      e = (Enemy)itr.next();
      float dist = PVector.dist(location, e.location());
      if(dist > 0 && dist < radius){
        e.health -= player.attackStrength; // Deplete the enemy's health
        // If it has died, remove it from the entities list
        if(e.health <= 0){
          e.die();
          itr.remove(); 
        }
      }
    }  
  }
}

abstract class Entity{

  Tile tile;
  //PVector screenPos;
  float attackStrength;
  float health;
  float maxHealth;
  
  Entity(Tile tile, float attackStrength, float maxHealth){
     this.tile = tile;
     this.attackStrength = attackStrength;
     this.maxHealth = maxHealth;
     this.health = maxHealth;
  }
  /*
    Move the entity in the world
  */
  void move(PVector move){
    if(game.validMove(this.location(), move)){ 
      map.setTile(this.location(), new LandTile(this.location()));
      this.location().add(move); 
      map.setTile(this.location(), this.tile);
    }
  }
  
  // Getters
  String icon(){ return this.tile.face; }
  PVector location(){ return this.tile.location; }
  int x(){ return (int)this.tile.location.x; }
  int y(){ return (int)this.tile.location.y; }
  
  void tick(){
    update();
    display();
  }
   
  abstract void update();

  void display(){
    map.setTile(this.location(), this.tile);

  }
  



}

class Enemy extends Entity {
  
  float moveProb = 0.1;
  int state = MobStates.WANDER;
  
  Enemy(PVector location){
    super(new EnemyTile(location), 5, 1);
    enemies.add(this);

  }
  
  void attack(){
  
  }
  
  void update(){
    
    PVector direction = new PVector(0,0);
    Tile tile = map.getOrCreateTile(this.location());

    // Decide whether the enemy should try to attack the player
    if(PVector.dist(this.location(), player.location()) < 10){
      state = MobStates.ATTACK;
    } else {
      state = MobStates.WANDER;
    }
    
    // Decide whether the enemy wanders this turn
    if(state == MobStates.WANDER && random(1) > 1-moveProb){
      direction = DIRECTIONS[(int)random(DIRECTIONS.length)];      
    } else if(state == MobStates.ATTACK){
      direction = PVector.sub(this.location(), player.location());
      direction.normalize(); 
      direction.rotate(PI);
      if(random(1) > 1-moveProb){ 
        direction = DIRECTIONS[(int)random(DIRECTIONS.length)];  // Enemies are too good, so slow them down a little
      }
    }
        
    tile.face = Faces.LAND;
    move(direction);

  }
  
  void die(){
      map.setTile(this.location(), new DeadEnemyTile(this.location()));
  }
  
  
}

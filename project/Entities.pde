import java.util.Iterator; 
/*
  Entities are objects that move independently in the world, such as enemies
*/
class Entities{
  
  ArrayList<Mob> entities;
  
  Entities(){
    entities = new ArrayList<Mob>();
  }

  void renderAll(){
    Iterator itr = entities.iterator(); 
    while (itr.hasNext()){ 
      Mob m = (Mob)itr.next();
      game.renderFrame();
      m.tick();
      if(m.isDead()){ 
        itr.remove(); 
        game.renderFrame();
      }
    }  
  }
  
  void add(Mob mob){
    entities.add(mob);
  }
  
  void kill(PVector location, float radius){
    Iterator itr = entities.iterator(); 
    while (itr.hasNext()){ 
      Mob m = (Mob)itr.next();
      if(PVector.dist(location, m.location) < radius){
        m.health -= player.attackStrength; // Deplete the enemy's health
        if(m.isDead()){ itr.remove(); } // If it has died, remove it from the entities list
      }
    }  
  }
}

abstract class Mob{
  boolean hostile;
  char icon;
  PVector location;
  PVector screenPos;
  float attackStrength;
  float health;
  float maxHealth;
  
  Mob(char icon, PVector location, float attackStrength, float maxHealth){
     this.icon = icon;
     this.location = location;
     this.attackStrength = attackStrength;
     this.maxHealth = maxHealth;
     this.health = maxHealth;
     entities.add(this);
  }
  
  /*
    Move the player in the world. Assumes that the move is valid according to the rules of Game.
  */
  void move(PVector move){
    location.add(move); 
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
  
  char[] icons = new char[30];
  int iconSpeed = 5;
  
  Enemy(PVector location){
    super('%', location, 5, 1);
  for(int i = 0; i < icons.length; i++){ 
    icons[i] = (char)random(42, 47);
  }

  }
  
  void attack(){
  
  }
  
  void update(){
    if(TICK%iconSpeed == 0){
      int index = (int)random(icons.length);
      icon = icons[index];
    }
  }
  
  void display(){
    Tile t = map.getOrCreateTile(location);   
    t.face = icon;
  }
  
  
}

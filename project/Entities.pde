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
      game.renderFrame();
      Mob m = (Mob)itr.next();
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
  
  char[] icons = {30};
  Enemy(PVector location){
    super('%', location, 5, 1);
    for(int i = 0; i < icons.length; i++){ icons[i] = char(92+i); }

  }
  
  void attack(){
  
  }
  
  void update(){
    icon = icons[(int)random(icons.length)];
    println("This is running");
  }
  
  void display(){
    PVector screenPos = screen.getPosition(location);
    fill(200);
    textSize(12);
    text(this.icon, screenPos.x, screenPos.y);   
  }
  
  
}

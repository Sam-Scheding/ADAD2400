/*
  This class handles game rules like whether the player can walk on a particular tile etc.
*/

long TICK = 0;

// Array of valid movement vectors that the player and other mobs can take
PVector[] DIRECTIONS = {
  new PVector(0,-1),
  new PVector(-1,0),
  new PVector(0,1),
  new PVector(1,0),
};


class Game{
  

  Game(){
  }
  

  
  boolean validMove(PVector location, PVector move){
    
    PVector newLocation = PVector.add(location, move); // Turns out you can invoke add() statically like this. Much wow.
    Tile tile = map.getOrCreateTile(newLocation);

    if(tile.walkable){
      return true;
    }
    return false;
  }
  
  
  void tick(){
  
     Entity e = entities.get(player.location);
     if(e == null){ return; } // No entity at player locationd
     
     //if(tile.face in Store.edible) // TODO
     if(e.icon() == Faces.FOOD || e.icon() == Faces.DEAD_MOB){
       player.eat(20);
       println("Trying to remove: ");
       entities.remove(player.location);
     }
  }
}

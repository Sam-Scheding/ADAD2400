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
  
  boolean validMove(PVector location, PVector move){
    
    PVector newLocation = PVector.add(location, move); // Turns out you can invoke add() statically like this. Much wow.
    Tile tile = map.getOrCreateTile(newLocation);

    if(tile.walkable){
      return true;
    }
    return false;
  }
  
  void gameOver(){
    
    screen.popup("GAME OVER");
  
  }
  void tick(){
      
     ArrayList<Entity> edibles = Store.getEdibles();
     Iterator itr = edibles.iterator();
     EdibleEntity e;
     while(itr.hasNext()){
         e = (EdibleEntity)itr.next();
         if((int)e.location.x == player.x() && (int)e.location.y == player.y()){
            player.eat(e.amount);
            Store.removeEdible(e);
         }
     }
     
     
  }
}

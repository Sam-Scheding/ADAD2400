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
  
   // This whole thing is gonna get messy as fuck

   Tile tile = map.getOrCreateTile(player.location());
   if(tile.face == Faces.FOOD){
     FoodTile food = (FoodTile)tile;
     player.eat(food.amount);
     Store.saveTile(player.location(), new LandTile(player.location()));
   } else if(tile.face == Faces.DEAD_MOB){
     player.eat(20);
     Store.saveTile(player.location(), new LandTile(player.location()));
   
   }
  }

}

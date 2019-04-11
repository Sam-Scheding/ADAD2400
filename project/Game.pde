/*
  This class handles game rules like whether the player can walk on a particular tile etc.
*/

class Game{
  

  Game(){
    player.screenPos = screen.getPosition(player.location);
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
  
   // This whole thing is messy as fuck
   Tile tile = map.getOrCreateTile(player.location);
   if(tile.face == Faces.FOOD){
     FoodTile food = (FoodTile)tile;
     player.eat(food.amount);
     Store.saveTile(player.location, new LandTile(player.location));
   } else if(tile.face == Faces.DEAD_MOB){
     DeadEnemyTile food = (DeadEnemyTile)tile;
     player.eat(food.amount);
     Store.saveTile(player.location, new LandTile(player.location));
   
   }

  
  }

}

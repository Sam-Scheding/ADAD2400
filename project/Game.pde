/*
  This class handles game rules like whether the player can walk on a particular tile etc.
*/

class Game{
  

  Game(){
    player.screenPos = screen.getPosition(player.location);
  }
  
  boolean validMove(PVector move){
    
    PVector location = PVector.add(player.location, move); // Turns out you can invoke add() statically like this. Much wow.
    Tile tile = map.getOrCreateTile(location);

    hud.setMessage(tile.message);

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
     Store.saveTile(player.location, new LandTile((int)player.location.x, (int)player.location.y));
   } else if(tile.face == Faces.DEAD_MOB){
     DeadEnemyTile food = (DeadEnemyTile)tile;
     player.eat(food.amount);
     Store.saveTile(player.location, new LandTile((int)player.location.x, (int)player.location.y));
   
   }

  
  }

}

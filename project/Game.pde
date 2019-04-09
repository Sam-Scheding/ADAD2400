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
    if(tile.walkable){
      return true;
    } else {
      
      // If the tile the player is trying to move to is a building, then 
      // Display a message, and ask the player if they want to enter.
      if(tile.face == 'B'){
        hud.setMessage(tile.message);
      }
    }
    return false;
  }
  
  
  void tick(){
  
   // If it's a food tile, show the message and replete the player's hunger
   Tile tile = map.getOrCreateTile(player.location);
   if(tile.face == '.'){
     FoodTile food = (FoodTile)tile;
     hud.setMessage(tile.message);
     player.eat(food.amount);
     Store.saveTile(player.location, new LandTile((int)player.location.x, (int)player.location.y));
   }

  
  }

}

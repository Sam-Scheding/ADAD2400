/*
  This class handles game rules like whether the player can walk on a particular tile etc.
*/

class Game{
  

  Game(){
    player.screenPos = screen.getPosition(player.location);
  }
  
  boolean validMove(PVector move){
    
    PVector coord = PVector.add(player.location, move); // Turns out you can invoke add() statically like this. Much wow.
    Tile tile = map.getOrCreateTile(coord);
    if(tile.walkable){
      return true;
    }
    return false;
  }
  
  

}

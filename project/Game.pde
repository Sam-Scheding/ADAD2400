/*
  This class handles game rules like whether the player can walk on a particular tile etc.
*/

class Game{
  
  Player player;
  Map map;
  
  Game(Player player, Map map){
    this.player = player;
    this.map = map;
  }
  
  boolean validMove(PVector move){
    
    PVector coord = PVector.add(player.pos, move); // Turns out you can invoke add() statically like this. Much wow.
    Tile tile = map.getOrCreateTile(coord);
    if(tile.walkable){
      return true;
    }
    return false;
  }
  
}

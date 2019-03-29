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
  
  
  /*
    Using draw() was overkill since you only actually need to draw the screen again 
    if the player moves. So I wrote this render function that draws everything. It's called
    when player movement is detected, and other necessary places.
  
  */
  void render(){
    Tile tile;
  
    background(BG_COLOUR);
  
    // First draw the map
    // Need to keep track of rows and cols here, since the player's global position in the world could be wayyy outside the screen
    int row = 0, col = 0;
    // Iterate over all the tiles around the player (from - to + vertical and horizontal radii)
    for (int y = (int)player.pos.y-VRAD; y <= player.pos.y+VRAD; y++) {
      for (int x = (int)player.pos.x-HRAD; x <= player.pos.x+HRAD; x++) {
        
        tile = map.getOrCreateTile(x, y);
        map.display(tile, col, row);
        //println(x + ":" + y);
        col++;
      }
      row++;
      col=0;
    }
    
    //Then overlay the player on the map
    player.display();
  }
    
}

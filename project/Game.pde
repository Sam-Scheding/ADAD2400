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
  void renderFrame(){
    Tile tile;
  
    background(BG_COLOUR);
    fill(200);
    textSize(12);

    // First draw the map
    // x and y represent the tile's global coordinates, row and col where on the screen the tile is shown
    int row = 0, col = 0;
    // Iterate over all the tiles around the player (from - to + vertical and horizontal radii)
    for (int y = (int)player.pos.y-SCREEN_HEIGHT; y <= player.pos.y+SCREEN_HEIGHT; y++) {
      for (int x = (int)player.pos.x-SCREEN_WIDTH; x <= player.pos.x+SCREEN_WIDTH; x++) {
        
        // Regardless of whether the tile is displayed, we still need to create it. 
        // It might be a city in the distance or something
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

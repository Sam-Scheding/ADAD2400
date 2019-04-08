


class Screen{

  Screen(){

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
    for (int y = (int)player.location.y-SCREEN_HEIGHT; y <= player.location.y+SCREEN_HEIGHT; y++) {
      for (int x = (int)player.location.x-SCREEN_WIDTH; x <= player.location.x+SCREEN_WIDTH; x++) {
        
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
    hud.display();
  }
  
  /*
    returns true if the location is currently within the coordinates
    that are currently being rendered to the screen, false otherwise.
  */
  boolean onScreen(PVector location){
    if(location.x > player.location.x - SCREEN_WIDTH 
    && location.x < player.location.x + SCREEN_WIDTH
    && location.y > player.location.y - SCREEN_HEIGHT
    && location.y < player.location.y + SCREEN_HEIGHT){
      return true;    
    }  
    return false;
  }
  
  PVector getPosition(PVector location){

    // Map the entity's global coordinates on the map to a position on the screen
    float x = map(location.x, player.location.x-SCREEN_WIDTH, player.location.x+SCREEN_WIDTH, 0-TILE_WIDTH/2, width-TILE_WIDTH/2);
    float y = map(location.y, player.location.y-SCREEN_HEIGHT, player.location.y+SCREEN_HEIGHT, 0-TILE_HEIGHT/2, height-TILE_HEIGHT/2);
    return new PVector(x, y);
  }
}

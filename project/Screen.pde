
int BG_COLOUR = 10;
int STROKE_COLOUR = 255;

// Size/Shape of the canvas
int ROWS = 45;
int COLS = 90;
int CANVAS_VRAD = ceil(ROWS/2); // Vertical radius of the canvas
int CANVAS_HRAD = ceil(COLS/2); // Horizontal radius of the canvas

// Tile Stuff
int TILE_WIDTH;
int TILE_HEIGHT;

PVector playerPos;

class Screen{
  
  PVector playerPos;
  
  Screen(){

    TILE_WIDTH = floor(width/COLS);
    TILE_HEIGHT = floor(height/ROWS);
    playerPos = this.getPosition(player.location());

  }
  
  /*
    Using draw() was overkill since you only actually need to draw the screen again 
    if the player moves. So I wrote this render function that draws everything. It's called
    when player movement is detected, and other necessary places.
    
    If something needs to be rendered in realtime, as opposed to on a turn-by-turn basis, have a 
    look at Animations
  
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
    for (int y = (int)player.y() - CANVAS_VRAD; y <= player.y()+CANVAS_VRAD; y++) {
      for (int x = (int)player.x()-CANVAS_HRAD; x <= player.x()+CANVAS_HRAD; x++) {
        
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
    if(location.x > player.x() - CANVAS_HRAD 
    && location.x < player.x() + CANVAS_HRAD
    && location.y > player.y() - CANVAS_VRAD
    && location.y < player.y() + CANVAS_VRAD){
      return true;    
    }  
    return false;
  }
  
  PVector getPosition(PVector location){

    // Map the entity's global coordinates on the map to a position on the screen
    float x = map(location.x, player.x()-CANVAS_HRAD, player.x()+CANVAS_HRAD, 0-TILE_WIDTH/2, width-TILE_WIDTH/2);
    float y = map(location.y, player.y()-CANVAS_VRAD, player.y()+CANVAS_VRAD, 0-TILE_HEIGHT/2, height-TILE_HEIGHT/2);
    return new PVector(x, y);
  }
}

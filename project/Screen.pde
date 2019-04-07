


class Screen{

  Screen(){

  }
  
  PVector getPosition(PVector location){

    // Map the entity's global coordinates on the map to a position on the screen
    float x = map(location.x, player.location.x-SCREEN_WIDTH, player.location.x+SCREEN_WIDTH, 0-TILE_WIDTH/2, width-TILE_WIDTH/2);
    float y = map(location.y, player.location.y-SCREEN_HEIGHT, player.location.y+SCREEN_HEIGHT, 0-TILE_HEIGHT/2, height-TILE_HEIGHT/2);
    return new PVector(x, y);
  }
}

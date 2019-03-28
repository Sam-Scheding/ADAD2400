

/*
  This is the Base Tile class. You should never instantiate one of these (hence why it's abstract).
  All the actual tiles build upon this.
*/
abstract class Tile {
  
  int x, y, h, w;
  float pVal;
  char face;
  boolean walkable;
  
  Tile(int x, int y){
    this.x = x;
    this.y = y;
    this.h = TILE_HEIGHT;
    this.w = TILE_WIDTH;
    this.pVal = noise(x*NOISE_SCALE, y*NOISE_SCALE) * 255;
  }


}



class WaterTile extends Tile {
   
  WaterTile(int x, int y){
    super(x, y);
    this.face = '~';
    this.walkable = false;
  } 
}



class LandTile extends Tile {
   
  LandTile(int x, int y){
    super(x, y);
    this.face = ' ';
    this.walkable = true;

  }
  
}


class TreeTile extends Tile {
   
  TreeTile(int x, int y){
    super(x, y);
    this.face = 'T';
    this.walkable = false;
    
  }
  
}




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

  // Return the currect tile's coordinates as a vector
  PVector location(){
     return new PVector(x, y); 
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

  // Invoke this to show hidden special tiles like city centres in development
  LandTile(int x, int y, char face){ 
    super(x, y);
    this.face = face;
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


/*
  This represents the centre of a city
  It has a CITY_PROB chance of generating in any walkable tile
  All CityCentreTiles are added to a list of cities in Map.java.
  every other available tile is checked for it's proximity to a 
  city centre and then, if closer than CITY_RADIUS, it is converted to 
  a BuildingTile
*/
class CityCentreTile extends Tile {

  int radius;
  
  CityCentreTile(int x, int y){
    super(x, y);
    this.face = '*';
    this.walkable = false;  
    this.radius = (int)random(CITY_RADIUS);
  }
  
}

class BuildingTile extends Tile {
   
  String message;
  
  BuildingTile(int x, int y){
    super(x, y);
    this.face = 'B';
    this.walkable = false;
    this.message = BUILDING_MESSAGES[(int)random(BUILDING_MESSAGES.length)];    
  }
   
}

class StreetTile extends Tile {
   
  StreetTile(int x, int y){
    super(x, y);
    this.face = '.';
    this.walkable = true;
    
  }
  
}

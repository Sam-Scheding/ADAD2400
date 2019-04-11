


/*
  This is the Base Tile class. You should never instantiate one of these (hence why it's abstract).
  All the actual tiles build upon this.
*/
abstract class Tile {
  
  int x, y, h, w;
  float pVal;
  String face;
  boolean walkable;
  String message = "";

  Tile(int x, int y){
    this.x = x;
    this.y = y;
    this.h = TILE_HEIGHT;
    this.w = TILE_WIDTH;
    this.pVal = noise(x*NOISE_SCALE, y*NOISE_SCALE) * 255;
  }


  // Invoke this to show hidden special tiles like city centres in development
  Tile(int x, int y, String face){ 
    this.x = x;
    this.y = y;
    this.h = TILE_HEIGHT;
    this.w = TILE_WIDTH;
    this.pVal = noise(x*NOISE_SCALE, y*NOISE_SCALE) * 255;
    this.face = face;

  }  

  // Return the currect tile's coordinates as a vector
  PVector location(){
     return new PVector(x, y); 
  }
}

class WaterTile extends Tile {
   
  WaterTile(int x, int y){
    super(x, y);
    this.face = Faces.WATER;
    this.walkable = false;
  } 
}



class LandTile extends Tile {
   
  LandTile(int x, int y){
    super(x, y);
    this.face = Faces.LAND;
    this.walkable = true;

  }
}


class TreeTile extends Tile {
   
  TreeTile(int x, int y){
    super(x, y);
    this.face = Faces.TREE;
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
    this.face = Faces.CITY_CENTRE;
    this.walkable = false;  
    this.radius = (int)random(City.MIN_RADIUS, City.MAX_RADIUS);
  }
  
}

class BuildingTile extends Tile {
   
  
  BuildingTile(int x, int y){
    super(x, y);
    this.face = Faces.BUILDING;
    this.walkable = false;
    this.message = Messages.BUILDINGS[(int)random(Messages.BUILDINGS.length)];    
  }
 
}

class FoodTile extends Tile {
  float amount;
  
  FoodTile(int x, int y){
    super(x, y);
    this.face = Faces.FOOD;
    this.walkable = true;
    this.message = Messages.FOOD[(int)random(Messages.FOOD.length)];    
    this.amount = 10;
  }
}

class DeadEnemyTile extends Tile {
  float amount;
  
  DeadEnemyTile(int x, int y){
    super(x, y);
    this.face = Faces.DEAD_MOB;
    this.walkable = true;
    this.message = Messages.DEAD_ENEMIES[(int)random(Messages.DEAD_ENEMIES.length)];    
    this.amount = 20;
  }
  
  DeadEnemyTile(PVector location){
    super((int)location.x, (int)location.y);
    this.face = Faces.DEAD_MOB;
    this.walkable = true;
    this.message = Messages.DEAD_ENEMIES[(int)random(Messages.DEAD_ENEMIES.length)];    
    this.amount = 20;
  }
}

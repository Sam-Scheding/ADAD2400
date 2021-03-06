
abstract class Overlay {
  
  String face;

}

class FoodOverlay extends Overlay {
  FoodOverlay(){
    super();
    this.face = Faces.FOOD;
  }
}

class PlayerOverlay extends Overlay {
  
  PlayerOverlay(){
    super();
    this.face = Faces.PLAYER;
  }
}

class EnemyOverlay extends Overlay {
  
  
  EnemyOverlay(){
    super();
    this.face = Faces.ENEMY;
  }
}

class DeadEnemyOverlay extends Overlay {

  DeadEnemyOverlay(){
    super();
    this.face = Faces.DEAD_MOB;
  }
}

/*
  This is the Base Tile class. You should never instantiate one of these (hence why it's abstract).
  All the actual tiles build upon this.
*/
abstract class Tile {
  
  PVector location;
  int x, y, h, w;
  float pVal;
  String face;
  boolean walkable;
  String message = "";
  color colour;
  
  Tile(PVector location){
    this.location = location;
    this.x = (int)location.x;
    this.y = (int)location.y;
    this.h = TILE_HEIGHT;
    this.w = TILE_WIDTH;
    this.pVal = noise(x*NOISE_SCALE, y*NOISE_SCALE) * 255;
  }
}

class WaterTile extends Tile {
   
  WaterTile(PVector location){
    super(location);
    this.face = Faces.WATER;
    this.walkable = false;
  } 
}



class LandTile extends Tile {
   
  LandTile(PVector location){
    super(location);
    this.face = Faces.LAND;
    this.walkable = true;

  }
}


class TreeTile extends Tile {
   
  TreeTile(PVector location){
    super(location);
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
  
  CityCentreTile(PVector location){
    super(location);
    this.face = Faces.CITY_CENTRE;
    this.walkable = false;  
    this.radius = (int)random(City.MIN_RADIUS, City.MAX_RADIUS);
  }
  
}

class BuildingTile extends Tile {
   
  
  BuildingTile(PVector location){
    super(location);
    this.face = Faces.BUILDING;
    this.walkable = false;
    this.message = Messages.BUILDINGS[(int)random(Messages.BUILDINGS.length)];    
  }
 
}

class FoodTile extends Tile {
  float amount;
  
  FoodTile(PVector location){
    super(location);
    this.face = Faces.FOOD;
    this.walkable = true;
    this.message = Messages.FOOD[(int)random(Messages.FOOD.length)];    
    this.amount = 10;
  }
}

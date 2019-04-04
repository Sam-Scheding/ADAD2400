
/*
  This is the representation of the world.
 
 It generates (or retrieves) any tiles in the currently visible area.
 
 Perlin Noise is super slow, and even on a 50x80 grid the lag is
 noticable if every visible tile is generated at every iteration. To combat 
 this, every time a tile is generated, I store it in a HashMap. When
 drawing the current viewable map area, I can get any tiles that have 
 already been generated out of the HashMap instead of doing all that work again. 
 Technically, this is called Dynamic Programming, but it's actually just common sense. 
 
 TODO: If a user plays on the same map for a long time. This HashMap will 
 get fucking huge. Write something that stops this. either:
 - add a variable to each tile counting how many times it's been loaded (hence how important it is)
 - randomly delete half the entries every x turns
 - something smarter
 */
class Map {

  HashMap<PVector, Tile> map;
  ArrayList<Tile> cities;

  Map() {
    map = new HashMap<PVector, Tile>();
    cities = new ArrayList<Tile>();
  }

  /*
    It's possible for the player to spawn in on a non-walkable tile. So rather than just randomly 
   assigning a starting position to them, keep generating Tiles until one is walkable.
   */
  PVector getRandomWalkableTile() {
    PVector location;
    Tile tile;

    if (DEBUG) { 
      return new PVector(0, 0);
    } // Remove randomness if debugging

    do {

      // TODO: Noise is symmetric around (0,0). Figure out why and fix it      
      location = new PVector((int)random(-60000, 60000), (int)random(-60000, 60000));
      tile = getOrCreateTile(location);
    } while (!tile.walkable);

    return location;
  }
  /*
    If the tile already exists in the HashMap, just return that
   otherwise make a new one, add it to the HashMap and return it.
   */
  Tile getOrCreateTile(int x, int y) {

    PVector location = new PVector(x, y);
    Tile tile;
    // First try to get the tile from the map. 
    tile = Store.getTile(location);

    // If it doesn't exist, this is eaither the first time the player has 
    // seen this tile, or they have been away for so long the tile has unloaded.
    // So make a new tile and add it to the map for later
    if (tile == null) {
      tile = createTile(x, y);
      Store.saveTile(location, tile);
    }     
    return tile;
  }

  // Overloading the method cos I probably should have just used a PVec in the first place.
  Tile getOrCreateTile(PVector location) {
    return getOrCreateTile((int)location.x, (int)location.y);
  }

  /*
    Get a tile if it's within a radius of an x,y coord
  */
  Tile getOrCreateTile(PVector location, int radius) {
    return getOrCreateTile((int)location.x, (int)location.y);
  }




  /*
   Having a huge list of conditionals seems dumb, but I can't think of another way to do this
   (maybe a switch statement?). Basically, this is where the Perlin noise juice happens. It generates
   a perlin value based on the x:y coord and if it's below a certain value, makes it water, if it's
   above a certain value makes it a tree, else makes it just ground.
   
   If the tile is a ground tile, also give it a chance to become a city. If it's chosen as a city, 
   then generate a city around that location
   
   This isn't perfect, since it's difficult to extend upon, but it's good for now.
   */
  Tile createTile(int x, int y) {

    Tile tile;
    float val = noise(x * NOISE_SCALE, y * NOISE_SCALE) * 255;

    // Check whether Perlin noise dictates whether the tile should be a tree, or water
    if (val > 170) { return new TreeTile(x, y); } 
    if (val < 90) { return new WaterTile(x, y); }


    // If the tile is chosen as a city centre, create the city
    if (random(1) > 1-CITY_PROB) { 
      CityCentreTile cityTile = new CityCentreTile(x, y);
      createCity(cityTile); 
      return cityTile;
    }

    tile = new LandTile(x, y);

    return tile;
  }


  // Render the tile to the screen
  void display(Tile tile, int x, int y) {
    text(tile.face, x*tile.w, y*tile.h);
  }
  
  /*
     Create a city from a central location
  */
  void createCity(CityCentreTile city){

    if (DEBUG) { city.face = '*'; } // show the middle of the city in debug mode
    
    // Add the city to the list
    cities.add(city); // TODO: This might not be necessary anymore
    
    // Iterate over the bounding square of the city
    for(int y = city.y - city.radius; y < city.y + city.radius; y++){
      for(int x = city.x - city.radius; x < city.x + city.radius; x++){
        
        // Use the radius of the city to create building tiles in a circle within the bounding box
        PVector location = new PVector(x, y);
        float dist = PVector.dist(location, city.location());
        if (dist < city.radius) { // If the tile is within city limits
          if (x % 3 != 0 && y % 3 != 0) { // This creates the 2x2 grid of buildings. i.e. a city block

            // Crumble the buildings into the landscape
            if(randomGaussian() * 1/dist < city.radius * 1/10){ // TODO: This needs tweaking
              Store.saveTile(location, new BuildingTile(x, y));
            }
          }
        }
      }        
    }
  } 
}

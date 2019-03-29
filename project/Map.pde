
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

  Map(){
    map = new HashMap<PVector, Tile>();
      
  }
  
  /*
    It's possible for the player to spawn in on a non-walkable tile. So rather than just randomly 
    assigning a starting position to them, keep generating Tiles until one is walkable.
  */
  PVector getRandomWalkableTile(){
    PVector pos;
    Tile tile;
    do {
 
      // TODO: Noise is symmetric around (0,0). Figure out why and fix it      
      pos = new PVector((int)random(-60000, 60000), (int)random(-60000, 60000));
      tile = getOrCreateTile(pos);
      
    } while(!tile.walkable);

    return pos;
  }
  /*
    If the tile already exists in the HashMap, just return that
    otherwise make a new one, add it to the HashMap and return it.
  */
  Tile getOrCreateTile(int x, int y){
     
     PVector k = constructKey(x, y);
     Tile tile;
     // First try to get the tile from the map. 
     tile = map.get(k);

     // If it doesn't exist, this is eaither the first time the player has 
     // seen this tile, or they have been away for so long the tile has unloaded.
     // So make a new tile and add it to the map for later
     if(tile == null){
        tile = createTile(x, y);
        map.put(k, tile);
     }
     
     return tile;
  }
  
  // Overloading the method cos I probably should have just used a PVec in the first place.
  Tile getOrCreateTile(PVector coord){
    return getOrCreateTile((int)coord.x, (int)coord.y);
  }
  
  /*
    PVector is a great key for the has map, since it uniquely defines any x,y coord
  */
  PVector constructKey(int x, int y){
    return new PVector(x, y); 
  }
  
  
  /*
    Having a huge list of conditionals seems dumb, but I can't think of another way to do this
    (maybe a switch statement?). Basically, this is where the Perlin noise juice happens. It generates
    a perlin value based on the x:y coord and if it's below a certain value, makes it water, if it's
    above a certain value makes it a tree, else makes it just ground.
    
    This isn't perfect, since it's difficult to extend upon, but it's good for now.
  */
  Tile createTile(int x, int y){
     
    Tile tile;
    float val = noise(x * NOISE_SCALE, y * NOISE_SCALE) * 255;
  
    if (val > 170) {
      tile = new TreeTile(x, y);
    } else if (val < 90) {
      tile = new WaterTile(x, y);
    } else {
      tile = new LandTile(x, y);
    }
    return tile;
  }
  
  void display(Tile tile, int x, int y) {
    fill(200);
    textSize(12);
    text(tile.face, x*tile.w, y*tile.h);
  }

}

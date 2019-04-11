/*
  This class stores all previously generated tiles
  
  Currently this uses memory, but will later be a connector class for a DB
*/

static class Store{
  
 static HashMap<PVector, Tile> map = new HashMap<PVector, Tile>(); 
 
 static void saveTile(PVector location, Tile tile){
    map.put(location, tile);   
 }
 
 static Tile getTile(PVector location){
   return map.get(location);
 }
 
 static void removeTile(PVector location){
   map.remove(location);
 }
}

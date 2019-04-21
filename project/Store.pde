import java.util.List;

/*
  This class stores all previously generated tiles
  
  Currently this uses memory, but will later be a connector class for a DB
*/

static class Store{
  
   static HashMap<PVector, Tile> map = new HashMap<PVector, Tile>(); 
   static HashMap<PVector, Enemy> enemies = new HashMap<PVector, Enemy>(); ;
   static HashMap<PVector, DeadEnemy> corpses = new HashMap<PVector, DeadEnemy>();
   static HashMap<PVector, Food> food = new HashMap<PVector, Food>(); ;

   static void saveTile(PVector location, Tile tile){ map.put(location, tile); }
   static Tile getTile(PVector location){ return map.get(location); }
   static void removeTile(PVector location){ map.remove(location); }
   
   static void saveEnemy(Enemy e){ enemies.put(e.startingLocation, e); }
   static ArrayList<Enemy> getEnemies(){ return new ArrayList<Enemy>(enemies.values()); }
   static void removeEnemy(PVector location){ enemies.remove(location); }
 
   static ArrayList<DeadEnemy> getDeadEnemies(){ return new ArrayList<DeadEnemy>(corpses.values()); }
   static void saveDeadEnemy(DeadEnemy e){ corpses.put(e.location, e); }
  
   static ArrayList<Entity> getEdible(){
     List<Food> f = new ArrayList<Food>(food.values());
     List<DeadEnemy> d = new ArrayList<DeadEnemy>(corpses.values());
  
     ArrayList<Entity> edible = new ArrayList<Entity>();
     edible.addAll(f);
     edible.addAll(d);
     return edible;
   }
  
   static void saveFood(Food f){ food.put(f.location, f); }

   static ArrayList<Entity> getEntities(){
     List<Food> f = new ArrayList<Food>(food.values());
     List<DeadEnemy> d = new ArrayList<DeadEnemy>(corpses.values());
     List<Enemy> e = new ArrayList<Enemy>(enemies.values());
  
     ArrayList<Entity> entities = new ArrayList<Entity>();
     entities.addAll(f);
     entities.addAll(d);
     entities.addAll(e);
     return entities;
   }
   
}

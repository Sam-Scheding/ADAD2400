/*
  Basically a settings file, but organised into static classes so it's clearer what everything does
*/

/*
  All possible tile faces
*/
static class Faces{
  
  static String PLAYER = "@";
  static String TREE = "T";
  static String LAND = " ";
  static String FOOD = ".";
  static String CITY_CENTRE = "*";
  static String BUILDING = "B";
  static String WATER = "~";
  static String ENEMY = "\u00d8"; // Ø
  static String DEAD_MOB = "†";

}

static class City{

  static float PROBABILITY = 0.0005; // 0.05% chance per valid tile to generate a city
  static int MIN_RADIUS = 3; // The minimum radius a city can have
  static int MAX_RADIUS = 10; // The maximum radius a city can have

}

static class MobStates{
  static int WANDER = 0;
  static int ATTACK = 1;
}

static class Messages{
  static String[] BUILDINGS = {
    "The building is decrepit and slowly crumbling into the landscape.",
    "Darkness eminates from inside the building.",
  };

  static String[] FOOD = {
    "You find some rotten scraps on the ground. It'll do for now.",
  };

  static String[] DEAD_ENEMIES = {
    "You've killed it,  but it's carcass has already begun to rot. You can only scavenge a meager amount of food.",
  };

}

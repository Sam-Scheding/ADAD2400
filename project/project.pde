
// Debugging stuff
boolean DEBUG = false;

// Procedural Generation Stuff
int SEED = (int)random(MIN_INT, MAX_INT);

float CITY_PROB = 0.0005; // 0.05% chance per valid tile to generate a city
int CITY_RADIUS = 10; // The maximum radius a city can have

float MOB_PROB = 0.001;

// Perlin Noise Stuff
float NOISE_SCALE = 0.1;

// Tile Stuff
int ROWS = 45;
int COLS = 90;
int TILE_WIDTH;
int TILE_HEIGHT;
String[] BUILDING_MESSAGES = {
  "The building is decrepit and slowly crumbling into the landscape.",
  "Darkness eminates from inside the building.",
};


// Size/Shape of the canvas
int SCREEN_HEIGHT = ceil(ROWS/2); // Vertical radius of the screen
int SCREEN_WIDTH = ceil(COLS/2); // Horizontal radius of the screen

// The map needs to be rendered outside the players view so that cities don't magically appear
// as the player gets close to them
int V_RENDER_DISTANCE = SCREEN_HEIGHT + CITY_RADIUS;
int H_RENDER_DISTANCE = SCREEN_WIDTH + CITY_RADIUS;

// Window Stuff
int WIDTH, HEIGHT;
int BG_COLOUR = 10;
Screen screen;

// Game Stuff
long TICK = 0;
Map map;
Player player;
Game game;
HUD hud;
Animations animations;
Entities entities; // Similar to animations


void setup() {
  if(DEBUG){ SEED = MAX_INT; }
  noiseSeed(SEED); // Set seed for Perlin Noise
  randomSeed(SEED); // Set seed for other RNG


  // Set visual properties
  fullScreen(); 
  WIDTH = width;
  HEIGHT  = height;
  TILE_WIDTH = floor(WIDTH/COLS);
  TILE_HEIGHT = floor(HEIGHT/ROWS);

  // Generate Objects
  entities = new Entities();
  animations = new Animations();
  map = new Map();  
  hud = new HUD();
  screen = new Screen();
  player = new Player(map.getRandomWalkableTile(), 100);
  game = new Game();
}

void draw(){
  
  
  game.renderFrame();
  entities.tick();  
  animations.tick();
  TICK++;

}

void stop(){

}

void keyPressed(){
  PVector move = new PVector(0, 0);
  
  if(key == 'w' || key == 'W'){   
    move = new PVector(0, -1);

  } else if(key == 'a' || key == 'A'){
    move = new PVector(-1, 0);
 
  } else if(key == 's' || key == 'S'){
    move = new PVector(0, 1);
 
  } else if(key == 'd' || key == 'D'){
    move = new PVector(1, 0);
    
  } else if(key == ' '){ // Spacebar
    player.attack();
  }

  if(game.validMove(move)){
     player.move(move);
  }
}

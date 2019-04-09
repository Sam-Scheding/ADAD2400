
// Debugging stuff
boolean DEBUG = false;

// Procedural Generation Stuff
int SEED = (int)random(MIN_INT, MAX_INT);

float CITY_PROB = 0.0005; // 0.05% chance per valid tile to generate a city
int CITY_RADIUS = 10; // The maximum radius a city can have

float MOB_PROB = 0.001;
float FOOD_PROB = 0.001;

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

String[] FOOD_MESSAGES = {
  "You find some rotten scraps on the ground. It'll do for now.",
};

// Size/Shape of the canvas
int SCREEN_HEIGHT = ceil(ROWS/2); // Vertical radius of the screen
int SCREEN_WIDTH = ceil(COLS/2); // Horizontal radius of the screen
PVector[] DIRECTIONS = {
  new PVector(0,-1),
  new PVector(-1,0),
  new PVector(0,1),
  new PVector(1,0),
};

// Window Stuff
int BG_COLOUR = 10;
int STROKE_COLOUR = 255;
int HUD_WIDTH = 200;
int HUD_PADDING = 10;
int HUD_Y = 0 + HUD_PADDING;
int HUD_X;
int HUD_HEIGHT;

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
  TILE_WIDTH = floor(width/COLS);
  TILE_HEIGHT = floor(height/ROWS);
  HUD_HEIGHT = height - HUD_PADDING*2;
  HUD_X = width-HUD_WIDTH-HUD_PADDING;

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
  
  
  screen.renderFrame();
  entities.tick();  
  animations.tick();
  game.tick();
  TICK++;

}

void stop(){

}

void keyPressed(){
  PVector move = new PVector(0, 0);
  
  if(key == 'w' || key == 'W'){   
    move = DIRECTIONS[0];

  } else if(key == 'a' || key == 'A'){
    move = DIRECTIONS[1];
 
  } else if(key == 's' || key == 'S'){
    move = DIRECTIONS[2];
 
  } else if(key == 'd' || key == 'D'){
    move = DIRECTIONS[3];
    
  } else if(key == ' '){ // Spacebar
    player.attack();
  } else {
    // This stops random keys from forcing a render
    return;
  }
  player.move(move);
}

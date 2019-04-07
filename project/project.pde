import java.util.Iterator; 

// Debugging stuff
boolean DEBUG = true;

// Procedural Generation Stuff
int SEED = MAX_INT; // (int)random(MIN_INT, MAX_INT);
float CITY_PROB = 0.0005; // 0.05% chance per valid tile to generate a city
int CITY_RADIUS = 10; // The maximum radius a city can have

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




// Sound stuff
// we pass this to Minim so that it can load files from the data directory
Minim minim = new Minim(this);


// Game Stuff
Map map;
Player player;
Game game;
Audio audio;
RandomEventQueue events;
HUD hud;
ArrayList<Animation> animations;

void setup() {
  
  // Set seeds for generation
  noiseSeed(SEED); // Set seed for Perlin Noise
  randomSeed(SEED); // Set seed for other RNG

  // Set visual properties
  fullScreen(); 
  WIDTH = width;
  HEIGHT  = height;
  TILE_WIDTH = floor(WIDTH/COLS);
  TILE_HEIGHT = floor(HEIGHT/ROWS);

  // Generate Objects
  map = new Map();  
  player = new Player(map.getRandomWalkableTile(), new PVector(TILE_WIDTH*SCREEN_WIDTH, TILE_HEIGHT*SCREEN_HEIGHT));
  game = new Game(player, map);
  hud = new HUD();
  events = new RandomEventQueue(100);
  animations = new ArrayList<Animation>();
  
  // The game only renders whenever input is detected, so give it an inital render to kick things off.
  game.renderFrame();
}

void draw(){
  
  Iterator itr = animations.iterator(); 
  
  // Any animations that are created get added to the 'animations' array list.
  // each time draw runs, each animation ticks forward one frame. Once the 
  // animation is finished, then it is removed from the array list.
  while (itr.hasNext()){ 
    game.renderFrame();
    Animation a = (Animation)itr.next();
    a.tick();
    if(a.finished){ 
      itr.remove(); 
      game.renderFrame();
    }
  }
  delay(10);

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

 game.renderFrame();

}

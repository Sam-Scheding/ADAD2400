


// Perlin Noise Stuff
float NOISE_SCALE = 0.1;

// Tile Stuff
int ROWS = 45;
int COLS = 90;
int VRAD = ceil(ROWS/2); // Vertical radius of the map
int HRAD = ceil(COLS/2); // Horizontal radius of the map
int TILE_WIDTH;
int TILE_HEIGHT;

// Window Stuff
int WIDTH, HEIGHT;
int BG_COLOUR = 10;


// Debugging stuff
boolean DEBUG = false;


// Sound stuff
// we pass this to Minim so that it can load files from the data directory
Minim minim = new Minim(this);


// Game Stuff
Map map;
Player player;
Game game;
Audio audio;

void setup() {

  fullScreen(); 
  WIDTH = width;
  HEIGHT  = height;
  TILE_WIDTH = floor(WIDTH/COLS);
  TILE_HEIGHT = floor(HEIGHT/ROWS);
  
  map = new Map();  
  player = new Player(map.getRandomWalkableTile());
  game = new Game(player, map);
  audio = new Audio();
  
  audio.play();
  game.render();
}

// Needs to have this, otherwise keyPressed() doesn't run. ¯\_(-_-)_/¯
void draw(){

}

void stop(){
  audio.close();
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
  }
 
 if(game.validMove(move)){
     player.move(move);
   }

 game.render();
}

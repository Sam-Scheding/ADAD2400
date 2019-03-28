
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

// Game Stuff
Map map;
Player player;
Game game;

void setup() {

  fullScreen(); 
  WIDTH = width;
  HEIGHT  = height;
  TILE_WIDTH = floor(WIDTH/COLS);
  TILE_HEIGHT = floor(HEIGHT/ROWS);

  
  map = new Map();  
  player = new Player();
  game = new Game(player, map);
  
  render();
}
/*
  Using draw() was overkill since you only actually need to draw the screen again 
  if the player moves. So I wrote this render function that draws everything. 

*/
void render(){
  Tile tile;

  background(BG_COLOUR);

  // First draw the map
  // Need to keep track of rows and cols here, since the player's global position in the world could be wayyy outside the screen
  int row = 0, col = 0;
  // Iterate over all the tiles around the player (from - to + vertical and horizontal radii)
  for (int y = (int)player.pos.y-VRAD; y <= player.pos.y+VRAD; y++) {
    for (int x = (int)player.pos.x-HRAD; x <= player.pos.x+HRAD; x++) {
      
      tile = map.getOrCreateTile(x, y);
      map.display(tile, col, row);
      //println(x + ":" + y);
      col++;
    }
    row++;
    col=0;
  }
  
  //Then overlay the player on the map
  player.display();
}

// Needs to have this, otherwise keyPressed() doesn't run. ¯\_(-_-)_/¯
void draw(){

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

 render();
}

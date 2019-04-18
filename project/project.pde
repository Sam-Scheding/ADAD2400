
boolean DEBUG = true;


Screen screen;

// Game Stuff
RNG rng;
Map map;
Player player;
Game game;
Animations animations;
Enemies enemies; // Similar to animations
HUD hud;

void settings(){

  fullScreen(); // It's super annoying that this needs to be here, but yeh.
}

void setup() {
  
  if(DEBUG){ SEED = MAX_INT; }


  HUD_HEIGHT = height - HUD_PADDING*2;
  HUD_X = width-HUD_WIDTH-HUD_PADDING;


  // Generate Objects
  rng = new RNG();
  hud = new HUD();
  enemies = new Enemies();
  animations = new Animations();
  map = new Map();  
  player = new Player(map.getRandomWalkableTile(), 100);
  
  screen = new Screen();

  game = new Game();
  
  screen.renderFrame();
  enemies.tick();  
  game.tick();


}

void draw(){
  
  /* Internally, animations is a list. If it's empty nothing happens, but if 
   animations are added to it, they get played out. 
   An animation could be something like the player attack function.
  */
  animations.renderFrame();
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
  screen.renderFrame();
  enemies.tick();  
  game.tick();
  TICK++;

}

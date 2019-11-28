import java.awt.event.KeyEvent;

PImage depthImg;

boolean DEBUG = false;

Screen screen;
int lastMoveTime = 0;

// Game Stuff
RNG rng;
Map map;
Player player;
Game game;
Animations animations;
Entities entities;
HUD hud;


//PlayerPosition playerPosition;
KeyPad keypad;

void settings(){

  fullScreen(); // It's super annoying that this needs to be here, but yeh.
}

void setup() {

  HUD_HEIGHT = height - HUD_PADDING*2;
  HUD_X = width-HUD_WIDTH-HUD_PADDING;

  // Generate Objects
  game = new Game();
  game.newGame();


}

void draw(){

  if(game.state == GAME_OVER){
    delay(3000);
    game.newGame();
  }
  /* Internally, animations is a list. If it's empty nothing happens, but if 
   animations are added to it, they get played out. 
   An animation could be something like the player attack function.
  */
  animations.renderFrame();
}

void stop(){

}

void keyPressed(){
  
  myKeyPressed();

}

void myKeyPressed(){

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
  
  // Since this is a turn based game, we only need to update it
  // whenever input is given
  player.move(move);
  player.tick();  
  entities.tick();  
  game.tick();
}

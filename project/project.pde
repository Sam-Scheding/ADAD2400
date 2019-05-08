import org.openkinect.processing.*;
import java.awt.event.KeyEvent;


Kinect2 kinect2;
PImage depthImg;

boolean DEBUG = false;
boolean SHOW_CONTROLLER = false;
boolean SHOW_DEPTH_IMAGE = false;
boolean USE_KINECT = true;
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


PlayerPosition playerPosition;
KeyPad keypad;

void settings(){

  fullScreen(); // It's super annoying that this needs to be here, but yeh.
}

void setup() {
  try{
    kinect2 = new Kinect2(this);
    kinect2.initDepth();
    kinect2.initDevice();    
  } catch(NullPointerException e){
    println("Couldn't find the Kinect. Are you sure it's attached?");
    exit();
  }

  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight);

  HUD_HEIGHT = height - HUD_PADDING*2;
  HUD_X = width-HUD_WIDTH-HUD_PADDING;

  // Generate Objects
  game = new Game();
  game.newGame();


}

void draw(){
  
  playerPosition.update();
  PVector pos = playerPosition.get();
  Button button;
  button = keypad.press(pos);

  
  if(SHOW_DEPTH_IMAGE){
    depthImg.updatePixels();
    depthImg = kinect2.getDepthImage();
    image(depthImg, 0, 0);
  }


  if(SHOW_CONTROLLER){
    background(0);
    keypad.display();
    textSize(18);
    if(button != null){
      text("PRESSED: " + button.name, 10, height-70);
    }
    text(pos.toString(), 10, height-50);
    ellipse(pos.x, pos.y, 30, 30);
  }    

  if(USE_KINECT){
    if(button != null){
      char k = button.text;
      key = k;
      if(millis() < lastMoveTime + 500){ return; }
      lastMoveTime = millis();

      myKeyPressed();
      
    }
  }

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
  
  if(key == '?'){

    SHOW_CONTROLLER = !SHOW_CONTROLLER;
    SHOW_DEPTH_IMAGE = !SHOW_DEPTH_IMAGE;
    screen.renderFrame();
  }
  
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

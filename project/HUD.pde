
int INNER_PADDING = 20;
int HUD_WIDTH = 300;
int HUD_PADDING = 10;
int HUD_Y = 0 + HUD_PADDING;
int HUD_X;
int HUD_HEIGHT;

class HUD{
  
  String message = "";
  Tile currentTile = null;
  
  void display(){
    fill(BG_COLOUR);
    stroke(STROKE_COLOUR);
    strokeWeight(3);
    rect(HUD_X, HUD_Y, HUD_WIDTH, HUD_HEIGHT, 7);
    fill(255);
    
    text("PLAYER", HUD_X+10, HUD_Y+20 );
    text("Location: (" + player.x() + ", " + player.y() + ")", HUD_X+10, HUD_Y+40);
    text("Health: " + player.health + "/" + player.maxHealth, HUD_X+10, HUD_Y+60);
    text("Hunger: " + nf(player.hunger, 3, 2) + "/" + player.maxHunger, HUD_X+10, HUD_Y+80);
    text("Attack Strength: " + player.attackStrength, HUD_X+10, HUD_Y+100);
    text("Attack Radius: " + player.attackRadius, HUD_X+10, HUD_Y+120);

    text("MAP", HUD_X+10, HUD_Y+160 );
    text(this.message, HUD_X+10, HUD_Y+180, HUD_WIDTH-INNER_PADDING, 100);
    
    text("KEY", HUD_X+10, HUD_Y+300);
    text(
      "Player:" + Faces.PLAYER + 
    "\nTree: " + Faces.TREE + 
    "\nWater: " + Faces.WATER + 
    "\nBuilding: " + Faces.BUILDING +
    "\nEnemy: " + Faces.ENEMY +
    "\nFood: " + Faces.FOOD +
    "\nBuilding: " + Faces.BUILDING
    , HUD_X+10, HUD_Y+320);

    
    if(DEBUG){
      text("TILE: " + this.currentTile, HUD_X+10, HUD_Y+480);
      text("ENEMIES: ", HUD_X+10, HUD_Y+500);
      String enemies = "";
      for(Enemy e: entities.monsters){
        if(e.icon() == Faces.ENEMY){
          enemies += String.format("(%d, %d)\n", (int)e.x(), (int)e.y());
        }
      }
      text(enemies, HUD_X + 10, HUD_Y + 530);
    }
    

  }
  
  void setMessage(String message){
    this.message = message;
  }
  
}

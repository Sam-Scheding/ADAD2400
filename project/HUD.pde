
class HUD{
  
  String message = "";
  
  void display(){
    fill(BG_COLOUR);
    stroke(STROKE_COLOUR);
    strokeWeight(3);
    rect(HUD_X, HUD_Y, HUD_WIDTH, HUD_HEIGHT, 7);
    fill(255);
    
    text("PLAYER", HUD_X+10, HUD_Y+20 );
    text("Location: (" + player.location.x + ", " + player.location.y + ")", HUD_X+10, HUD_Y+40);
    text("Health: " + player.health + "/" + player.maxHealth, HUD_X+10, HUD_Y+60);
    text("Hunger: " + nf(player.hunger, 3, 2) + "/" + player.maxHunger, HUD_X+10, HUD_Y+80);
    text("Attack Strength: " + player.attackStrength, HUD_X+10, HUD_Y+100);
    text("Attack Radius: " + player.attackRadius, HUD_X+10, HUD_Y+120);

    text("MAP", HUD_X+10, HUD_Y+160 );
    text(this.message, HUD_X+10, HUD_Y+180, HUD_WIDTH, HUD_WIDTH);

  }
  
  void setMessage(String message){
    this.message = message;
  }
  
}

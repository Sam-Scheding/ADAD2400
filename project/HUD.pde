

class HUD{
  
  HUD(){
   
  }
 
  void display(){
     if(DEBUG){
       text("(" + player.location.x + ", " + player.location.y + ")", 10, 30);
     }
  }
}

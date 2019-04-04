

class HUD{
  
 HUD(){
   
 }
 
   void display(Player p){
     if(DEBUG){
       text("(" + p.pos.x + ", " + p.pos.y + ")", 10, 30);
     }
   }
}

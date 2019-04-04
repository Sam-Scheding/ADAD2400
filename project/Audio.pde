import ddf.minim.*;

/*
  This handles the sound and music for the game. 
  Version 1 plays random songs at intervals throughout 
  gameplay. Version 2 will play procedurally generated music.
*/
class Audio {
  
  int numTracks = 9;
  StringList tracks = new StringList();

  Audio(){
    int i = 1;
    while(i <= numTracks){
     tracks.append("Track_" + str(i)); 
     i++;
    }
    tracks.shuffle();

  }
  
   void play(){         
     // loadFile looks in all the same places as loadImage does.
     // this means you can find files that are in the data folder and the 
     // sketch folder. you can also pass an absolute path, or a URL.
     
   }
   
}



class MusicEvent extends Event{
   AudioPlayer music;

   MusicEvent(int thresh, float probability, boolean repeat){
      super(thresh, probability, repeat);   
   }
   
   void happen(){
       String fileName = "music/Track_" + random(1, 9) + ".mp3";
       music = minim.loadFile(fileName);    
       music.play();
   }
  
   boolean isDone(){
     return !music.isPlaying(); 
   }
}

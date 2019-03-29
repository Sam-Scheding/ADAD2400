import ddf.minim.*;

/*
  This handles the sound and music for the game. 
  Version 1 plays random songs at intervals throughout 
  gameplay. Version 2 will play procedurally generated music.
*/
class Audio {
  
  int numTracks = 9;
  StringList tracks = new StringList();
  AudioPlayer music;

  Audio(){
    int i = 1;
    while(i <= numTracks){
     tracks.append("Track_" + str(i)); 
     i++;
    }
    tracks.shuffle();
    String fileName = "music/" + tracks.get(0) + ".mp3";
    music = minim.loadFile(fileName);    

  }
  
   void play(){         
     // loadFile looks in all the same places as loadImage does.
     // this means you can find files that are in the data folder and the 
     // sketch folder. you can also pass an absolute path, or a URL.
     
     music.play();
   }
   
   void close(){
     music.close();
   }
}


/*
  A collection of events to perform at random intervals
*/

import java.util.Queue;
import java.util.ArrayDeque;

class RandomEventQueue { // Probably should extend deque, but my Java is rusty
  
    int size;
    final Queue<Event> events;
    
    RandomEventQueue(int size){
      this.size = size;
      events = new ArrayDeque(size);
      
    }
    
    void tick(){
      
      for(Event e: events){
        e.touch(); // Increment the event's ticker
        if(e.ticker > e.thresh){ // if the event is ready to happen
           e.happen();
        }
      }
    }
    
    void add(Event e){
       events.add(e); 
    }
    
    //Event get(){
    //  return events.remove();
    //}
    
    
}

/*
  Events to be added to the RandomEventList. Every time the list is iterated over
  the Event's ticker has a chance to increment. When the ticker >= thresh, the event
  is performed. This ensures that events can't happen immediately.
  
  This class is abstract and can't be instantiated. This is because it's ambiguous 
  what needs to happen when the event happens. An actual event might be something like
  SongEvent, which would implement happen(); to play music.
*/
abstract class Event {
  
  int ticker;
  int thresh;
  float probability; // 0-1 Chance of the ticker incrementing
  boolean repeat; // Whether the event is a one off, or should repeat forever.
  
  Event(int thresh, float probability, boolean repeat){
    this.thresh = thresh;
    this.ticker = 0;
    this.probability = probability;
    this.repeat = repeat;
  }

  /*
    Any inheriting classes need to implement this method.
   */
  abstract void happen();   
  
  abstract boolean isDone();  
  
  void touch(){
     float r = random(1);
     if(r >= 1-probability){ ticker++; }
  }
  
}

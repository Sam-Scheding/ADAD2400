
// Which pixels do we care about?
int MIN_DISTANCE =  30; // leave a buffer of 3cm. Their head should be more than 3cm away
int MAX_DISTANCE =  2000; // The floor should be more than 2 metres away
float RATIO = (MAX_DISTANCE - MIN_DISTANCE)/255.0;


class PlayerPosition {
  
  PVector[] positions = new PVector[20]; // I use this as a FIFO Queue
  int qIndex; // Use this to access the Queue, mod it with positions.length to wrap around
  PVector kinectDim; 
  
  PlayerPosition(){
    kinectDim = new PVector(512, 424); // The kinect returns an image of this size
  }
  
  PVector get(){
      return rollingAveragePos(positions, 0, positions.length);
  }  
  
  void update(){
      
      int[] rawDepth = kinect2.getRawDepth();
      float closest = MAX_DISTANCE; // Set closest val to the worst possible guess so it's always improved
      int closestX = 0, closestY = 0;
      float distance = 0;
      
      for(int idx=0; idx < rawDepth.length; idx++){
        
        //distance = rollingAverage2D(rawDepth, idx, 10); // look around the current index with a radius of 10 and compute the average depth      
        distance = rollingAverage1D(rawDepth, idx, 10);
        if (distance >= MIN_DISTANCE && distance <= MAX_DISTANCE) {
          
          if(distance < closest){ // Update new best
            closestY = floor(idx/kinect2.depthWidth);
            closestX = idx - closestY * kinect2.depthWidth;
            closest = distance;
          }

        }
      }
      closestX = (int)map(closestX, 0, kinectDim.x, 0, width);
      closestY = (int)map(closestY, 0, kinectDim.y, 0, height);
      
      positions[qIndex%positions.length] = new PVector(closestX, closestY, closest);
      qIndex++;
    }
    
  }  
  

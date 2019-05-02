
// Which pixels do we care about?
int MIN_DISTANCE =  30; // leave a buffer of 3cm. Their head should be more than 3cm away
int MAX_DISTANCE =  2000; // The floor should be more than 2 metres away
float RATIO = (MAX_DISTANCE - MIN_DISTANCE)/255.0;


class Controller {
  
  PVector dimensions = new PVector(512, 424); // The kinect returns an image of this size
  PImage depthImg;
  Finger finger;
  KeyPad keypad;
  
  Controller(){
  
    kinect2.initDepth();
    kinect2.initDevice();
    // Blank image
    depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight);

    finger = new Finger();
    keypad = new KeyPad();
  
  }
  
  void display(){
    int[] rawDepth = kinect2.getRawDepth();
    depthImg.updatePixels();
    image(depthImg, 0, 0);
    keypad.display();
    finger.display(rawDepth);
    depthImg.updatePixels();
    
  }

  class Finger{
    
    PVector[] positions = new PVector[20];
    int posIdx = 0;
    
    Finger(){
      
    
    }
    
    void display(int[] rawDepth){
      update(rawDepth);

      PVector pos = rollingAveragePos(positions, 0, 0, positions.length);
      ellipse(pos.x, pos.y, 30, 30);
    }
    
    
    void update(int[] rawDepth){
      
      
      float closest = MAX_DISTANCE; // Set closest val to the worst possible guess so it's always improved
      int closestX = 0, closestY = 0;
      float distance = 0;
      
      for(int idx=0; idx < rawDepth.length; idx++){
        
        //distance = rollingAverage2D(rawDepth, idx, 10); // look around the current index with a radius of 10 and compute the average depth      
        distance = rollingAverageVal(rawDepth, idx, 10);
        depthImg.pixels[idx] = color(0); // Initial set the pixel to black. If it's within the threshold, this will be overwritten    
        if (distance >= MIN_DISTANCE && distance <= MAX_DISTANCE) {
          depthImg.pixels[idx] = color((rawDepth[idx] - MIN_DISTANCE)/RATIO, 200,200);
          
          if(distance < closest){ // Update new best
            closestY = floor(idx/kinect2.depthWidth);
            closestX = idx - closestY * kinect2.depthWidth;
            closest = distance;
          }

        }
      }
      closestX = (int)map(closestX, 0, dimensions.x, 0, width);
      closestY = (int)map(closestY, 0, dimensions.y, 0, height);
      
      positions[posIdx%positions.length] = new PVector(closestX, closestY, closest);
      posIdx++;
    }
  }

  class KeyPad{
    
    KeyPad(){
    
    }
    
    void display(){
      int keyDim = 180;
      int padding = 10;
      
      noFill();
      strokeWeight(3);
      textSize(40);
      
      // Draw W key
      stroke(255);
      rect(width/2-keyDim/2, height/3-keyDim/2, keyDim, keyDim, 5);
      text("W", width/2-17, height/2-keyDim/2);      
      stroke(255, 0, 0);
      point(width/2-17, height/2-keyDim/2);

      // Draw S key
      stroke(255);
      rect(width/2-keyDim/2, height/3 + keyDim/2 + padding, keyDim, keyDim, 5);
      text("S", width/2-12, height/2 + keyDim/2);
      stroke(255, 0, 0);
      point(width/2-12, height/2 + keyDim/2);
    
      // Draw A key
      stroke(255);
      rect(width/2-keyDim/2 - keyDim - padding, height/3 + keyDim/2 + padding, keyDim, keyDim, 5);
      text("A", width/2 - 13 - keyDim - padding, height/2 + keyDim/2);
      stroke(255, 0, 0);
      point(width/2 - keyDim - padding, height/2 + keyDim/2 - padding);
    
      // Draw D key
      stroke(255);
      rect(width/2-keyDim/2 + keyDim + padding, height/3 + keyDim/2 + padding, keyDim, keyDim, 5);
      text("D", width/2 + keyDim, height/2 + keyDim/2);
      stroke(255, 0, 0);
      point( width/2 + keyDim, height/2 + keyDim/2);
    
      // Draw Space Bar
      stroke(255);
      rect(width/2-keyDim/2 - keyDim - padding, height/2 + keyDim - 10, keyDim*3 + padding*2, keyDim - 10, 5);
      stroke(255, 0, 0);
      point(width/2-keyDim/2 - keyDim + 100, height/2 + keyDim*1.4);
      point(width/2-keyDim/2 - keyDim + 200, height/2 + keyDim*1.4);
      point(width/2-keyDim/2 - keyDim + 300, height/2 + keyDim*1.4);
      point(width/2-keyDim/2 - keyDim + 400, height/2 + keyDim*1.4);
    
    }
  }
}


float rollingAverage2D(int[] arr, int idx, int radius){

  // Since the rawDepth array is 1D, we have some work to do to convert it to an XY coord  
  int xLo = max(floor(idx % kinect2.depthWidth) - radius, 0);
  int xHi = min(floor(idx % kinect2.depthWidth) + radius, kinect2.depthWidth);
  int yLo = max(idx / kinect2.depthWidth - radius, 0);
  int yHi = min(idx / kinect2.depthWidth + radius, kinect2.depthHeight);
  float total = 0;
  
  for(int y = yLo; y < yHi; y++){
    for(int x = xLo; x < xHi; x++){
      total += arr[x + y * kinect2.depthWidth];
  
    }

  }

  return total/(2*radius*radius);
}

/*
  This rolling average only works with horizontal values.
  It doesn't look vertically
*/
float rollingAverageVal(int[] arr, int idx, int radius){
  
  int lo = constrain(idx - radius, 0, arr.length);
  int hi = constrain(idx + radius, 0, arr.length);
  float total = 0;

  while(lo < hi){
    total += arr[lo];
    lo++;
  }

  return total/radius;
}

PVector rollingAveragePos(PVector[] arr, int idx, int lo, int hi){
  
  PVector total = new PVector();
  int numElements = 0;
  lo = constrain(idx - lo, 0, arr.length);
  hi = constrain(idx + hi, 0, arr.length);


  while(lo < hi){
    if(arr[lo] != null){
      total.add(arr[lo]);
      numElements++;
    }
    lo++;
  }
  
  return new PVector(total.x/numElements, total.y/numElements);

}

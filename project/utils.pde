

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
float rollingAverage1D(int[] arr, int idx, int radius){
  
  int lo = constrain(idx - radius, 0, arr.length);
  int hi = constrain(idx + radius, 0, arr.length);
  float total = 0;

  while(lo < hi){
    total += arr[lo];
    lo++;
  }

  return total/radius;
}

PVector rollingAveragePos(PVector[] arr, int lo, int hi){
  
  PVector total = new PVector();
  int numElements = 0;
  lo = constrain(lo, 0, arr.length);
  hi = constrain(hi, 0, arr.length);


  while(lo < hi){
    if(arr[lo] != null){
      total.add(arr[lo]);
      numElements++;
    }
    lo++;
  }
  
  return new PVector(total.x/numElements, total.y/numElements);

}

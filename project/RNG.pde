
// Procedural Generation Stuff
int SEED = (int)random(MIN_INT, MAX_INT); // 4,294,967,294 possible worlds

float MOB_PROB = 0.001;
float FOOD_PROB = 0.003;

// Perlin Noise Stuff
float NOISE_SCALE = 0.1;

/*
  TODO: create getter and setter methods for this.
*/
class RNG{

   RNG(){
     
     noiseSeed(SEED); // Set seed for Perlin Noise
     randomSeed(SEED); // Set seed for other RNG

   }


}

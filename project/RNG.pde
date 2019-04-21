
// Procedural Generation Stuff

float ENEMY_PROB = 0.001;
float FOOD_PROB = 0.003;

// Perlin Noise Stuff
float NOISE_SCALE = 0.1;

/*
  TODO: create getter and setter methods for this.
*/
class RNG{
   
  int seed;
   
   RNG(){

     this.seed = (int)random(MIN_INT, MAX_INT); // 4,294,967,294 possible worlds
     if(DEBUG){ this.seed = MAX_INT; }
     noiseSeed(this.seed); // Set seed for Perlin Noise
     randomSeed(this.seed); // Set seed for other RNG

   }
}

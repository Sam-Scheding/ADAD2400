/*
  This is the baseclass for all animations. In the draw() loop
  an array of these Animation objects is iterated over to update
  and display their current state.
*/
abstract class Animation {
 
  PVector origin;  
  ArrayList<ExplosionParticle> particles;
  boolean finished;
  
  Animation(PVector position){
    origin = position.copy();
    particles = new ArrayList<ExplosionParticle>();
    animations.add(this);
    finished = false;
  }
  
  abstract void addParticle();
  abstract void tick();
}

class ExplosionAnimation extends Animation{
  int counter = 0;
  float radius;
  
  //TODO: Probably better to use trig to do this
  PVector directions[] = {
    new PVector(-2, -1),
    new PVector(-1.5, -1.5),
    new PVector(1.5, -1.5),
    new PVector(-1.5, 1.5),
    new PVector(1.5, 1.5),
    new PVector(-1, -2),
    new PVector(-2, 0),
    new PVector(-2, 1),
    new PVector(-1, 2),
    new PVector(0, 2),
    new PVector(0, -2),
    new PVector(2, -1),
    new PVector(1, -2),
    new PVector(2, 0),
    new PVector(1, 2),
    new PVector(2, 1),
  };
  
  ExplosionAnimation(PVector position, float radius) {
    super(position);
    this.radius = radius;
    int x = 0;
    while(x < directions.length){
      addParticle();
      x++;
    }

  }

  void addParticle() {
    PVector direction = directions[counter%directions.length];
    particles.add(new ExplosionParticle(origin, direction, radius));
    counter++;
  }

  void tick() {

    Iterator itr = particles.iterator();
    while(itr.hasNext()){
       ExplosionParticle p = (ExplosionParticle)itr.next(); 
       p.tick();
       if (p.isDead()) {
          itr.remove();
       } 
    }
    
   // If all the particles are dead, finish the animation 
   if(particles.size() == 0){ finished = true; }

 }
  

}


class ExplosionParticle {
  PVector position;
  float lifespan;
  PVector direction;
  
  ExplosionParticle(PVector l, PVector direction, float lifespan) {
    this.direction = direction;
    position = l.copy();
    this.lifespan = lifespan;
  }

  void tick() {
    update();
    display();

  }

  // Method to update position
  void update() {
    position.add(direction);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255);
    fill(255);
    text('#', position.x, position.y);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

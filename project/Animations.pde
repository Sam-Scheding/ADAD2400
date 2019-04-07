class ExplosionAnimation {
  ArrayList<Particle> particles;
  PVector origin;
  int counter = 0;
  float radius;
  PVector directions[] = {
    new PVector(-2, -1),
    new PVector(-1, -1),
    new PVector(-1, -2),
    new PVector(-1, 0),
    new PVector(-1, 1),
    new PVector(-2, 1),
    new PVector(-1, 2),
    new PVector(0, 1),
    new PVector(0, -1),
    new PVector(2, -1),
    new PVector(1, -1),
    new PVector(1, -2),
    new PVector(1, 0),
    new PVector(1, 1),
    new PVector(2, 1),
    new PVector(1, 2),
  };
  
  ExplosionAnimation(PVector position, float radius) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
    this.radius = radius;
  }

  void addParticle() {
    PVector direction = directions[counter%directions.length];
    println("adding particle");
    particles.add(new Particle(origin, direction, radius));
    counter++;
  }

  void run() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


class Particle {
  PVector position;
  float lifespan;
  PVector direction;
  
  Particle(PVector l, PVector direction, float lifespan) {
    this.direction = direction;
    position = l.copy();
    this.lifespan = lifespan;
  }

  void run() {
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
    stroke(255, lifespan);
    fill(255, lifespan);
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

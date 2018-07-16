// The Nature of Code, Daniel Shiffman
// http://natureofcode.com
//import shiffman.box2d.*;
//import org.jbox2d.collision.shapes.*;
//import org.jbox2d.common.*;
//import org.jbox2d.dynamics.*;
Boolean attractMode = false;
class FlockingClass {
  //Box2DProcessing box2d; // A reference to our box2d world
  //Surface surface; // An object to store information about the uneven surface
  Flock flock;
  //Repeller repeller;
  Attractor attractor;

  int boidMode = 0;
  int NOISE_MODE = 0;
  int FLOCKING_MODE = 1;

  //Agent[] agents;
  float noiseScaleAgent = 100;
  float noiseStrength = 10;
  float noiseZRange = 0.4;
  float noiseZVelocity = 0.01;
  float overlayAlpha = 2;

  float agentAlpha = 90;
  float strokeWidthAgents = 3;
  int drawMode = 1;
  color agentC1, agentC2;
  color currentBackgroundC = 0;
  //boolean acceleratingAgents = true;

  FlockingClass(PApplet p) {
    // Initialize box2d physics and create the world
    //box2d = new Box2DProcessing(p);
    //box2d.createWorld();
    //box2d.setGravity(0, -10); //// We are setting a custom gravity
    agentC1 = color(255);
    flock = new Flock();
    for (int i = 0; i < 150; i++) {
      flock.addBoid(new Boid(random(screenW*4), random(screenH)));
    }
    //surface = new Surface();  // Create the surface
    //repeller = new Repeller(screenW*2-20,height/2);
    attractor = new Attractor();
  }

  void displayFlockAll(int mode) {
    for (int i = 0; i < screens.length; i++) {
      displayFlock(screens[i].s, i, mode);
    }
  }

  void displayFlock(PGraphics s, int screenNum, int mode) {
    s.beginDraw();
    s.fill(0, overlayAlpha);
    s.noStroke();
    s.rect(0, 0, s.width, s.height);
    flock.display(s, screenNum, mode);
    s.fill(0, 255, 0);
    s.endDraw();
  }

  void updatePhysics(int mode) {
    flock.run(mode);
    if (mode == FLOCKING_MODE) {
      //box2d.step(); // We must always step through time!
      if (attractMode) {
        flock.applyAttractor(attractor);
        flock.applyAttractor(attractor);
      }
    }
  }


  void newNoise() {
    int newNoiseSeed = floor(random(10000));
    noiseSeed(newNoiseSeed);
    randomizeColors();
  }

  void newNoiseWht() {
    int newNoiseSeed = floor(random(10000));
    noiseSeed(newNoiseSeed);
    agentC1 = color(255);
    agentC2 = color(255);
  }

  class Attractor {

    // Gravitational Constant
    float G = 100;
    // Location
    PVector location;
    //int w = 700;
    //int h = 40;
    int r = 50;

    Attractor() {
      location = new PVector(0, 0);
    }

    void display(PGraphics s, int screenNum) {
      s.stroke(0);
      s.strokeWeight(2);
      s.noFill();
      s.ellipse(location.x - screenW*screenNum, location.y, r, r);
    }

    // Calculate a force to push particle away from repeller
    PVector attract(Boid b, int index) {
      location.set(map(mouseX, 0, width, 0, screenW*4), screenH/2);
      PVector spot = new PVector(location.x, location.y); //screelocation.y);
      PVector dir = PVector.sub(spot, b.location);  
      dir.normalize();                           // Normalize vector (distance doesn't matter here, we just want this vector for direction)
      float force = 2;

      dir.mult(force);                           // Get force vector --> magnitude * direction
      return dir;
    }  

    void switchMode() {
      attractMode =! attractMode;
    }
  }



  void randomizeColors() {
    colorMode(HSB, 255);
    agentC1 = color(random(255), 255, 255);
    agentC2 = color(random(255), 255, 255);
    colorMode(RGB, 255);
  }

  // The Boid class

  class Boid {

    PVector location, locationOld;
    PVector velocity;
    PVector acceleration;
    float r;
    float maxforce;    // Maximum steering force
    float maxspeed;    // Maximum speed
    Boolean wingUp = false;
    int wingCount;
    Boolean noBoundaries = false;
    Boolean landed = false;

    float stepSize;
    float angle;
    float noiseZ;

    Boid(float x, float y) {
      r = 6.0;
      maxspeed = 3;
      maxforce = 0.03;
      location = new PVector(x, y);

      this.locationOld = this.location.copy();
      this.stepSize = random(1, 5);
      this.noiseZ = random(noiseZRange);
      initVel();
    }

    void initVel() {
      acceleration = new PVector(0, 0);

      float angle = random(TWO_PI);
      velocity = new PVector(cos(angle), sin(angle));

      wingCount = int(random(10));
    }

    void run(ArrayList<Boid> boids, int mode) {
      if (mode == NOISE_MODE) {
        updateNoise(noiseScaleAgent, noiseStrength, noiseZVelocity);
      } else if (mode == FLOCKING_MODE) {
        if (!landed) {
          flock(boids);
          updateBoid();
          borders();
        }
      }
    }

    void displayBoid(PGraphics s, int screenNum, int mode) {
      renderNoise(s, screenNum);
      //if (mode == FLOCKING_MODE) renderBoid(s, screenNum);
      //else if (mode == NOISE_MODE) renderNoise(s, screenNum);
    }

    void applyForce(PVector force) {
      // We could add mass here if we want A = F / M
      acceleration.add(force);
    }

    // We accumulate a new acceleration each time based on three rules
    void flock(ArrayList<Boid> boids) {
      PVector sep = separate(boids);   // Separation
      PVector ali = align(boids);      // Alignment
      PVector coh = cohesion(boids);   // Cohesion
      //PVector scat = scatter(boids);   // Scatter
      // Arbitrarily weight these forces
      sep.mult(1.5);
      ali.mult(1.0);
      coh.mult(1.0);
      // Add the force vectors to acceleration
      applyForce(sep);
      applyForce(ali);
      applyForce(coh);
    }

    // Method to update location
    void updateBoid() {
      // Update velocity
      velocity.add(acceleration);
      // Limit speed
      velocity.limit(maxspeed);
      location.add(velocity);
      // Reset accelertion to 0 each cycle
      acceleration.mult(0);
      this.locationOld = this.location.copy();
    }

    void updateNoise(float noiseScaleAgent, float noiseStrength, float noiseZVelocity) {
      this.angle = noise(this.location.x / noiseScaleAgent, this.location.y / noiseScaleAgent, this.noiseZ) * noiseStrength;
      this.location.x += cos(this.angle) * this.stepSize;
      this.location.y += sin(this.angle) * this.stepSize;

      if (this.location.x < -10) this.location.x = this.locationOld.x = screenW*4 + 10;
      if (this.location.x > screenW*4 + 10) this.location.x = this.locationOld.x = -10;
      if (this.location.y < - 10) this.location.y = this.locationOld.y = screenH + 10;
      if (this.location.y > screenH + 10) this.location.y = this.locationOld.y = -10;
      this.locationOld = this.location.copy();

      this.noiseZ += noiseZVelocity;
    }


    // A method that calculates and applies a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    PVector seek(PVector target) {
      PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target
      // Scale to maximum speed
      desired.normalize();
      desired.mult(maxspeed);

      // Above two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // desired.setMag(maxspeed);

      // Steering = Desired minus Velocity
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);  // Limit to maximum steering force
      return steer;
    }

    void renderNoise(PGraphics s, int screenNum) { 
      //s.stroke(lerpColor(agentC1, color(0, 0, 255), this.stepSize/5), agentAlpha);
      //s.strokeWeight(strokeWidthAgents * this.stepSize);
      float r = strokeWidthAgents * this.stepSize * 3;
      s.noStroke();
      s.fill(lerpColor(agentC1, agentC2, this.stepSize/5), agentAlpha);
      //s.fill(255, agentAlpha);
      s.ellipse(this.location.x - screenW*screenNum, this.location.y, r, r);

      //s.strokeWeight(20);
      //s.line(this.locationOld.x - screenW*screenNum, this.locationOld.y, this.location.x, this.locationOld.y); // screenW*screenNum, this.locationOld.y, this.location.x- screenW*screenNum, this.location.y);
    }

    void renderBoid(PGraphics s, int screenNum) {
      // Draw a triangle rotated in the direction of velocity
      float theta = velocity.heading() + radians(90);

      s.fill(0, 0, 255, 100);
      s.noStroke();
      s.pushMatrix();

      //s.translate(location.x + screenW * screenNum, location.y);
      s.stroke(lerpColor(agentC1, color(0, 0, 255), this.stepSize/5), agentAlpha);
      s.strokeWeight(strokeWidthAgents * this.stepSize);

      //s.ellipse(this.locationOld.x - screenW*screenNum, this.locationOld.y, 50, 50);
      s.line(this.locationOld.x - screenW*screenNum, this.locationOld.y, this.location.x- screenW*screenNum, this.location.y);
      //s.rotate(theta);
      ///////////////////////////
      // bird stuff
      ///////////////////////////
      //s.beginShape(TRIANGLES);
      //s.vertex(0, -r*2);
      //s.vertex(-r, r*2);
      //s.vertex(r, r*2);
      //s.endShape();
      //if (landed) {
      //  int wc = 13;
      //  if (wingCount++%wc == 0) wingUp =! wingUp;
      //}
      //else if(velocity.y > .3) {
      //  wingCount = 10;
      //  wingUp = true;
      //}
      //else {
      //  int wc = int((map(velocity.x,-maxspeed,maxspeed,10,5)));
      //  if (wingCount++%wc == 0) wingUp =! wingUp;
      //}
      //if(wingUp) {
      //  beginShape(TRIANGLES);
      //  vertex(0, -r);
      //  vertex(-r*2, r);
      //  vertex(r*2, r);
      //  endShape();
      //}
      s.popMatrix();
    }


    void borders() {
      if (noBoundaries) {
        if (location.x < -r) location.x = screenW*4+r; // velocity = new PVector(-velocity.x,velocity.y); //
        if (location.y < -r) location.y = screenH+r; // velocity = new PVector(velocity.x,-velocity.y); // 
        if (location.x > screenW*4+r) location.x = -r; // velocity = new PVector(-velocity.x,velocity.y);  //
        if (location.y > screenH+r) location.y = -r; // velocity = new PVector(velocity.x,-velocity.y);  //
      } else {
        PVector desired = null;
        int buffer = 30;
        if (location.x < buffer) {
          desired = new PVector(maxspeed, velocity.y);
        } else if (location.x > screenW*4 -buffer) {
          desired = new PVector(-maxspeed, velocity.y);
        } 

        if (location.y < buffer) {
          desired = new PVector(velocity.x, maxspeed);
        } else if (location.y > screenH-buffer) {
          desired = new PVector(velocity.x, -maxspeed);
        } 

        if (desired != null) {
          desired.normalize();
          desired.mult(maxspeed);
          PVector steer = PVector.sub(desired, velocity);
          steer.limit(maxforce*3l);
          applyForce(steer);
        }
      }
    }
    /*
  void touchBody() {
     if(insideBody(location.x, location.y)) 
     PVector desired = null;
     int buffer = 30;
     if (location.x < buffer) {
     desired = new PVector(maxspeed, velocity.y);
     } 
     else if (location.x > screenW*4 -buffer) {
     desired = new PVector(-maxspeed, velocity.y);
     } 
     
     if (location.y < buffer) {
     desired = new PVector(velocity.x, maxspeed);
     } 
     else if (location.y > screenH-buffer) {
     desired = new PVector(velocity.x, -maxspeed);
     } 
     
     if (desired != null) {
     desired.normalize();
     desired.mult(maxspeed);
     PVector steer = PVector.sub(desired, velocity);
     steer.limit(maxforce+10);
     applyForce(steer);
     }
     }
     } */

    // Separation
    // Method checks for nearby boids and steers away
    PVector separate (ArrayList<Boid> boids) {
      float desiredseparation = 25.0f;
      PVector steer = new PVector(0, 0, 0);
      int count = 0;
      // For every boid in the system, check if it's too close
      for (Boid other : boids) {
        float d = PVector.dist(location, other.location);
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if ((d > 0) && (d < desiredseparation)) {
          // Calculate vector pointing away from neighbor
          PVector diff = PVector.sub(location, other.location);
          diff.normalize();
          diff.div(d);        // Weight by distance
          steer.add(diff);
          count++;            // Keep track of how many
        }
      }
      // Average -- divide by how many
      if (count > 0) {
        steer.div((float)count);
      }

      // As long as the vector is greater than 0
      if (steer.mag() > 0) {
        // First two lines of code below could be condensed with new PVector setMag() method
        // Not using this method until Processing.js catches up
        // steer.setMag(maxspeed);

        // Implement Reynolds: Steering = Desired - Velocity
        steer.normalize();
        steer.mult(maxspeed);
        steer.sub(velocity);
        steer.limit(maxforce);
      }
      return steer;
    }

    // Alignment
    // For every nearby boid in the system, calculate the average velocity
    PVector align (ArrayList<Boid> boids) {
      float neighbordist = 50;
      PVector sum = new PVector(0, 0);
      int count = 0;
      for (Boid other : boids) {
        float d = PVector.dist(location, other.location);
        if ((d > 0) && (d < neighbordist)) {
          sum.add(other.velocity);
          count++;
        }
      }
      if (count > 0) {
        sum.div((float)count);
        // First two lines of code below could be condensed with new PVector setMag() method
        // Not using this method until Processing.js catches up
        // sum.setMag(maxspeed);

        // Implement Reynolds: Steering = Desired - Velocity
        sum.normalize();
        sum.mult(maxspeed);
        PVector steer = PVector.sub(sum, velocity);
        steer.limit(maxforce);
        return steer;
      } else {
        return new PVector(0, 0);
      }
    }

    // Cohesion
    // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
    PVector cohesion (ArrayList<Boid> boids) {
      float neighbordist = 50;
      PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
      int count = 0;
      for (Boid other : boids) {
        float d = PVector.dist(location, other.location);
        if ((d > 0) && (d < neighbordist)) {
          sum.add(other.location); // Add location
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        return seek(sum);  // Steer towards the location
      } else {
        return new PVector(0, 0);
      }
    }
    void landed() {
      landed = true;
      acceleration = new PVector(0, 0);
      //PVector up = new PVector(0,
      velocity = new PVector(0, -1);
    }

    void startFlying() {
      initVel();
      landed = false;
    }
  }



  // The Flock (a list of Boid objects)

  class Flock {
    ArrayList<Boid> boids; // An ArrayList for all the boids

    Flock() {
      boids = new ArrayList<Boid>(); // Initialize the ArrayList
    }

    int getSize() {
      return boids.size();
    }

    void run(int mode) {
      for (Boid b : boids) {
        b.run(boids, mode);  // Passing the entire list of boids to each boid individually
      }
    }

    void display(PGraphics s, int screenNum, int mode) {
      for (Boid b : boids) {
        b.displayBoid(s, screenNum, mode);
      }
    }


    void addBoid(Boid b) {
      boids.add(b);
    }

    void startFlying() {
      for (Boid b : boids) {
        b.startFlying();
      }
    }

    void applyAttractor(Attractor a) {
      for (int i = 0; i < boids.size(); i++) {
        PVector force = a.attract(boids.get(i), i);        
        boids.get(i).applyForce(force);
      }
    }
  }
}

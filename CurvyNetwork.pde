ArrayList<Star> constellation;
int n;
float d;

void initCurvyNetwork() {
  n = 50;
  constellation = new ArrayList<Star>();
  for (int i = 0; i <= n; i++) {
    constellation.add(new Star());
  }
  strokeWeight(.75);
  stroke(255);
}

void drawCurvyNetwork(PGraphics s) {

  s.background(0);

  for (int i = 0; i < constellation.size(); i++) {
    constellation.get(i).update();
    for (int j = 0; j < constellation.size(); j++) {
      if (i > j) { // "if (i > j)" => to check one time distance between two stars
        d = constellation.get(i).loc.dist(constellation.get(j).loc); // Distance between two stars
        if (d <= width / 10) { // if d is less than width/10 px, we draw a line between the two stars
          s.line(constellation.get(i).loc.x, constellation.get(i).loc.y, constellation.get(j).loc.x, constellation.get(j).loc.y);
        }
      }
    }
  }
}

class Star {
  float a, r, m;
  PVector loc, speed, bam;
  Star() {

    this.a = random(5 * TAU); // "5*TAU" => render will be more homogeneous
    this.r = random(screenW * .2, screenW * .25); // first position will looks like a donut
    this.loc = new PVector(screenW / 2 + sin(this.a) * this.r, screenH / 2 + cos(this.a) * this.r);
    this.speed = new PVector();
    this.speed = PVector.random2D();
    this.bam = new PVector();
    this.m = 0;
  }

  void update() {
    bam =  PVector.random2D();// movement of star will be a bit erractic
    //this.bam.random2D();
    bam.mult(0.45);
    speed.add(bam);
    // speed is done according distance between loc and the mouse :
    m = constrain(map(dist(this.loc.x, this.loc.y, mouseX, mouseY), 0, screenW, 8, .05), .05, 3); // constrain => avoid returning "not a number"
    speed.normalize().mult(this.m);

    // No colision detection, instead loc is out of bound
    // it reappears on the opposite side :
    if (dist(loc.x, this.loc.y, screenW / 2, screenH / 2) > (screenW / 2) * 0.98) {
      if (loc.x < screenW / 2) {
        loc.x = screenW - loc.x - 4; // "-4" => avoid blinking stuff
      } else if (loc.x > screenW / 2) {
        loc.x = screenW - loc.x + 4; // "+4"  => avoid blinking stuff
      }
      if (loc.y < screenH / 2) {
        loc.y = screenW - loc.y - 4;
      } else if (loc.x > screenH / 2) {
        loc.y = screenW - loc.y + 4;
      }
    }
    loc = loc.add(speed);
  } // End of update()
} // End of class

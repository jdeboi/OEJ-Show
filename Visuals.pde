//////////////////////////////////////////////////////////////////////////////////
// STRIPES
//////////////////////////////////////////////////////////////////////////////////

float angleStriped = 0;
float[] stripedAngles;

void initStripedSquares(int num) {
  stripedAngles = new float[num];
  for (int i = 0; i < num; i++) {
    stripedAngles[i] = random(2 * PI);
  }
}
void displayStriped(int lineW) {
  for (int j = 0; j < stripedAngles.length; j++) { 
    pushMatrix();
    translate(centerX, centerY);
    rotateZ(stripedAngles[j]);
    stripedAngles[j] += .01;

    fill(0);
    noStroke();
    rect(0, 0, width, width);
    fill(255);
    for (int i = 0; i < width; i+= lineW) {
      rect(0, 0 + i, width, lineW);
      i += lineW;
    }
    popMatrix();
  }
}


//////////////////////////////////////////////////////////////////////////////////
// CENTER TRIANGLE
//////////////////////////////////////////////////////////////////////////////////
void triangleCenter(color c, int sw, int sz) {
  strokeWeight(sw);
  stroke(c);
  noFill();
  int x = (maskPoints[2].x+maskPoints[7].x)/2; 
  int y = (maskPoints[2].y+maskPoints[7].y)/2;
  float alt = sz*sqrt(3)/2.0;
  triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2);
}


//////////////////////////////////////////////////////////////////////////////////
// HAROM
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/434617
// Gábor Damásdi
void haromCenter(color c, int sw, int sz) {
  strokeWeight(sw);
  stroke(c);
  noFill();
  harom(centerX+sz/2, centerY+sz/2, centerX-sz/2, centerY+sz/2, 6, (sin(0.0005*millis()%(2*PI))+1)/2);
}

float t=0.001;
void harom(float ax, float ay, float bx, float by, int level, float ratio) {
  if (level!=0) {
    float vx, vy, nx, ny, cx, cy;
    vx=bx-ax;
    vy=by-ay;
    nx=cos(PI/3)*vx-sin(PI/3)*vy; 
    ny=sin(PI/3)*vx+cos(PI/3)*vy; 
    cx=ax+nx;
    cy=ay+ny;
    line(ax, ay, bx, by);
    line(ax, ay, cx, cy);
    line(cx, cy, bx, by);
    harom(ax*ratio+cx*(1-ratio), ay*ratio+cy*(1-ratio), ax*(1-ratio)+bx*ratio, ay*(1-ratio)+by*ratio, level-1, ratio);
  }
}

void haromAll(color c, int sw) {
  float ax = screenW-30;
  float bx = 30;
  float ay = screenH-50;
  float by = ay;
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.strokeWeight(sw);
    s.s.stroke(255);
    haromScreen(s, ax, ay, bx, by, 6, (sin(0.0005*millis()%(2*PI))+1)/2);
    s.s.endDraw();
  }
}

void haromScreen(Screen s, float ax, float ay, float bx, float by, int level, float ratio) {
  if (level!=0) {
    float vx, vy, nx, ny, cx, cy;
    vx=bx-ax;
    vy=by-ay;
    nx=cos(PI/3)*vx-sin(PI/3)*vy; 
    ny=sin(PI/3)*vx+cos(PI/3)*vy; 
    cx=ax+nx;
    cy=ay+ny;
    s.s.line(ax, ay, bx, by);
    s.s.line(ax, ay, cx, cy);
    s.s.line(cx, cy, bx, by);
    haromScreen(s, ax*ratio+cx*(1-ratio), ay*ratio+cy*(1-ratio), ax*(1-ratio)+bx*ratio, ay*(1-ratio)+by*ratio, level-1, ratio);
  }
}

void triangleCenterScreen(color c, int sw, int sz) {
  screens[1].drawTriangle(c, sw, screenW, screenH/2, sz);
  screens[2].drawTriangle(c, sw, 0, screenH/2, sz);
}


//////////////////////////////////////////////////////////////////////////////////
// NETWORK CIRCLE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/434620
// Koï Koï
ArrayList<Star> constellation;
int n;
float dd;

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
        dd = constellation.get(i).loc.dist(constellation.get(j).loc); // Distance between two stars
        if (dd <= width / 10) { // if d is less than width/10 px, we draw a line between the two stars
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


//////////////////////////////////////////////////////////////////////////////////
// NERVOUS WAVES 2
//////////////////////////////////////////////////////////////////////////////////
// Levente Sandor, 2014
// https://www.openprocessing.org/sketch/153224
void displayNervous() {
  noiseDetail(2, 0.9);
  rectMode(CENTER);
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.fill(255);
    s.s.noStroke();

    for (int x = 10; x < screenW; x += 10) {
      for (int y = 10; y < screenH; y += 10) {
        float n = noise(x * 0.005, y * 0.005, frameCount * 0.05);
        s.s.pushMatrix();
        s.s.translate(x, y);
        s.s.rotate(TWO_PI * n);
        s.s.scale(10 * n);
        s.s.rect(0, 0, 1, 1);
        s.s.popMatrix();
      }
    }
    s.s.endDraw();
  }
  rectMode(CORNER);
}


//////////////////////////////////////////////////////////////////////////////////
// CIRCLE PULSE
//////////////////////////////////////////////////////////////////////////////////
/**
 * @author aa_debdeb
 * https://www.openprocessing.org/sketch/385808
 */

void initLACircle() {
  size(640, 640);
  noFill();
  strokeWeight(2);
}

void displayLACircle() {
  background(238, 243, 239);
  translate(width / 2, height / 2);
  float radius = 200;
  float step = 5;
  for (float y = -radius + step / 2; y <= radius - step / 2; y += step) {
    float X = sqrt(sq(radius) - sq(y)); 
    float cRate = map(y, -radius + step / 2, radius + step / 2, 0, 1);
    stroke(lerpColor(color(69, 189, 207), color(234, 84, 93), cRate));
    beginShape();
    for (float x = -X; x <= X; x += 1) {
      vertex(x, y);
    }
    endShape();
  }
}



//////////////////////////////////////////////////////////////////////////////////
// WAVY CIRCLE
//////////////////////////////////////////////////////////////////////////////////
//https://www.openprocessing.org/sketch/399221
color c1 = #191970;
color c2 = #ECF0F1;
int count = 19;
float r = 120;
float d = 8.25;
int MAX = 330;

void initWavyCircle() {
}

void displayWavyCircle() {
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.smooth();
    //s.s.background(c1);
    s.s.ellipseMode(RADIUS);
    s.s.noStroke();

    s.s.fill(c1, 100);
    s.s.rect(0, 0, screenW, screenH);
    s.s.fill(c2, 100);

    s.s.pushMatrix();
    s.s.translate(screenW/ 2, screenH / 2);
    for (int n = 1; n < count; n++) {
      for (float a = 0; a <= 360; a += 1) {
        float progress = constrain(map(frameCount%MAX, 0+n*d, MAX+(n-count)*d, 0, 1), 0, 1);
        float ease = -0.5*(cos(progress * PI) - 1);
        float phase = 0 + 2*PI*ease + PI + radians(map(frameCount%MAX, 0, MAX, 0, 360));
        float x = map(a, 0, 360, -r, r);
        float y = r * sqrt(1 - pow(x/r, 2)) * sin(radians(a) + phase);
        s.s.ellipse(x, y, 1.5, 1.5);
      }
    }
    s.s.popMatrix();
  }
}

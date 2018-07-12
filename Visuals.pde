//////////////////////////////////////////////////////////////////////////////////
// STRIPES
//////////////////////////////////////////////////////////////////////////////////

float angleStriped = 0;
float[] stripedAngles;
color red, yellow, white, gray, black, blue, cyan, pink, lime;

void initColors() {
  blue = color(0, 100, 255);
  cyan = color(0, 255, 255);
  pink = color(#FF05C5);
  red = color(255, 0, 0);
  white = color(255);
  gray = color(150);
  yellow = color(255, 255, 0);
  black = 0;
  lime = color(#6BFF03);
}

void initStripedSquares(int num) {
  stripedAngles = new float[num];
  for (int i = 0; i < num; i++) {
    stripedAngles[i] = random(2 * PI);
  }
}
void displayStriped(int lineW) {
  for (int j = 0; j < stripedAngles.length; j++) { 
    pushMatrix();
    translate(width/2, height/2);
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
  int x = (maskPoints[keystoneNum][2].x+maskPoints[keystoneNum][7].x)/2; 
  int y = (maskPoints[keystoneNum][2].y+maskPoints[keystoneNum][7].y)/2;
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
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.strokeWeight(sw);
    s.stroke(c);
    haromScreen(s, ax, ay, bx, by, 6, (sin(0.0005*millis()%(2*PI))+1)/2);
    s.endDraw();
  }
}

void haromS(PGraphics s, color c, int sw) {
  float ax = s.width-30;
  float bx = 30;
  float ay = s.height-50;
  float by = ay;
  s.strokeWeight(sw);
  s.stroke(c);
  haromScreen(s, ax, ay, bx, by, 6, (sin(0.0005*millis()%(2*PI))+1)/2);
  s.endDraw();
}

void haromScreen(PGraphics s, float ax, float ay, float bx, float by, int level, float ratio) {
  if (level!=0) {
    float vx, vy, nx, ny, cx, cy;
    vx=bx-ax;
    vy=by-ay;
    nx=cos(PI/3)*vx-sin(PI/3)*vy; 
    ny=sin(PI/3)*vx+cos(PI/3)*vy; 
    cx=ax+nx;
    cy=ay+ny;
    s.line(ax, ay, bx, by);
    s.line(ax, ay, cx, cy);
    s.line(cx, cy, bx, by);
    haromScreen(s, ax*ratio+cx*(1-ratio), ay*ratio+cy*(1-ratio), ax*(1-ratio)+bx*ratio, ay*(1-ratio)+by*ratio, level-1, ratio);
  }
}

void triangleCenterScreen(color c, int sw, int sz) {
  screens[1].drawTriangle(c, sw, screenW, screenH/2, sz);
  screens[2].drawTriangle(c, sw, 0, screenH/2, sz);
}

//////////////////////////////////////////////////////////////////////////////////
// NETWORK CONSTELLATIONS
//////////////////////////////////////////////////////////////////////////////////
// Network V.0
Node[] nodes;
Node[] nodesMain;

void initNodes(PGraphics s) {
  nodes = new Node[20];
  for (int i = 0; i < nodes.length; i++) {
    nodes[i] = new Node(s);
  }
}

void initNodesMain() {
  nodesMain = new Node[20];
  int minY = maskPoints[keystoneNum][0].y;
  int maxY = maskPoints[keystoneNum][9].y + 50;
  for (int i = 0; i < nodes.length; i++) {
    nodes[i] = new Node(minY, maxY);
  }
}

void initNodesSym(int numScreens) {
  nodes = new Node[10];
  for (int i = 0; i < nodes.length; i++) {
    nodes[i] = new Node(numScreens);
  }
}

void updateNodeConstellation(PGraphics s) {
  updateNodeConstellation(s, 150);
}

void updateNodeConstellationMain() {
  int minY = maskPoints[keystoneNum][0].y;
  int maxY = maskPoints[keystoneNum][9].y + 50;
  for (int i=0; i<nodes.length; i++) {
    nodes[i].move(minY, maxY);
  }
}



void updateNodeConstellation(PGraphics s, int maxY) {
  for (int i=0; i<nodes.length; i++) {
    nodes[i].move(s, maxY);
  }
}
void displayNodeConstellation(PGraphics s) {
  int dis = 75;
  for (int i=0; i<nodes.length; i++) {
    nodes[i].display(s);
    for (int j = 0; j < nodes.length; j++) {
      if (i != j && nodes[i].connect(nodes[j], dis)) {
        s.stroke(255);
        s.strokeWeight(2);
        s.line(nodes[i].pos.x, nodes[i].pos.y, nodes[j].pos.x, nodes[j].pos.y);
      }
    }
  }
}

void updateNodeSymbols() {
  for (int i=0; i<nodes.length; i++) {
    nodes[i].moveSym(2);
  }
}

void displayNodeConstellationMain() {
  int dis = 150;
  for (int i=0; i<nodes.length; i++) {
    nodes[i].display();
    for (int j = 0; j < nodes.length; j++) {
      if (i != j && nodes[i].connect(nodes[j], dis)) {
        stroke(255);
        line(nodes[i].pos.x, nodes[i].pos.y, nodes[j].pos.x, nodes[j].pos.y);
      }
    }
  }
}


class Node {
  PVector pos, vel;
  int sym = int(random(6));
  Node(PGraphics s) {
    this.pos = new PVector(random(s.width), random(s.height));
    this.vel = new PVector(random(-3, 3), random(-3, 3));
  }

  Node(int numScreens) {
    this.pos = new PVector(random(screenW * numScreens), random(screenH));
    this.vel = new PVector(random(-3, 3), random(-3, 3));
  }

  Node(int minY, int maxY) {
    this.pos = new PVector(random(width), random(minY, maxY));
    this.vel = new PVector(random(-3, 3), random(-3, 3));
  }

  void display(PGraphics s) {
    s.fill(245);
    s.ellipse(this.pos.x, this.pos.y, 5, 5);
  }
  void display() {
    fill(245);
    ellipse(this.pos.x, this.pos.y, 5, 5);
  }
  void displaySym(PGraphics s, int screenNum, int size) {
    s.image(symbols[sym], -screenW * screenNum + this.pos.x, this.pos.y, size, symbols[sym].height * size*1.0/symbols[sym].width);
  }
  void moveSym(int numScreens) {
    this.pos.add(vel);
    if (this.pos.x > screenW*numScreens) this.pos.x = 0;
    else if (this.pos.x < 0) this.pos.x = screenW*numScreens;

    if (this.pos.y > screenH) this.pos.y = 0;
    else if (this.pos.y < 0) this.pos.y = screenH;
  }
  void move(PGraphics s, int maxY) {
    this.pos.add(vel);
    if (this.pos.x > s.width) this.pos.x = 0;
    else if (this.pos.x < 0) this.pos.x = s.width;

    if (this.pos.y > maxY) this.pos.y = 0;
    else if (this.pos.y < 0) this.pos.y = maxY;
  }
  void move(int minY, int maxY) {
    this.pos.add(vel);
    if (this.pos.x > width) this.pos.x = 0;
    else if (this.pos.x < 0) this.pos.x = width;

    if (this.pos.y > maxY) this.pos.y = minY;
    else if (this.pos.y < minY) this.pos.y = maxY;
  }

  void moveHand(int minY, int maxY, float lr) {
    PVector veltemp = new PVector(4*lr, this.vel.y);
    this.pos.add(veltemp);
    if (this.pos.x > width) this.pos.x = 0;
    else if (this.pos.x < 0) this.pos.x = width;

    if (this.pos.y > maxY) this.pos.y = minY;
    else if (this.pos.y < minY) this.pos.y = maxY;
  }
  boolean connect(Node other, int dis) {
    float d = pos.dist(other.pos);
    if (d < dis) {
      return true;
    } else {
      return false;
    }
  }
}

void displaySymbolParticlesCenter() {
  updateNodeSymbols();
  for (int j = 0; j < 2; j++) {
    PGraphics s = screens[j + 1].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(LIGHTEST);
    for (int i=0; i<nodes.length; i++) {
      nodes[i].displaySym(s, j, 140);
    }
    s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// NERVOUS WAVES 2
//////////////////////////////////////////////////////////////////////////////////
// Levente Sandor, 2014
// https://www.openprocessing.org/sketch/153224
void displayNervous(PGraphics s) {
  noiseDetail(2, 0.9);
  rectMode(CENTER);
  s.beginDraw();
  s.background(0);
  s.fill(255);
  s.noStroke();

  for (int x = 10; x < s.width; x += 10) {
    for (int y = 10; y < s.height; y += 10) {
      float n = noise(x * 0.005, y * 0.005, frameCount * 0.05);
      s.pushMatrix();
      s.translate(x, y);
      s.rotate(TWO_PI * n);
      s.scale(10 * n);
      s.rect(0, 0, 1, 1);
      s.popMatrix();
    }
  }
  s.endDraw();
  rectMode(CORNER);
}

void displayNervous2Screens() {
  displayNervous(screens[1].s);
  displayNervous(screens[2].s);
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



//////////////////////////////////////////////////////////////////////////////////
// TESSERACT
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/205544
Tesseract tesseract;

void initTesseract() {
  tesseract = new Tesseract();
}

void displayTesseract2Screens(float speed) {
  updateTesseractBeat(speed);
  displayTesseract(screens[1].s);
  displayTesseract(screens[2].s);
}

int tessMode = 0;
void updateTesseractBeat(float speed) {
  if (currentCycle > previousCycle && currentCycle%8 == 1) tessMode++;
  if (tessMode%6 == 0) tesseract.turn(0, 1, .01);
  else if (tessMode%6 == 1) tesseract.turn(0, 2, speed);
  else if (tessMode%6 == 2) tesseract.turn(1, 2, speed);
  else if (tessMode%6 == 3) tesseract.turn(0, 3, speed);
  else if (tessMode%6 == 4) tesseract.turn(1, 3, speed);
  else if (tessMode%6 == 5) tesseract.turn(2, 3, speed);
}

void displayTesseract(PGraphics s) {
  s.beginDraw();
  s.background(0);
  displayTesseractNoBack(s);
  s.endDraw();
}

void displayTesseractNoBack(PGraphics s) {
  s.stroke(255);
  s.strokeWeight(2);
  s.pushMatrix();
  s.translate(s.width/2, s.height/2);
  tesseract.display(s);
  s.popMatrix();
}

class Tesseract {
  float[][][] lines;
  float x, y, z, w, perspZ, perspW, size;

  Tesseract() {
    size=screenW/14;
    z=5;
    w=1;
    perspZ=4;
    perspW=1;

    float[][][] temp={
      {{1, 1, 1, 1}, {-1, 1, 1, 1}}, 
      {{1, 1, 1, 1}, { 1, -1, 1, 1}}, 
      {{1, 1, 1, 1}, { 1, 1, -1, 1}}, 
      {{1, 1, 1, 1}, { 1, 1, 1, -1}}, 

      {{-1, -1, 1, 1}, { 1, -1, 1, 1}}, 
      {{-1, -1, 1, 1}, {-1, 1, 1, 1}}, 
      {{-1, -1, 1, 1}, {-1, -1, -1, 1}}, 
      {{-1, -1, 1, 1}, {-1, -1, 1, -1}}, 

      {{-1, 1, -1, 1}, { 1, 1, -1, 1}}, 
      {{-1, 1, -1, 1}, {-1, -1, -1, 1}}, 
      {{-1, 1, -1, 1}, {-1, 1, 1, 1}}, 
      {{-1, 1, -1, 1}, {-1, 1, -1, -1}}, 

      {{-1, 1, 1, -1}, { 1, 1, 1, -1}}, 
      {{-1, 1, 1, -1}, {-1, -1, 1, -1}}, 
      {{-1, 1, 1, -1}, {-1, 1, -1, -1}}, 
      {{-1, 1, 1, -1}, {-1, 1, 1, 1}}, 

      {{1, -1, -1, 1}, {-1, -1, -1, 1}}, 
      {{1, -1, -1, 1}, { 1, 1, -1, 1}}, 
      {{1, -1, -1, 1}, { 1, -1, 1, 1}}, 
      {{1, -1, -1, 1}, { 1, -1, -1, -1}}, 

      {{1, -1, 1, -1}, {-1, -1, 1, -1}}, 
      {{1, -1, 1, -1}, { 1, 1, 1, -1}}, 
      {{1, -1, 1, -1}, { 1, -1, -1, -1}}, 
      {{1, -1, 1, -1}, { 1, -1, 1, 1}}, 

      {{1, 1, -1, -1}, {-1, 1, -1, -1}}, 
      {{1, 1, -1, -1}, { 1, -1, -1, -1}}, 
      {{1, 1, -1, -1}, { 1, 1, 1, -1}}, 
      {{1, 1, -1, -1}, { 1, 1, -1, 1}}, 

      {{-1, -1, -1, -1}, { 1, -1, -1, -1}}, 
      {{-1, -1, -1, -1}, {-1, 1, -1, -1}}, 
      {{-1, -1, -1, -1}, {-1, -1, 1, -1}}, 
      {{-1, -1, -1, -1}, {-1, -1, -1, 1}}};

    lines=temp;
  }

  void turn(int a, int b, float deg) {
    float[] temp;
    for (int j=0; j<2; j++)
      for (int i=0; i<32; i++) {
        temp=lines[i][j];
        lines[i][j][a]=temp[a]*cos(deg)+temp[b]*sin(deg);
        lines[i][j][b]=temp[b]*cos(deg)-temp[a]*sin(deg);
      }
  }

  void persp(float[][][] arr) {
    for (int j=0; j<2; j++)
      for (int i=0; i<32; i++) {
        arr[i][j][0]=arr[i][j][0]+(arr[i][j][0]+x)*((arr[i][j][2]+z)/perspZ+(arr[i][j][3]+w)/perspW);
        arr[i][j][1]=arr[i][j][1]+(arr[i][j][1]+y)*((arr[i][j][2]+z)/perspZ+(arr[i][j][3]+w)/perspW);
      }
  }

  void resize(float[][][] arr) {
    for (int i=0; i<32; i++)
      for (int j=0; j<2; j++)
        for (int k=0; k<4; k++)
          arr[i][j][k]*=size;
  }

  void display(PGraphics s) {
    float[][][] temp = new float[32][2][4];
    for (int i=0; i<32; i++)
      for (int j=0; j<2; j++)
        for (int k=0; k<4; k++)
          temp[i][j][k]=lines[i][j][k];
    persp(temp);
    resize(temp);
    for (int i=0; i<32; i++)
      s.line(temp[i][0][0], temp[i][0][1], temp[i][1][0], temp[i][1][1]);
  }
}


//////////////////////////////////////////////////////////////////////////////////
// PARTICLES
//////////////////////////////////////////////////////////////////////////////////
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/17163*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
class particle {
  PVector x;
  PVector v;
  PVector f;
  particle() {
    x = new PVector(random(0, screenW*4), random(0, screenH));
    v = new PVector();
    f = new PVector();
  }
  void update() {
    v.add(f);
    f = new PVector(0, 0.02);
    x.add(v);
  }
}
ArrayList particles;
float diam = 10;
float suck = 1.2;
float k = 0.1;
float c = 0.01;
void initParticles() {
  particles = new ArrayList();
  for (int i=0; i<300; i++) {
    particles.add(new particle());
  }
}
void updateParticles() {
  for (int i=1; i<particles.size(); i++) {
    particle A = (particle) particles.get(i);
    for (int j=0; j<i; j++) {
      particle B = (particle) particles.get(j);
      PVector dx = PVector.sub(B.x, A.x);
      if (abs(dx.x)<diam*suck) {
        if (abs(dx.y)<diam*suck) {
          if (dx.mag()<diam*suck) {
            float restore = (diam - dx.mag())*k;
            dx.normalize();
            float dampen = dx.dot(PVector.sub(B.v, A.v))*c;
            dx.mult(restore - dampen);
            A.f.sub(dx);
            B.f.add(dx);
          }
        }
      }
    }
  }
  for (int i=0; i<particles.size(); i++) {
    particle A = (particle) particles.get(i);
    PVector mouseV = new PVector(mouseX, mouseY);
    PVector pmouseV = new PVector(pmouseX, pmouseY);
    if (mousePressed) {
      PVector dx = PVector.sub(A.x, mouseV);
      float pushrad = 8;
      if (abs(dx.x)<pushrad) {
        if (abs(dx.y)<pushrad) {
          if (dx.mag()<pushrad) {
            //            dx.normalize();
            //            A.f.add(PVector.mult(dx,0.8));
            A.v.add(PVector.mult(PVector.sub(
              PVector.sub(mouseV, pmouseV), A.v), 0.2));
          }
        }
      }
    }
    boolean dampen = false;
    if (A.x.x<0) {
      A.f.x -= A.x.x*k;
      dampen = true;
    };
    if (A.x.x>width) {
      A.f.x -= (A.x.x-width)*k;
      dampen = true;
    };
    if (A.x.y<0) {
      A.f.y -= A.x.y*k;
      dampen = true;
    };
    if (A.x.y>height) {
      A.f.y -= (A.x.y-height)*k;
      dampen = true;
    };
    if (dampen) {
      A.v.mult(0.9);
    }
    A.update();
  }
}
void displayParticles() {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    for (int i=0; i<particles.size(); i++) {
      particle A = (particle) particles.get(i);
      if (A.x.x > j * screenW && A.x.x <= (j+1) * screenW) {
        screens[j].s.fill(255);
        screens[j].s.ellipse(A.x.x, A.x.y, diam, diam);
      }
    }
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// RAINBOW
//////////////////////////////////////////////////////////////////////////////////
void displayRainbow() {
  int j = 0;
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.colorMode(HSB, 255);
    s.s.background((frameCount+50*j)%255, 255, 255);
    s.s.endDraw();
    j++;
  }
}
void displayShadowRainbow() {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.colorMode(HSB, 255);
    if (j%2 == 0) screens[j].s.background(frameCount%255, 200, 255, 255);
    else screens[j].s.background(frameCount%255, 200, 255, 100);
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// SHADOW LINES
//////////////////////////////////////////////////////////////////////////////////
void displayShadowLines(int hue, int sz, int sp) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.colorMode(HSB, 255);

    screens[j].s.noStroke();
    int ynum = screenH/(sz+sp);
    int ysp = (screenH - ynum * (sz+sp))/2;
    for (int k = 0; k < 5; k++) {
      for (int i = 0; i < screenH/(sz+sp); i++) {
        if (j%2 == 0) screens[j].s.fill(hue, 255, 255, 150 + k * 20);
        else screens[j].s.fill((hue-10)%255, 255, 105, 150 + k * 20);
        if (j%2==0) screens[j].s.rect(ysp, ysp+i * (sz+sp), screenW-ysp*2-5*k, sz-5*k);
        else screens[j].s.rect(ysp+i * (sz+sp), ysp, sz-5*k, screenW-ysp*2-5*k);
      }
    }
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// FROZEN BRUSH
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////
// PERLIN NOISE
//////////////////////////////////////////////////////////////////////////////////
int spacingTerr, colsTerr, rowsTerr;
float[][] terrain;
float flyingTerr = 0;
float flyingTerrInc = 0.01;
boolean flyingTerrOn = true;
float xoffInc = 0.2;
boolean acceleratingTerr = true;
int lastCheckedTerr = 0;
boolean beginningTerrain = false;
boolean addAudioAmp = false;
float audioAmpLev = 0;
float audioLev = 0;

void initTerrainCenter() {
  int w = 800; 
  int h = 500; 
  int spacing = 20;
  this.colsTerr = w/spacing;
  this.rowsTerr = h/spacing;
  this.spacingTerr = spacing;
  terrain = new float[colsTerr][rowsTerr];
}

void resetAudioAmp() {
  addAudioAmp = false;
  audioAmpLev = 0;
}

void startAudioAmp() {
  addAudioAmp = true;
}

void fadeAudioLev(float start, float end, float rampStart, float rampEnd) {
  float seconds = songFile.position()/1000.0;
  // fade in audio amp 
  if (seconds < start + rampStart) audioLev = constrain(map(seconds, start, start + rampStart, 0, 1), 0, 1);
  // fade out audio amp
  else if (seconds > end - rampEnd) audioLev = constrain(map(seconds, end - rampEnd, end, 1, 0), 0, 1);
}

void fadeAudioAmp(float start, float end, float rampStart, float rampEnd) {
  float seconds = songFile.position()/1000.0;
  // fade in audio amp 
  if (seconds < start + rampStart) audioAmpLev = constrain(map(seconds, start, start + rampStart, 0, 1), 0, 1);
  // fade out audio amp
  else if (seconds > end - rampEnd) audioAmpLev = constrain(map(seconds, end - rampEnd, end, 1, 0), 0, 1);
}

void cycleAudioAmp(float per) {
  float period = per * 2 * PI;
  audioLev = audioAmpLev*sin(period);
}

void setSinGrid(float tempo) {
  for (int y = 0; y < rowsTerr; y++) {
    for (int x = 0; x < colsTerr; x++) {
      terrain[x][y] = 10* sin(tempo * millis()/1000.0 + y*5.0);
    }
  }
}


void setAudioGrid(float flyingTerrInc) {

  if (flyingTerrOn) flyingTerr -= flyingTerrInc;

  float yoff = flyingTerr;

  for (int y = 0; y < rowsTerr; y++) {
    float xoff = 0;
    float amp = 0.1;
    for (int x = 0; x < colsTerr; x++) {
      //float f = getFreq(map(x, 0, colsTerr, 0, 100));


      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      //terrain[x][y] += f*amp;
      //terrain[x][y] += map(y,0,rowsTerr,-f*amp,f*amp);
      xoff += xoffInc;
    }
    yoff += xoffInc;
  }
}

void updateFlying(int delayT) {
  if (flyingTerrOn) {
    if (acceleratingTerr) {
      flyingTerr -= 0.3;
      if (millis() - lastCheckedTerr > delayT) {
        acceleratingTerr = false;
      }
    } else {
      flyingTerr -= flyingTerrInc;
    }
  }
}

int startingTerrain = -1400;
int endingTerrain = -150;
int zZoom = 0;

void initZZoom() {
  zZoom = startingTerrain;
}

void zoomTerrain(float startT, float endT) {
  float currentT = songFile.position()/1000.0;
  zZoom = int(map(currentT, startT, endT, startingTerrain, endingTerrain));
  //zZoom += speed;
  zZoom = constrain(zZoom, startingTerrain, endingTerrain);
}

void setGridTerrain(int mode, float param) {
  if (mode == 0) setAudioGrid(param);
  else if (mode == 1) setSinGrid(param);
  else if (mode == 1) setSinGrid(param);
}

void displayTerrainCenter() {
  if (centerScreen != null) {
    PGraphics s = centerScreen.s;
    //setGrid();

    s.beginDraw();
    s.background(0);
    s.pushMatrix();
    s.translate(screenW*2, screenH/2, 0);
    if (beginningTerrain) s.rotateX(radians(millis()/100.0));
    else s.rotateX(radians(60));

    s.translate(0, zZoom, 0);
    s.noFill();
    s.stroke(255);
    s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
    s.colorMode(HSB, 255);
    for (int y = 0; y < rowsTerr-1; y++) {
      s.beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < colsTerr; x++) {
        //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
        s.vertex(x * spacingTerr, y * spacingTerr, terrain[x][y]*audioLev);
        s.vertex(x * spacingTerr, (y+1) * spacingTerr, terrain[x][y+1]*audioLev);
      }
      s.endShape();
    }
    s.popMatrix();
    s.endDraw();
  }
}

// return frequency from 0 to 100 at x (band) between 0 and 100
float getFreq(float col) {
  int x = constrain((int)col, 0, 100);
  x = (int)(x * (bands.length/100.0));
  return constrain(bands[x], 0, 100);
}

//////////////////////////////////////////////////////////////////////////////////
// NOISE STRIP
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/203961
/*
author:  lisper <leyapin@gmail.com> 2015
 desc:    noise led strip
 This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
 */
float nx = 0;
float ny = 0;
float nz = 0;
float nxcolor;
float nycolor;
float nzcolor;

void drawStream () {

  int ind = 0;
  for (Screen sc : screens) {
    //nx = 0;
    //nxcolor = 0;
    nx = 0.02 * screenW/20 * ind;
    nxcolor= 0.1 * screenW/20 * ind;
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.colorMode(HSB);
    s.stroke (255);
    s.strokeWeight(3);
    for (int i=0; i<= screenW; i += 20) {
      ny = 0;
      nycolor=0;
      for (int j=50; j<= screenW; j += 100) {
        float n = noise (nx, ny, nz);
        float angle = map (n, 0, 1.0, 0, 6*PI);
        float x = 50 * cos (angle);
        float y = 40 * sin (angle);
        //int c = constrain( int (map( noise (nxcolor, nycolor, nzcolor), 0, 1.0, -200, 400)), 0, 255);
        int c = int (map( noise (nxcolor, nycolor, nzcolor), 0, 1.0, 0, 255));
        //println (c);
        //s.stroke (c*2);
        s.stroke (c);
        s.line (i-x, j-y, i+x, j+y);
        ny += 0.5;
        nycolor += 0.3;
      }
      nxcolor += 0.1;
      nx += 0.02;
    }
    s.endDraw();
    ind++;
    nz +=0.001;
    nzcolor += 0.001;
  }
}

//////////////////////////////////////////////////////////////////////////////////
// TREE BRANCHES
//////////////////////////////////////////////////////////////////////////////////
//https://www.openprocessing.org/sketch/144159
class pathfinder {
  PVector location;
  PVector velocity;
  float diameter;
  pathfinder(PGraphics s) {
    location = new PVector(s.width/2, s.height);
    velocity = new PVector(0, -1);
    diameter = 32;
  }
  pathfinder(pathfinder parent) {
    location = parent.location.copy();
    velocity = parent.velocity.copy();
    float area = PI*sq(parent.diameter/2);
    float newDiam = sqrt(area/2/PI)*2;
    diameter = newDiam;
    parent.diameter = newDiam;
  }
  void update() {
    if (diameter>0.5) {
      location.add(velocity);
      PVector bump = new PVector(random(-1, 1), random(-1, 1));
      bump.mult(0.1);
      velocity.add(bump);
      velocity.normalize();
      if (random(0, 1)<0.02) {
        paths = (pathfinder[]) append(paths, new pathfinder(this));
      }
      //} else if (location.x < -400) resetTreeBranchesAll();
    }
  }
}
pathfinder[] paths;
void initTreeBranchesAll() {
  smooth();
  paths = new pathfinder[1];
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    paths[0] = new pathfinder(s);
    s.beginDraw();
    s.background(0);
    s.endDraw();
  }
}

void updateTreeBranches() {
  //resetTreeBranchesAll();
  for (int i=0; i<paths.length; i++) {
    paths[i].update();
  }
  if (currentCycle > previousCycle && currentCycle%16 == 0) resetTreeBranchesAll();
}
void displayTreeBranchesOuter() {
  for (int j = 0; j < 4; j +=3) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    displayTreeBranches(s, j);
    s.endDraw();
  }
}

void displayTreeBranchesTop() {
  for (int j = 0; j < 2; j++) {
    PGraphics s = topScreens[j].s;
    s.beginDraw();
    displayTreeBranches(s, j+4);
    s.endDraw();
  }
}

void displayTreeBranches() {
  for (int j = 0; j < 4; j +=3) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    displayTreeBranches(s, j);
    s.endDraw();
  }
}

void displayTreeBranches(PGraphics s, int screenNum) {
  s.ellipseMode(CENTER);
  s.fill(255);
  s.noStroke();
  for (int i=0; i<paths.length; i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    if (screenNum == 3)  s.ellipse(screenW-loc.x, loc.y, diam, diam);
    else s.ellipse(loc.x, loc.y, diam, diam);
  }
}
void displayTreeBranchesInner() {
  for (int j = 1; j < 3; j++) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    s.ellipseMode(CENTER);
    s.fill(55);
    s.noStroke();
    for (int i=0; i<paths.length; i++) {
      PVector loc = paths[i].location;
      float diam = paths[i].diameter;
      if (j == 1)  s.ellipse(screenW-loc.x, loc.y, diam, diam);
      else s.ellipse(loc.x, loc.y, diam, diam);
      //paths[i].update();
    }
    s.endDraw();
  }
}
void resetTreeBranchesAll() {
  PGraphics s = screens[0].s;
  paths = new pathfinder[1];
  paths[0] = new pathfinder(s);
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.background(0);
    sc.s.endDraw();
  }
  for (Screen sc : topScreens) {
    sc.s.beginDraw();
    sc.s.background(0);
    sc.s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// TREE BRANCHES
//////////////////////////////////////////////////////////////////////////////////
float thetaFTree; 
void displayFractalTreeAll(int mode) {
  int j = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.stroke(c);
    s.strokeWeight(2);
    s.pushMatrix();
    // Let's pick an angle 0 to 90 degrees based on the mouse position
    float a = (mouseX / (float) s.width) * 90f;
    if (mode == 1) a = 40*sin(frameCount/100.0 + j * 0.35); // (mouseX / (float) s.width) * 90f 
    // Convert it to radians
    thetaFTree = radians(a);
    // Start the tree from the bottom of the screen
    s.translate(s.width/2, s.height);
    // Draw a line 120 pixels
    s.line(0, 0, 0, -120);
    // Move to the end of that line
    s.translate(0, -120);
    // Start the recursive branching!
    //s.scale(3);
    branch(s, 120);
    s.popMatrix();
    s.endDraw();
    j++;
  }
}

void displayFractalTreeSong() {
  for (int j = 0; j < 6; j++) {
    if (j == 0 || j == 3) displayFractalTree(screens[j].s, color(255));
    else if (j == 1 || j == 2) displayFractalTree(screens[j].s, color(55));
    else  displayFractalTree(topScreens[j-4].s, color(255));
  }
}

void displayFractalTree(PGraphics s, color c) {
  s.beginDraw();
  s.background(0);
  s.stroke(c);
  s.blendMode(BLEND);
  s.strokeWeight(2);
  s.pushMatrix();
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = (mouseX / (float) s.width) * 90f;
  //if (mode == 1) a = 40*sin(frameCount/100.0 + j * 0.35); // (mouseX / (float) s.width) * 90f 
  // Convert it to radians
  thetaFTree = radians(a);
  // Start the tree from the bottom of the screen
  s.translate(s.width/2, s.height);
  // Draw a line 120 pixels
  s.line(0, 0, 0, -120);
  // Move to the end of that line
  s.translate(0, -120);
  // Start the recursive branching!
  //s.scale(3);
  branch(s, 120);
  s.popMatrix();
  s.endDraw();
}
void branch(PGraphics s, float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;

  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    s.pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    s.rotate(thetaFTree);   // Rotate by theta
    s.line(0, 0, 0, -h);  // Draw the branch
    s.translate(0, -h); // Move to the end of the branch
    branch(s, h);       // Ok, now call myself to draw two new branches!!
    s.popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    s.pushMatrix();
    s.rotate(-thetaFTree);
    s.line(0, 0, 0, -h);
    s.translate(0, -h);
    branch(s, h);
    s.popMatrix();
  }
}


//////////////////////////////////////////////////////////////////////////////////
// WAVES
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/546665
void displayWavesCenter() {
  if (centerScreen != null) {
    cycleWaves(centerScreen.s);
    PGraphics s = centerScreen.s;
    s.beginDraw();
    s.background(0);  
    for (int i = 0; i < waves.size(); i++) {
      Wave w = waves.get(i);
      if (w != null) {
        w.tick();
        w.display(s);
      }
    }
    s.endDraw();
  }
}
ArrayList<Wave> waves;
void initWaves() {
  waves = new ArrayList();
}

class Wave {
  PVector pos, dim;

  Wave(int x, int y) {
    pos = new PVector(x, y);
    dim = new PVector(0, 0);
  }

  void display(PGraphics s) {
    s.stroke(255);
    s.strokeWeight(5);
    s.noFill();
    s.ellipse(pos.x, pos.y, dim.x, dim.y);
  }

  void tick() {
    dim.add(new PVector(3, 3));
    if (dim.x > width*2) {
      waves.remove(this);
    }
  }
}


void cycleWaves(PGraphics s) {
  //updateSpectrum();
  //beatCycle(500);
  if (currentCycle > previousCycle) {
    waves.add(new Wave(s.width/2, s.height/2));
    //previousCycle = currentCycle;
  }
}


//////////////////////////////////////////////////////////////////////////////////
// LINES BOUNCE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/449873
// modified by jdeboi
float angleBottom = 0;

void displayLineBounceAll(color c1, color c2, int sw) {
  for (Screen s : screens) {
    displayLineBounce(s.s, 30, c2, c2, sw);
  }
  angleBottom += 0.01;
}
void displayLineBounceCenter(float rate, int spacing, color c1, color c2, int sw) {
  if (centerScreen != null) displayLineBounce(centerScreen.s, spacing, c1, c2, sw);
  angleBottom += rate;
}
void set2ScreensBlend(int mode) {
  for (int i = 1; i < 3; i++) {
    screens[i].s.beginDraw();
    screens[i].s.blendMode(SCREEN);
    screens[i].s.endDraw();
  }
}
void displayLineBounce(PGraphics s, int spacing, color c1, color c2, int sw) {
  s.beginDraw();
  s.background(0);
  s.blendMode(SCREEN);
  s.strokeWeight(sw);
  int w = s.width;
  int h = s.height ;
  int centerX = w/2;
  //int bottomY = h-50;
  int bottomY = h;
  int centerY = bottomY/2;
  for (int i = 0; i<w; i+=spacing) {
    // 0 -> 1, not 0 -> 2h
    color c = lerpColor(c1, c2, map(i, 0, w, 0, 1));
    s.stroke(c);
    float yMove = bottomY/2-sin(angleBottom)*bottomY/2;
    s.line(centerX, bottomY, i, yMove); // bottom lines
    yMove = bottomY/2+sin(angleBottom)*bottomY/2;
    s.line(centerX, 0, i, yMove);         // top lines
  }
  for (int i = 0; i<=bottomY; i+=spacing) {

    float xMove = centerX/2 + sin(angleBottom)*centerX/2;
    s.line(0, i, xMove, centerY);        // left to right lines

    xMove = w-sin(angleBottom)*w/4 - w/4;
    // between w and w/2
    s.line(xMove, centerY, w, i);
  }
  s.endDraw();
}

// https://www.openprocessing.org/sketch/53155
void displayLinesMouse(PGraphics s) {
  s.stroke(0);
  s.strokeWeight(1);
  s.background(200);
  for (int y = 0; y < s.height+45; y += 40) {
    for (int x = 0; x <= s.width; x += 40) {
      s.line(mouseX, mouseY, x, y);
    }
  }
}


//////////////////////////////////////////////////////////////////////////////////
// MOVING THROUGH SPACE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/96938
ArrayList<PVector> starsSpace;
int convergeX = 1;
int convergeY = 1;

void initStarSpace() {
  starsSpace = new ArrayList<PVector>();
}
void displayMoveSpaceCenter(int mode, float speed) {
  if (centerScreen != null) displayMoveSpace(centerScreen.s, mode, speed);
}

void displayMoveSpaceCenterCycle(float speed) {
  cycleStarsSpaceModes();
  if (centerScreen != null) displayMoveSpace(centerScreen.s, speed);
}

void displayMoveSpaceAll(int mode, float speed) {
  speed = constrain(speed, 0.6, 1.0);
  convergeX = (mode/3)%3;
  convergeY = mode%3;
  int wfull = screenW * 4;
  int controlX = int(map(convergeX, 0, 2, wfull*(1-speed), wfull*speed));
  int controlY = int(map(convergeY, 0, 2, screenH*(1-speed), screenH*speed));
  float w2=screenW*2;
  float h2= screenH/2;
  float d2 = dist(0, 0, w2, h2);
  int maxSizeStar = 5;
  int minSizeStar = 3;
  for (int i = 0; i<80; i++) {   // star init
    starsSpace.add(new PVector(random(wfull), random(screenH), random(minSizeStar, maxSizeStar)));
  }
  for (int i = 0; i<starsSpace.size(); i++) {
    float x =starsSpace.get(i).x;//local vars
    float y =starsSpace.get(i).y;
    float d =starsSpace.get(i).z;

    /* movement+"glitter"*/
    starsSpace.set(i, new PVector(x-map(controlX, 0, wfull, -0.05, 0.05)*(w2-x), y-map(controlY, 0, screenH, -0.05, 0.05)*(h2-y), d+0.2-0.6*noise(x, y, frameCount)));

    if (d>maxSizeStar||d<-3) starsSpace.set(i, new PVector(x, y, maxSizeStar));
    if (x<0||x>wfull||y<0||y>screenH) starsSpace.remove(i);
    if (starsSpace.size()>399) starsSpace.remove(1);
  }
  for (int j = 0; j < screens.length; j++ ) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    s.noStroke();
    s.fill(0, map(dist(controlX, controlY, w2, h2), 0, d2, 255, 5));
    s.rect(0, 0, s.width, s.height);
    s.fill(255);

    for (int i = 0; i<starsSpace.size(); i++) {
      float x =starsSpace.get(i).x;//local vars
      float y =starsSpace.get(i).y;
      float d =starsSpace.get(i).z;
      s.ellipse(x -j *screenW, y, d, d);//draw stars
    }
    s.endDraw();
  }
}

void displayMoveSpace(PGraphics s, int mode, float speed) {
  //int controlX = mouseX;
  //int controlY = mouseY;
  speed = constrain(speed, 0.6, 1.0);
  convergeX = (mode/3)%3;
  convergeY = mode%3;
  int controlX = int(map(convergeX, 0, 2, s.width*(1-speed), s.width*speed));
  int controlY = int(map(convergeY, 0, 2, s.height*(1-speed), s.height*speed));
  float w2=s.width/2;
  float h2= s.height/2;
  float d2 = dist(0, 0, w2, h2);
  s.beginDraw();
  s.noStroke();
  s.fill(0, map(dist(controlX, controlY, w2, h2), 0, d2, 255, 5));
  s.rect(0, 0, s.width, s.height);
  s.fill(255);

  for (int i = 0; i<20; i++) {   // star init
    starsSpace.add(new PVector(random(s.width), random(s.height), random(1, 3)));
  }

  for (int i = 0; i<starsSpace.size(); i++) {
    float x =starsSpace.get(i).x;//local vars
    float y =starsSpace.get(i).y;
    float d =starsSpace.get(i).z;

    /* movement+"glitter"*/
    starsSpace.set(i, new PVector(x-map(controlX, 0, s.width, -0.05, 0.05)*(w2-x), y-map(controlY, 0, s.height, -0.05, 0.05)*(h2-y), d+0.2-0.6*noise(x, y, frameCount)));

    if (d>3||d<-3) starsSpace.set(i, new PVector(x, y, 3));
    if (x<0||x>s.width||y<0||y>s.height) starsSpace.remove(i);
    if (starsSpace.size()>999) starsSpace.remove(1);
    s.ellipse(x, y, d, d);//draw stars
  }
  s.endDraw();
}

void displayMoveSpace(PGraphics s, float speed) {
  //int controlX = mouseX;
  //int controlY = mouseY;
  speed = constrain(speed, 0.6, 1.0);
  int controlX = int(map(convergeX, 0, 2, s.width*(1-speed), s.width*speed));
  int controlY = int(map(convergeY, 0, 2, s.height*(1-speed), s.height*speed));
  float w2=s.width/2;
  float h2= s.height/2;
  float d2 = dist(0, 0, w2, h2);
  s.beginDraw();
  s.noStroke();
  s.fill(0, map(dist(controlX, controlY, w2, h2), 0, d2, 255, 5));
  s.rect(0, 0, s.width, s.height);
  s.fill(255);

  for (int i = 0; i<20; i++) {   // star init
    starsSpace.add(new PVector(random(s.width), random(s.height), random(1, 3)));
  }

  for (int i = 0; i<starsSpace.size(); i++) {
    float x =starsSpace.get(i).x;//local vars
    float y =starsSpace.get(i).y;
    float d =starsSpace.get(i).z;

    /* movement+"glitter"*/
    starsSpace.set(i, new PVector(x-map(controlX, 0, s.width, -0.05, 0.05)*(w2-x), y-map(controlY, 0, s.height, -0.05, 0.05)*(h2-y), d+0.2-0.6*noise(x, y, frameCount)));

    if (d>3||d<-3) starsSpace.set(i, new PVector(x, y, 3));
    if (x<0||x>s.width||y<0||y>s.height) starsSpace.remove(i);
    if (starsSpace.size()>999) starsSpace.remove(1);
    s.ellipse(x, y, d, d);//draw stars
  }
  s.endDraw();
}

void cycleStarsSpaceModes() {
  updateSpectrum();
  beatCycle(500);
  if (currentCycle > previousCycle) {
    convergeX = (currentCycle/3)%3;
    convergeY = currentCycle%3;

    //previousCycle = currentCycle;
  }
}

//////////////////////////////////////////////////////////////////////////////////
// RED PLANET
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/422775
ArrayList<PVector> pathPoints = new ArrayList<PVector> ();
void displayRedPlanetAll() {
  for (Screen s : screens) {
    displayRedPlanet(s.s);
  }
}
void displayRedPlanetSphere() {
  displayRedPlanet(sphereScreen.s);
}
void displayRedPlanet(PGraphics s) {
  s.beginDraw();
  //create the path
  pathPoints = circlePoints(s);

  for (int j=0; j<8; j++) {
    pathPoints = complexifyPath(pathPoints);
  }

  //draw the path

  s.stroke(random(100, 255), 20, 120, random(10, 55));
  //filter(BLUR,0.571) ;
  for (int i=0; i<pathPoints.size() -1; i++) {
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i+1);
    s.line(v1.x, v1.y, v2.x, v2.y);
  }
  s.endDraw();
}

ArrayList<PVector>   complexifyPath(ArrayList<PVector> pathPoints) {
  //create a new path array from the old one by adding new points inbetween the old points
  ArrayList<PVector> newPath = new ArrayList<PVector>();

  for (int i=0; i<pathPoints.size() -1; i++) {
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i+1);
    PVector midPoint = PVector.add(v1, v2).mult(0.5);
    float distance =  v1.dist(v2);

    //the new point is halfway between the old points, with some gaussian variation
    float standardDeviation = 0.125*distance;
    PVector v = new PVector((randomGaussian()-0.5)*standardDeviation+midPoint.x, (randomGaussian()-0.5)*standardDeviation+midPoint.y);
    newPath.add(v1);
    newPath.add(v);
  }

  //don't forget the last point!
  newPath.add(pathPoints.get(pathPoints.size()-1));
  return newPath;
}

ArrayList<PVector> circlePoints(PGraphics s) {
  //two points somewhere on a circle
  float r = s.height/2.1;
  int x = s.width/2;
  int y = s.height/2;
  //float theta1 = random(TWO_PI);
  float theta1 = (randomGaussian()-0.5)*PI/4;
  float theta2 = theta1 + (randomGaussian()-0.5)*PI/3;
  PVector v1 = new PVector(x + r*cos(theta1), x+ r*sin(theta1) );
  PVector v2 = new PVector(x + r*cos(theta2), x + r*sin(theta2));
  ArrayList<PVector> vecs = new ArrayList<PVector>();
  vecs.add(v1);
  vecs.add(v2);
  return vecs;
}


//////////////////////////////////////////////////////////////////////////////////
// MOONS
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/219297
color moonColor = #ffe699;
int moonFrames = 250;
int moonCell = 108;
float moonDelay = 0;
int moonColumns = 12;
int moonRows = 1;

//Draws the rows and columns of moons.
//Adds a delay for each moon.
// radius 40
void displayMoonsAcross(int moonRadius) {
  for (int k = 0; k < screens.length; k++) {
    PGraphics s = screens[k].s;
    s.beginDraw();
    s.background(0);
    s.noStroke(); 

    for (int j = 0; j < moonRows; j++) {
      for (int i = 0; i < moonColumns/4; i++) {
        float x = i*moonCell;
        //float y = j*moonCell;
        float y = 100;
        s.pushMatrix();
        s.translate(x, y);
        float t = (((frameCount)%moonFrames*1.5)/(float)moonFrames)+moonDelay;
        drawMoon(s, moonRadius, t);
        moonDelay = moonDelay+0.025;
        s.popMatrix();
      }
    }

    s.endDraw();
  }
  moonDelay = 0;
}

void drawMoonSphere(PImage moon) {
  float shadow = 0.0;
  PGraphics s = createGraphics(sphereScreen.s.width, sphereScreen.s.height);
  s.beginDraw();
  s.background(0);
  s.noStroke(); 
  int moonRadius = s.width;
  s.fill(0, 40);
  //s.rect(0, 0, s.width, s.height);
  s.pushMatrix();
  s.translate(s.width/2, s.height/2);
  color moonColor = color(255);//color(255, 0, 0, 40);
  color noColor = color(0, 0);
  float t = songFile.position()/(songFile.length()*1.0);
  if (t < 0.5) { 
    float tt = map(t, 0, 0.5, 0, 1); 


    if (tt < 0.5) { 
      if (tt < 0.13) shadow = map(tt, 0, 0.13, 0, 0.04);
      else shadow = map(tt, 0.13, 0.5, 0.04, 0.0);

      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left moon
      s.fill(0);
      // orig
      //float r = map(tt, 0, 0.5, moonRadius, 0);
      //s.arc(0, 0, r, moonRadius, PI/2, PI*1.5); //left background shrinking
      //s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2);



      for (int i = 0; i < 5; i++) {
        float r = map(tt, 0, 0.5, moonRadius, 0);
        s.fill(200 - i * 50);
        s.arc(0, 0, constrain(r - i*(moonRadius*shadow), 0, moonRadius), moonRadius, PI/2, PI*1.5); //left background shrinking
      }
      s.fill(0);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2);
    } else {

      if (tt < 0.5 + 0.13) shadow = map(tt, 0.5, 0.5 + 0.13, 0, 0.04);
      else shadow = map(tt, 0.5 + 0.13, 1, 0.04, 0.0);

      float r = map(tt, 0.5, 1, 0, moonRadius);
      s.fill(moonColor);
      // orig
      //s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right moon growing
      //s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left moon

      s.fill(moonColor);
      s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right moon growing
      for (int i = 5; i >= 0; i--) {
        s.fill(255 - i * 50);
        s.arc(0, 0, constrain(r + i*(moonRadius*shadow), 0, moonRadius), moonRadius, -PI/2, PI/2); //right moon growing
      }
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left moon
    }
    //Moon shrinking to new moon
  } else if (t < 1.0) {
    float tt = map(t, 0.5, 1, 0, 1);

    if (tt < 0.5) {
      if (tt < 0.13) shadow = map(tt, 0, 0.13, 0, 0.04);
      else shadow = map(tt, 0.13, 0.5, 0.04, 0.0);

      float r = map(tt, 0, 0.5, moonRadius, 0); 
      s.fill(0);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left background
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      // orig
      //s.arc(0, 0, r, moonRadius, PI/2, PI*1.5); //left moon shrinking



      s.fill(moonColor);
      for (int i = 0; i < 5; i++) {
        s.fill(50 + i * 50);
        s.arc(0, 0, constrain(r-i*(moonRadius*shadow), 0, moonRadius), moonRadius, PI/2, PI*1.5); //left moon shrinking
      }
    } else {
      if (tt < 0.5 + 0.13) shadow = map(tt, 0.5, 0.5 + 0.13, 0, 0.04);
      else shadow = map(tt, 0.5 + 0.13, 1, 0.04, 0.0);

      float r = map(tt, 0.5, 1, 0, moonRadius); 
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      s.fill(0);
      // orig
      //s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right background growing

      s.fill(0);
      for (int i = 5; i >= 0; i--) {
        s.fill(i * 50);
        s.arc(0, 0, constrain(r+(i*moonRadius*shadow), 0, moonRadius), moonRadius, -PI/2, PI/2); //right background growing
      }
    }
  }
  s.popMatrix();
  s.endDraw();

  PImage m = moon.copy();
  m.mask(s);
  PGraphics sp = sphereScreen.s;
  sp.beginDraw();
  sp.background(0);
  sp.image(m, 0, 0);
  sp.endDraw();
}

//Draws a moon. 
//This function is a modifiend version of "the moon" by Jerome Herr.
void drawMoon(PGraphics s, int moonRadius, float t) {
  if (t > 1.5) t -= 1.5;
  s.translate(moonCell, moonCell);
  //Moon growing to full moon
  if (t < 0.5) { 
    float tt = map(t, 0, 0.5, 0, 1); 
    if (tt < 0.5) { 
      float r = map(tt, 0, 0.5, moonRadius, 0);
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left moon
      s.fill(0);
      s.arc(0, 0, r, moonRadius, PI/2, PI*1.5); //left background shrinking
    } else {
      float r = map(tt, 0.5, 1, 0, moonRadius);
      s.fill(moonColor);
      s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right moon growing
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left moon
    }
    //Moon shrinking to new moon
  } else if (t < 1.0) {
    float tt = map(t, 0.5, 1, 0, 1);
    if (tt < 0.5) {
      float r = map(tt, 0, 0.5, moonRadius, 0); 
      s.fill(0);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5); //left background
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      s.arc(0, 0, r, moonRadius, PI/2, PI*1.5); //left moon shrinking
    } else {
      float r = map(tt, 0.5, 1, 0, moonRadius); 
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      s.fill(0);
      s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right background growing
    }
  } else if (t < 1.5) {
    s.fill(0);
  }
}

//////////////////////////////////////////////////////////////////////////////////
// FLOWY WAVES
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/133048
float myPerlin;
float cFW=0;
float dFW=0;
float eFW=0;
//float x=0;
float yFW=0;
float randPerl;
int startCountFW = 300;
float countFW=startCountFW;
float  mapHeightFW;
int modeFW = 0;
PGraphics tempImg;
PGraphics tempSphere;

void initAllFlowyWaves() {
  tempImg = createGraphics(screenW*2, screenH);

  mapHeightFW = screenH/2;
  tempImg.beginDraw();
  tempImg.background(0);
  colorMode(RGB, 255);

  countFW = startCountFW;
  tempImg.endDraw();
}

void displayFlowyWavesWiz() {
  int fadeStart = 1150;
  int fadeEnd = 1200;
  int mh = screenH/2;
  updateFlowyWaves(fadeEnd, mh, true);
  displayFlowyWavesTemp(fadeStart, fadeEnd, true);
  int i = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.blendMode(BLEND);
    if (i < 2) {
      int startX = int(screenW*i);
      s.image(tempImg, -startX, 0);
    } else {
      s.pushMatrix();
      s.scale(-1.0, 1.0);
      int startX = int(screenW*i);
      if (i == 3) startX = screenW;
      s.image(tempImg, -startX, 0);
      s.popMatrix();
    }
    s.blendMode(SCREEN);
    //s.image(currentGifs.get(4), 0, 0);

    //drawSymbolsLeftRightImageHand(s, i, 250);
    drawSymbolsLeftRightSmoothImageHand(s, i, 250);
    //displayNodeConstellation(s);
    s.endDraw();
    i++;
  }
}

void displayFlowyWavesTemp(int fadeStart, int fadeEnd, boolean blackBG ) {
  tempImg.beginDraw();
  if (!blackBG) {
    if (countFW > fadeStart) fadeFWToWhiteTemp(fadeStart, fadeEnd);
  } else {
    if (countFW < startCountFW + 3) tempImg.background(0);
  }
  tempImg.noFill();
  changePerlin();
  changeColorTemp(countFW);
  paintFWTemp(); 
  tempImg.endDraw();
}
void updateFlowyWaves() {
  updateFlowyWaves(1200, screenH/2, true);
}

void updateFlowyWaves(int fadeEnd, int mh, boolean blackBG) {
  countFW++;
  if (countFW > fadeEnd) {
    if (blackBG) {
      countFW = startCountFW;
      mapHeightFW = mh;
    } else {
      countFW = 100;
      mapHeightFW = screenH;
    }
  }
  mapHeightFW=mapHeightFW-1;
}
void fadeFWToWhite(PGraphics s, int fadeStart, int fadeEnd) {
  s.noStroke();
  color c = getColorFW(0);
  s.fill(hue(c), saturation(c), brightness(c), map(countFW, fadeStart, fadeEnd, 2, 50));
  s.rect(0, 0, s.width, s.height);
}

void fadeFWToWhiteTemp(int fadeStart, int fadeEnd) {
  fadeFWToWhite(tempImg, fadeStart, fadeEnd);
}

void changeColor(PGraphics s, float cnt) {
  s.colorMode(HSB);
  s.stroke(getColorFW(cnt));
}

void changeColorTemp(float cnt) {
  tempImg.colorMode(HSB);
  tempImg.stroke(getColorFW(cnt));
}
color getColorFW(float cnt) {
  //cFW = sin(radians(cnt))+1;
  //dFW = sin(radians(cnt+30))+1;
  //eFW = sin(radians(cnt+60))+1;
  //cFW = map(cFW, 0, 1, 0, 255);
  //dFW = map(dFW, 0, 1, 0, 255);
  //eFW = map(eFW, 0, 1, 0, 255);
  //return color(cFW, dFW, 220);

  float per = map(cnt, 300, 1200, 0, 1);
  color c = getCycleColor(red, cyan, blue, per);
  return c;
}

void paintFWTemp() {
  float myY=0;

  for (int x=0; x<tempImg.width; x=x+1) {
    myPerlin = noise(float(x)/200 + tempImg.width/200, countFW/200);
    myY = map(myPerlin, 0, 1, 0, tempImg.height-mapHeightFW);
    tempImg.line(x, myY, x, tempImg.height);
  }
}
void paintFW(PGraphics s, float phase, boolean blackBG) {
  float myY=0;
  for (int x=0; x<s.width; x=x+1) {
    myPerlin = noise(float(x)/200 + phase*s.width/200, countFW/200);
    myY = map(myPerlin, 0, 1, 0, s.height-mapHeightFW);
    tempImg.line(x, myY, x, s.height );
  }
}

void changePerlin() {
  myPerlin = noise(countFW);
}


//////////////////////////////////////////////////////////////////////////////////
// FADE
//////////////////////////////////////////////////////////////////////////////////
boolean startFade = false;
long startFadeTime = 0;


void fadeOutCubes(float startT, float seconds) {
  int alph =  getFadeOutAlpha(startT, seconds);
  for (Screen s : screens) {
    s.drawFadeAlpha(alph);
  }
}
void fadeInCubes(float startT, float  seconds) {
  int alph = getFadeInAlpha(startT, seconds);
  for (Screen s : screens) {
    s.drawFadeAlpha(alph);
  }
}

void fadeOutCenter(float startT, float seconds) {
  int alph = getFadeOutAlpha(startT, seconds);
  if (centerScreen != null) centerScreen.drawFadeAlpha(alph);
}

void fadeInCenter(float startT, float  seconds) {
  int alph = getFadeInAlpha(startT, seconds);
  if (centerScreen != null) centerScreen.drawFadeAlpha(alph);
}

int getFadeOutAlpha(float startT, float seconds) {
  float playSeconds = songFile.position()/1000.0;
  float timePassed = playSeconds - startT;
  return constrain(int(map(timePassed, 0, seconds, 0, 255)), 0, 255);
}

int getFadeInAlpha(float startT, float  seconds) {
  float playSeconds = songFile.position()/1000.0;
  float timePassed = playSeconds - startT;
  return constrain(int(map(timePassed, 0, seconds, 255, 0)), 0, 255);
}

void fadeInAllScreens(float startT, int seconds) {
  int alph = getFadeInAlpha(startT, seconds);
  setAllScreensAlpha(alph);
}

void fadeOutAllScreens(float startT, float  seconds) {
  int alph = getFadeOutAlpha(startT, seconds);
  setAllScreensAlpha(alph);
}

void setAllScreensAlpha(int alph) {
  for (Screen s : screens) {
    s.drawFadeAlpha(alph);
  }
  for (Screen s : topScreens) {
    s.drawFadeAlpha(alph);
  }
  sphereScreen.drawFadeAlpha(alph);
  if (centerScreen != null) centerScreen.drawFadeAlpha(alph);
}

void resetFade() {
  startFade = false;
}

//////////////////////////////////////////////////////////////////////////////////
// 2 point
//////////////////////////////////////////////////////////////////////////////////
SpaceRect[] spaceRects;
float zVel = 1.7;
int rectSpacing = 80;

int endPSpaceRects = -1200;
int frontPSpaceRects = 100;
int numRects = (-endPSpaceRects+frontPSpaceRects)/rectSpacing;
int direction2Point = 1;
void initSpaceRects() {
  spaceRects = new SpaceRect[numRects];
  for (int r = 0; r < spaceRects.length; r++) {
    spaceRects [r] = new SpaceRect(new PVector(0, 0, endPSpaceRects+rectSpacing*r), new PVector(0, 0, zVel) );
  }
}

boolean hasResetRects = true;
void resetSpaceRects(boolean zoomIn) {
  if (!hasResetRects) {
    hasResetRects = true;
    for (int r = 0; r < spaceRects.length; r++) {
      if (zoomIn) spaceRects[r].pos.set(0, 0, -endPSpaceRects+rectSpacing*r-1200); // not going to work with cycling
      else spaceRects[r].pos.set(0, 0, endPSpaceRects+rectSpacing*r);
    }
  }
}
// only onerect at a time changing colors through gradient
void displaySpaceRects(int sw, int mode, color c1, color c2, color c3) {
  for (int i = 1; i < 3; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    s.rectMode(CENTER);
    s.pushMatrix();
    s.translate(s.width/2, s.height/2);
    for (int j = 0; j < numRects; j++) {
      s.noFill();
      s.strokeWeight(sw);
      spaceRects[j].zGradientStroke(s, c1, c2, c3);
      spaceRects[j].display(s);
      if (i== 1)spaceRects[j].update(mode);
    }
    s.popMatrix();
    s.rectMode(CORNER);
    s.endDraw();
  }
}

void displayTwoScreenCascade() {
  //PGraphics s = centerScreen.s;
  for (int j = 1; j < 3; j++) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    s.blendMode(BLEND);
    //s.fill(0, 1);
    //s.rect(0, 0, s.width, s.height);
    s.background(0, 100, 0, 1);
    s.blendMode(SCREEN);
    s.noFill();
    s.strokeWeight(10);
    int num = 10;
    int spacing = 100;
    int bounceD = 200;
    s.noFill();
    s.strokeWeight(10);
    for (int i = 0; i < num; i++) {
      spaceRects[i].pos.z = sin(millis()/2000.0 + i * .2) * bounceD - bounceD - i * spacing;
      spaceRects[i].zGradientStroke(s, cyan, blue, pink);
      spaceRects[i].display(s);
    }
    s.endDraw();
  }
}

void displayTwoWayTunnels() {
  if (centerScreen != null) {
    PGraphics s = centerScreen.s;
    s.beginDraw();
    s.blendMode(SCREEN);
    s.background(0);
    //int spacing = 50;
    //for (int i = 0; i < s.height; i += spacing) {
    //  line(0, 0, 
    //int z = (millis()/2%(-endPSpaceRects+400))+endPSpaceRects;
    //displayTunnelCenter(150, 3, 0,z, color(0, 255, 255), color(0, 0, 255), false);
    //displayTunnelCenter(150, 3, 0,-z, color(0, 255, 255), color(0, 0, 255), false);
    int num = 5;
    int spacing = 20;
    int bounceD = 400;
    s.noFill();
    s.strokeWeight(10);
    for (int i = 0; i < num; i++) {
      spaceRects[i].pos.z = sin(millis()/2000.0 + i * .2) * bounceD - bounceD - i * spacing;
      spaceRects[i].zGradientStroke(s, cyan, blue, pink);
      spaceRects[i].display(s);
    }
    for (int i = num; i < num*2 && i < spaceRects.length; i++) {
      spaceRects[i].pos.z = cos(millis()/1000.0 + i * .2) * bounceD - bounceD - i * spacing;
      spaceRects[i].zGradientStroke(s, cyan, blue, pink);
      spaceRects[i].display(s);
    }
    s.endDraw();
  }
}

float sphereCycle = 0;
void paradiseSphere(int spacing, color c1, color c2, color c3) {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.background(0);
  s.noFill();
  s.strokeWeight(5);
  for (int i = s.width; i >= spacing; i -= spacing) {
    float per = map(i, s.width, 0, 0, 0.5);
    per += millis()/4000.0;
    per %= 1;
    s.stroke(paradiseStrokeReturn(per, c1, c2, c3));
    s.ellipse(s.width/2, s.height/2, i, i);
  }
  //sphereCycle += 0.02;
  //if (sphereCycle > 1) sphereCycle = 0;
  s.endDraw();
}

color paradiseStrokeReturn(float per, color c1, color c2, color c3) {
  per *= 3;
  if (per < 1) return lerpColor(c1, c2, per);
  else if (per < 2) return lerpColor(c2, c3, per-1);
  return lerpColor(c3, c1, per-2);
}

color paradiseStroke(float per, color c1, color c2, color c3) {
  per *= 2;
  if (per < 1) return lerpColor(c1, c2, per);
  return lerpColor(c2, c3, per-1);
}

void displayTunnel2Screens(int len, int num, int gap, int z, color c1, color c2, boolean isGradient) {
  displayTunnel(screens[1].s, len, num, gap, z, c1, c2, isGradient);
  displayTunnel(screens[1].s, len, num, gap, z, c1, c2, isGradient);
}

void displayTunnelCenter(int len, int num, int gap, int z, color c1, color c2, boolean isGradient) {
  if (centerScreen != null) displayTunnel(centerScreen.s, len, num, gap, z, c1, c2, isGradient);
}
void displayTunnel(PGraphics s, int len, int num, int gap, int z, color c1, color c2, boolean isGradient) {
  //s.pointLight(255, 255, 255, s.width/2 + 50* sin(millis()/1000.0),s.height/2 + 47* sin(millis()/700.0), -100);
  s.noStroke();

  for (int i = 0; i < num; i++) {
    // top

    s.pushMatrix();
    s.rotateX(radians(-90 + gap));
    s.translate(0, -z, 0);
    float per;
    if (num > 1) per = map(i, 0, num -1, 0, 1);
    else per = 1;
    s.fill(lerpColor(c1, c2, per));
    s.beginShape();
    if (isGradient) s.fill(c1);
    s.vertex(-1, -1);
    s.vertex(s.width+1, -1);
    if (isGradient) s.fill(c2);
    s.vertex(s.width+1, len);
    s.vertex(-1, len);
    s.endShape();
    s.popMatrix();

    // bottom
    s.pushMatrix();
    s.rotateX(radians(-90));
    s.translate(0, 0, s.height);
    s.rotateX(radians(-gap));
    s.translate(0, -z, 0);

    s.beginShape();
    if (isGradient) s.fill(c1);
    s.vertex(-1, -1);
    s.vertex(s.width+1, -1);
    if (isGradient) s.fill(c2);
    s.vertex(s.width+1, len);
    s.vertex(-1, len);
    s.endShape();
    s.popMatrix();

    // left
    s.pushMatrix();
    s.rotateY(radians(90 - gap));
    s.translate(-z, 0, 0);

    s.beginShape(QUADS);
    if (isGradient) s.fill(c1);
    s.vertex(-1, -1);
    if (isGradient) s.fill(c2);
    s.vertex(len, -1);
    s.vertex(len, s.height+1);
    if (isGradient) s.fill(c1); 
    s.vertex(-1, s.height+1);
    s.endShape();
    s.popMatrix();

    // right
    s.pushMatrix();
    s.rotateY(radians(90));
    s.translate (0, 0, s.width);
    s.rotateY(radians(gap));
    s.translate(-z, 0, 0);

    s.beginShape(QUADS);
    if (isGradient) s.fill(c1);
    s.vertex(-1, -1);
    if (isGradient) s.fill(c2);
    s.vertex(len, -1);
    s.vertex(len, s.height+1);
    if (isGradient) s.fill(c1); 
    s.vertex(-1, s.height+1);
    s.endShape();
    s.popMatrix();
    z -= len;
  }
}

void displayCenterSpaceRects(int sw, int mode, color c1, color c2, color c3) {
  if (centerScreen != null) {
    PGraphics s = centerScreen.s;
    s.beginDraw();
    s.background(0);
    s.rectMode(CENTER);
    s.pushMatrix();
    s.translate(s.width/2, s.height/2);
    for (int j = 0; j < numRects; j++) {
      s.noFill();
      s.strokeWeight(sw);
      spaceRects[j].zGradientStroke(s, c1, c2, c3);
      spaceRects[j].display(s);
      spaceRects[j].update(mode);
    }
    s.popMatrix();
    s.rectMode(CORNER);
    s.endDraw();
  }
}


boolean cyclingRects = true;
class SpaceRect {

  float w, h;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector rot;

  SpaceRect(PVector p, PVector v) {
    pos = p;
    vel = v;
    acc = new PVector(0, 0);
    rot = new PVector(0, 0);
  }

  void update(int mode) {
    pos.add(vel);
    if (cyclingRects) {
      if (pos.z > frontPSpaceRects) pos.z = endPSpaceRects;
      else if (pos.z < endPSpaceRects) pos.z = frontPSpaceRects;
    }
    vel.add(acc);

    int NONE = -1;
    int SUPER_TRIPPY = 0;
    int KINDA_TRIPPY = 1;
    int SORTA_TRIPPY = 2;
    int SEESAW = 3;
    float timePassed = (songFile.position()/1000.0 - cues[currentCue].startT);
    if (mode == NONE) rot.z = 0;

    else if (mode == SUPER_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, timePassed);
    else if (mode == KINDA_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, timePassed/5); //map(pos.z, endPSpaceRects, frontPSpaceRects, 0, frameCount/100.0);
    else if (mode == SORTA_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, timePassed/10);
    else if (mode == SEESAW)  vel.z = zVel * 4 * sin(millis()/500.0);
  }


  void display(PGraphics s) {
    s.pushMatrix();
    s.rotateX(rot.x);
    s.rotateY(rot.y);
    s.rotateZ(rot.z);
    s.translate(pos.x, pos.y, pos.z);
    float dw = map(pos.z, frontPSpaceRects, endPSpaceRects, 0, 14*numRects);
    if (pos.z > endPSpaceRects) s.rect(0, 0, s.width-dw, s.height-dw);
    s.popMatrix();
  }
  void displayTopSides(PGraphics s) {
    s.pushMatrix();
    s.rotateX(rot.x);
    s.rotateY(rot.y);
    s.rotateZ(rot.z);
    s.translate(pos.x, pos.y, pos.z);
    float dw = map(pos.z, frontPSpaceRects, endPSpaceRects, 0, 14*numRects);
    if (pos.z > endPSpaceRects) {
      s.line(0, 0, s.width-dw, 0);
      s.translate(0, s.height-dw, 0);
      s.line(0, 0, s.width-dw, 0);
    }
    s.popMatrix();
  }

  void displayNeon(PGraphics s, int sw, color c) {
    s.pushMatrix();
    s.rotateX(rot.x);
    s.rotateY(rot.y);
    s.rotateZ(rot.z);
    s.translate(pos.x, pos.y, pos.z);
    float dw = map(pos.z, frontPSpaceRects, endPSpaceRects, 0, 14*numRects);
    neonrect(s, 0, 0, int(s.width-dw), int(s.height-dw), sw, c);
    //s.rect(0, 0, s.width-dw, s.height-dw);
    s.popMatrix();
  }

  void changeRectSpacing(int sp) {
  }

  void zGradientStroke(PGraphics s, color c1, color c2, color c3) {
    float zper = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, 1);
    color grad = paradiseStroke(zper, c1, c2, c3);
    //s.colorMode(HSB, 255);
    //float sat = map(pos.z, endPSpaceRects, endPSpaceRects/2, 0, 255);
    //color grad2 = color(hue(grad), sat, 255);
    //colorMode(RGB, 255);
    s.stroke(grad);
  }


  //void displayCenter(PGraphics s, int side) {
  //  //float sz = map(-pos.z*pos.z, frontPSpaceRects, endPSpaceRects, s.width*4, 0); // spazz
  //  //float sz = map(pos.z*2, frontPSpaceRects, endPSpaceRects, s.width*4, 0);   // cool
  //  float sz = map(pos.z, frontPSpaceRects, endPSpaceRects, s.width*4, 0);
  //  if (side == 1) s.rect(s.width, s.height/2, sz, sz);
  //  else s.rect(0, s.height/2, sz, sz);
  //}
}

//////////////////////////////////////////////////////////////////////////////////
// NEON
//////////////////////////////////////////////////////////////////////////////////

void drawNeonRect(PGraphics s, int x, int y, int w, int h, int sw, color c) {
  s.beginShape();
  neonrect(s, x, y, w, h, sw, c);
  s.endShape();
}

void neonrect(PGraphics s, int x, int y, int w, int h, int sw, color c) {
  //s.ellipse(x0, y0, w, w);
  //s.ellipse(x0, y0, w, w);
  s.pushMatrix();
  s.noStroke();
  neonline(s, x-w/2, y-h/2, x+w/2, y-h/2, sw, c);
  neonline(s, x+w/2, y-h/2, x+w/2, y+h/2, sw, c);
  neonline(s, x+w/2, y+h/2, x-w/2, y+h/2, sw, c);
  //neonline(s, x-w/2, y+h/2, x-w/2, y-h/2, sw, c);

  s.popMatrix();
}
void neonline(PGraphics s, PVector p0, PVector p1, int sw, color c) {
  neonline(s, int(p0.x), int(p0.y), int(p1.x), int(p1.y), sw, c);
}
void neonline(PGraphics s, int x0, int y0, int x1, int y1, int sw, color c) {
  float len = abs(dist(x0, y0, x1, y1));
  float rot = atan2(1.0*(y1-y0), 1.0*(x1-x0));
  println(rot);

  s.pushMatrix();
  s.noStroke();
  s.rotate(rot);
  s.translate(x0, y0);
  for (int i = 4; i >= 0; i--) {
    int w = sw+i*4;

    s.fill(255, 50 + (4-i) * 50);
    s.beginShape(QUAD);
    s.vertex(-len/2, -w/2);
    s.vertex(len/2, -w/2);
    s.vertex(len/2, w/2);
    s.vertex(-len/2, w/2);
    s.endShape();
  }

  s.popMatrix();
}

void cube(PGraphics s, int x0, int y0, int x1, int y1, int sw) {
  s.pushMatrix();
  translate((x0+x1)/2, (y0 + y1)/2);
  cube(s, x1 - x0, sw, sw); 
  s.popMatrix();
}

void cube(PGraphics s, float w, float h, float d) {
  s.beginShape(QUADS);
  // Front face
  s.vertex(-w/2, -h/2, d/2);
  s.vertex(w/2, -h/2, d/2);
  s.vertex(w/2, h/2, d/2);
  s.vertex(-w/2, h/2, d/2);
  //left
  s.vertex(-w/2, -h/2, d/2);
  s.vertex(-w/2, -h/2, -d/2);
  s.vertex(-w/2, h/2, -d/2);
  s.vertex(-w/2, h/2, d/2);
  //right
  s.vertex(w/2, -h/2, d/2);
  s.vertex(w/2, -h/2, -d/2);
  s.vertex(w/2, h/2, -d/2);
  s.vertex(w/2, h/2, d/2);
  //back
  s.vertex(-w/2, -h/2, -d/2);
  s.vertex(w/2, -h/2, -d/2);
  s.vertex(w/2, h/2, -d/2);
  s.vertex(-w/2, h/2, -d/2);
  //top
  s.vertex(-w/2, -h/2, d/2);
  s.vertex(-w/2, -h/2, -d/2);
  s.vertex(w/2, -h/2, -d/2);
  s.vertex(w/2, -h/2, d/2);
  //bottom
  s.vertex(-w/2, h/2, d/2);
  s.vertex(-w/2, h/2, -d/2);
  s.vertex(w/2, h/2, -d/2);
  s.vertex(w/2, h/2, d/2);
  s.endShape();
}

//////////////////////////////////////////////////////////////////////////////////
// DOTS
//////////////////////////////////////////////////////////////////////////////////
PVector rotDots = new PVector(0, 0);
void updateRotDots(int mode, float rotSpeed) {
  if (mode == 0) rotDots.x += rotSpeed;
  else if (mode == 1) rotDots.y += rotSpeed;
  else if (mode == 2) rotDots.z += rotSpeed;
  else if (mode == 3) {
    rotDots.z += rotSpeed;
    rotDots.x += rotSpeed;
  }
}

void display3DDots2Screens(int space, int mode, float rotSpeed) {
  updateRotDots(mode, rotSpeed);
  display3DDots(screens[1].s, space);
  display3DDots(screens[2].s, space);
}

void display3DDots(PGraphics s, int space) {
  s.beginDraw();
  s.background(0);
  s.stroke(255);
  s.fill(255);
  s.strokeWeight(2);
  s.pushMatrix();
  s.translate(width/2, height/2, width/2);
  s.rotateX(rotDots.x);
  s.rotateY(rotDots.y);
  s.rotateZ(rotDots.z);

  s.translate(-width/2, -height/2, -width/2);
  for (int x = 0; x < width; x+= space) {
    for (int y = 0; y < height; y += space) {
      for (int z = 0; z < width; z+= space) {
        s.pushMatrix();
        s.translate(x, y, z);


        s.stroke(map(z, 0, width, 10, 255));
        s.line(0, 0, space, 0);
        s.line(0, 0, 0, space);
        s.pushMatrix();
        s.rotateY(radians(90));
        s.line(0, 0, space, 0);
        s.popMatrix();

        s.noStroke();
        s.fill(255);
        s.ellipse(0, 0, 3, 3);
        s.popMatrix();
      }
    }
  }
  s.popMatrix();
  s.endDraw();
}


//////////////////////////////////////////////////////////////////////////////////
// STRIPED MOON
//////////////////////////////////////////////////////////////////////////////////

void displayStripedMoon(int step) {
  displayLACircle(sphereScreen.s, sphereScreen.s.width/2, step);
}

void displayLACircle(PGraphics s, float radius, float step) {
  s.beginDraw();
  s.pushMatrix();
  s.translate(s.width / 2, s.height / 2);
  for (float y = -radius + step / 2; y <= radius - step / 2; y += step) {
    float X = sqrt(sq(radius) - sq(y)); 
    float cRate = map(y, -radius + step / 2, radius + step / 2, 0, 1);
    float str = map(cRate, 0, 1, 255, 50);
    //s.stroke(lerpColor(color(69, 189, 207), color(234, 84, 93), cRate));
    s.stroke(str);
    s.strokeWeight(3);
    s.fill(str);
    s.beginShape();
    for (float x = -X; x <= X; x += 1) {
      s.vertex(x, y);
    }
    s.endShape();
  }
  s.popMatrix();
  s.endDraw();
}

//////////////////////////////////////////////////////////////////////////////////
// OP ART
//////////////////////////////////////////////////////////////////////////////////
// Richard Anuszkiewicz art
void displayDivisionOfIntensity2Screens(float per, int sqX, int sqY) {
  displayDivisionOfIntensity(screens[1].s, per, sqX, sqY);
  displayDivisionOfIntensity(screens[2].s, per, sqX, sqY);
}
void displayDivisionOfIntensity(PGraphics s, float per, int sqX, int sqY) {
  float period = per * 2 * PI;
  float space = sin(period)*20 + 27;
  space = constrain(space, 5, 55);
  s.beginDraw();
  s.pushMatrix();
  s.background(0);
  s.translate(s.width/2, s.height/2);

  //if (mode == 1) rotateZ(frameCount/100.0);
  //else if (mode == 2) rotateY(frameCount/100.0);
  //else if (mode == 3) rotateX(frameCount/100.0);

  s.strokeWeight(2);
  s.stroke(255);
  int sqThick = 10;
  int sqW = s.width/2;

  int sqSmLen = (sqW-2*sqThick)/2;
  float i = 0;
  while (i < sqSmLen) {

    // top left
    int x0 = sqX - sqSmLen;
    int y0 = sqY - sqSmLen;
    s.line(x0, y0, x0 + sqSmLen, y0 + i);
    s.line(x0, y0, x0 + i, y0 + sqSmLen);

    // top right
    x0 = sqX + sqSmLen;
    y0 = sqY - sqSmLen;
    s.line(x0, y0, x0 - sqSmLen, y0 + i);
    s.line(x0, y0, x0 - i, y0 + sqSmLen);

    // bottom left
    x0 = sqX + sqSmLen;
    y0 = sqY + sqSmLen;
    s.line(x0, y0, x0 - sqSmLen, y0 - i);
    s.line(x0, y0, x0 - i, y0 - sqSmLen);

    // bottom right
    x0 = sqX - sqSmLen;
    y0 = sqY + sqSmLen;
    s.line(x0, y0, x0 + sqSmLen, y0 - i);
    s.line(x0, y0, x0 + i, y0 - sqSmLen);

    // top
    x0 = sqX - sqSmLen + sqThick/2;
    y0 = sqY - sqSmLen - sqThick;
    s.line(x0, y0, x0 + sqSmLen, y0 - i);
    s.line(x0+sqSmLen, y0 - i, x0 + sqSmLen*2 - sqThick, y0);

    // bottom
    x0 = sqX - sqSmLen + sqThick/2;
    y0 = sqY + sqSmLen + sqThick;
    s.line(x0, y0, x0 + sqSmLen, y0 + i);
    s.line(x0+sqSmLen, y0 + i, x0 + sqSmLen*2 - sqThick, y0);

    // left
    x0 = sqX - sqSmLen - sqThick;
    y0 = sqY - sqSmLen + sqThick/2;
    s.line(x0, y0, x0 - i, y0 + sqSmLen);
    s.line(x0 - i, y0 + sqSmLen, x0, y0 + sqSmLen*2 - sqThick);

    // right
    x0 = sqX + sqSmLen + sqThick;
    y0 = sqY - sqSmLen + sqThick/2;
    s.line(x0, y0, x0 + i, y0 + sqSmLen);
    s.line(x0 + i, y0 + sqSmLen, x0, y0 + sqSmLen*2 - sqThick);

    i+= space;
  }
  i = 0;
  while (i < sqSmLen + sqThick) {
    // diag top left
    int x0 = int(sqX - 2 * sqSmLen - 1.5*sqThick);
    int y0 = int(sqY - 2 * sqSmLen - 1.5*sqThick);
    int x1 = int(sqX - .5* sqThick);
    int y1 = y0;
    int x2 = x0;
    int y2 = int(sqY -.5 * sqThick);
    s.line(x0 + i, y0 + i, x1, y1);
    s.line(x0 + i, y0 + i, x2, y2);


    // diag top right
    x0 = int(sqX + 2 * sqSmLen + 1.5*sqThick);
    y0 = int(sqY - 2 * sqSmLen - 1.5*sqThick);
    x1 = int(sqX + 1.5* sqThick);
    y1 = y0;
    x2 = x0;
    y2 = int(sqY -.5 * sqThick);
    s.line(x0 - i, y0 + i, x1, y1);
    s.line(x0 - i, y0 + i, x2, y2);

    // diag bottom right
    x0 = int(sqX + 2 * sqSmLen + 1.5*sqThick);
    y0 = int(sqY + 2 * sqSmLen + 1.5*sqThick);
    x1 = int(sqX + 1.5* sqThick);
    y1 = y0;
    x2 = x0;
    y2 = int(sqY +1.5 * sqThick);
    s.line(x0 - i, y0 - i, x1, y1);
    s.line(x0 - i, y0 - i, x2, y2);

    // diag bottom left
    x0 = int(sqX - 2 * sqSmLen - 1.5*sqThick);
    y0 = int(sqY + 2 * sqSmLen + 1.5*sqThick);
    x1 = int(sqX - .5* sqThick);
    y1 = y0;
    x2 = x0;
    y2 = int(sqY +1.5 * sqThick);
    s.line(x0 + i, y0 - i, x1, y1);
    s.line(x0 + i, y0 - i, x2, y2);

    i+= space;
  }
  s.popMatrix();
  s.endDraw();
}


//////////////////////////////////////////////////////////////////////////////////
// PARTICLE DRIP
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/566877
// Justin Chambers
// 03/2018
// https://www.openprocessing.org/sketch/524376


int particleDensity = 4000;
int visualMode = 0;
int numModes = 4;
boolean invertColors = false;
ParticleDrip [] particles_a, particles_b, particles_c, particlesDrip;

int nums;
float maxLife = 10;
float noiseScale = 200;
float  simulationSpeed = 0.2;
int fadeFrame = 0;

int padding_top = 100;
int padding_side = 100;
int inner_square = 512;

color backgroundColor;
color color_from;
color color_to;
PGraphics s;

void displaySquiggleParticles(PGraphics s) {
  //displayDrip();
  s.beginDraw(); 
  displaySquiggle(s);
  s.endDraw();
}

void displayDripParticles(PGraphics s) {
  //displayDrip();
  s.beginDraw(); 
  displayDrip(s);
  s.endDraw();
}

void initDrip(PGraphics s) {
  randomSeed(0);
  noiseSeed(0);
  nums = 100;

  backgroundColor = 0; //color(20, 20, 20);
  color_from = color(255);
  color_to = color(255);


  //background(backgroundColor);



  padding_top = 0;
  padding_side = 0;

  particlesDrip = new ParticleDrip[nums];
  for (int i = 0; i < nums; i++) {
    ParticleDrip p = new ParticleDrip(s, false);
    p.pos.x = random(padding_side, s.width-padding_side);
    p.pos.y = padding_top;
    particlesDrip[i] = p;
  }
  s.beginDraw();
  s.background(color(0));
  s.endDraw();
}

void displayDrip(PGraphics s) {

  ++fadeFrame;
  if (fadeFrame % 5 == 0) {

    s.blendMode(SUBTRACT);
    s.fill(1, 1, 1);
    s.rect(0, 0, s.width, s.height);

    s.blendMode(LIGHTEST);
    //blendMode(DARKEST); //looks terrible. stutters
    s.fill(backgroundColor);
    s.rect(0, 0, s.width, s.height);
  }

  s.blendMode(BLEND);

  for (int i = 0; i < nums; i++) {
    float iterations = map(i, 0, nums, 5, 1);
    float radius = map(i, 0, nums, 1, 3);

    particlesDrip[i].move(s, iterations);
    particlesDrip[i].checkEdge(s);

    int alpha = 255;

    float particle_heading = particlesDrip[i].vel.heading()/PI;
    if (particle_heading < 0) {
      particle_heading *= -1;
    }
    color particle_color = lerpColor(particlesDrip[i].color1, particlesDrip[i].color2, particle_heading);

    float fade_ratio; //TODO
    fade_ratio = min(particlesDrip[i].life * 5 / maxLife, 1);
    fade_ratio = min((maxLife - particlesDrip[i].life) * 5 / maxLife, fade_ratio);

    s.fill(red(particle_color), green(particle_color), blue(particle_color), alpha * fade_ratio);
    particlesDrip[i].display(s, radius);
  }
}

void initSquiggle(PGraphics s) {
  nums = 200;
  noiseScale = 800;
  particles_a = new ParticleDrip[nums];
  particles_b = new ParticleDrip[nums];
  particles_c = new ParticleDrip[nums];
  for (int i = 0; i < nums; i++) {
    particles_a[i] = new ParticleDrip(s, true);
    particles_b[i] = new ParticleDrip(s, true);
    particles_c[i] = new ParticleDrip(s, true);
  }
}

void displaySquiggle(PGraphics s) {
  s.noStroke();
  s.smooth();
  for (int i = 0; i < nums; i++) {
    float radius = map(i, 0, nums, 2, 3);
    float alpha = map(i, 0, nums, 0, 250);

    s.fill(69, 33, 124, alpha);
    particles_a[i].move();
    particles_a[i].display(s, radius);
    particles_a[i].checkEdge(s);

    s.fill(7, 153, 242, alpha);
    particles_b[i].move();
    particles_b[i].display(s, radius);
    particles_b[i].checkEdge(s);

    s.fill(255, 255, 255, alpha);
    particles_c[i].move();
    particles_c[i].display(s, radius);
    particles_c[i].checkEdge(s);
  }
}


class ParticleDrip {
  // member properties and initialization
  PVector vel, pos, dir;
  float life;
  float flip;
  color color1;
  color color2;
  color c;
  boolean isSquiggle;
  float speed = 0.4;

  ParticleDrip(PGraphics s, boolean isSquiggle) {
    this.isSquiggle = isSquiggle;
    this.vel = new PVector(0, 0);
    this.dir = new PVector(0, 0);
    this.pos = new PVector(random(0, s.width), random(0, s.height));
    this.life = random(0, maxLife);
    this.flip = int(random(0, 2)) * 2 - 1;
    this.color1 = this.color2 = color(255, 0, 0);

    if (int(random(3)) == 1) {
      this.color1 = color_from;
      this.color2 = color_to;
    }
  }

  // member functions
  void move(PGraphics s, float iterations) {
    if ((this.life -= 0.01666) < 0)
      if (!isSquiggle) respawnTop(s);
      else respawn(s);
    while (iterations > 0) {

      float transition = map(this.pos.x, padding_side, s.width-padding_side, 0, 1);
      float angle = noise(this.pos.x/noiseScale, this.pos.y/noiseScale)*transition*TWO_PI*noiseScale;  
      this.vel.x = cos(angle);
      this.vel.y = sin(angle);
      this.vel.mult(simulationSpeed);
      this.pos.add(this.vel);
      --iterations;
    }
  }

  void move() {
    float angle = noise(this.pos.x/noiseScale, this.pos.y/noiseScale)*TWO_PI*noiseScale;
    this.dir.x = cos(angle);
    this.dir.y = sin(angle);
    this.vel = this.dir.copy();
    this.vel.mult(this.speed);
    this.pos.add(this.vel);
  }

  void checkEdge(PGraphics s) {
    if (!isSquiggle) {
      if (this.pos.x > s.width - padding_side
        || this.pos.x < padding_side
        || this.pos.y > s.height - padding_top
        || this.pos.y < padding_top) {
        respawnTop(s);
      }
    } else {
      if (this.pos.x > s.width || this.pos.x < 0 || this.pos.y > s.height || this.pos.y < 0) {
        this.pos.x = random(50, s.width);
        this.pos.y = random(50, s.height);
      }
    }
  }

  void respawn(PGraphics s) {
    this.pos.x = random(0, s.width);
    this.pos.y = random(0, s.height);
    this.life = maxLife;
  }

  void respawnTop(PGraphics s) {
    this.pos.x = random(padding_side, s.width-padding_side);
    this.pos.y = padding_top;
    this.life = maxLife;
  }

  void display(PGraphics s, float r) {
    s.noStroke();
    s.ellipse(this.pos.x, this.pos.y, r, r);
  }
}



//////////////////////////////////////////////////////////////////////////////////
// SPHERE BOX
//////////////////////////////////////////////////////////////////////////////////
PVector sphereBoxRot;
void initSphereBoxRot() {
  sphereBoxRot = new PVector(0, 0, 0);
}
void updateSphereBoxCrush() {
  int index = (currentCycle/2)%4;
  if (index == 0) sphereBoxRot.set(0, percentToNumBeats(2)*PI, 0);
  else if (index == 1) sphereBoxRot.set(0, (1-percentToNumBeats(2))*PI, 0);
  else if (index == 2) sphereBoxRot.set(percentToNumBeats(2)*PI, 0, 0);
  else if (index == 3) sphereBoxRot.set((1-percentToNumBeats(2))*PI, 0, 0);
}
void displaySphereBox(PGraphics s) {
  int SPHERE_RADIUS=s.width/4;
  s.pushMatrix();
  s.translate(s.width/2, s.height/2, 0);
  s.rotateX(sphereBoxRot.x);
  s.rotateY(sphereBoxRot.y);
  s.rotateZ(sphereBoxRot.z);
  s.noFill();
  s.stroke(255, 100);
  s.strokeWeight(1);
  s.sphere(SPHERE_RADIUS);
  s.strokeWeight(3);
  s.box(s.width/2);
  s.popMatrix();
}

void displaySphereBoxCrush() {
  updateSphereBoxCrush();
  for (int i = 1; i < 3; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    if (i == 1) {
      s.pushMatrix();
      s.scale(-1.0, 1.0);
      s.translate(-screenW, 0, 0);
      displaySphereBox(s);
      s.popMatrix();
    } else {
      //s.background(pink);
      displaySphereBox(s);
    }
    s.endDraw();
  }
}


//////////////////////////////////////////////////////////////////////////////////
// CONSTELLATION LINES from Luna
//////////////////////////////////////////////////////////////////////////////////
ConstellationLine[] constellationLines;

void initConstellationLines() {
  constellationLines = new ConstellationLine[10];
  for (int i = 0; i < constellationLines.length; i++) {
    constellationLines[i] = new ConstellationLine(i*200, screenH/2);//int(random(100, 300)));
  }
}

void drawConstellationLines(PGraphics s, int screenNum) {
  for (int i = 0; i < constellationLines.length; i++) {
    constellationLines[i].display(s, screenNum);
  }
}

void moveConstellationLines(int speed) {
  for (int i = 0; i < constellationLines.length; i++) {
    constellationLines[i].move(speed);
  }
}

class ConstellationLine {

  ArrayList<PVector> points;
  int x, y;
  float angle;

  ConstellationLine(int x, int y) {
    this.x = x;
    this.y = y;
    this.angle = random(2 * PI);
    points = new ArrayList<PVector>();
    points.add(new PVector(0, 0));
    randomPoints();
  }

  void display(PGraphics o, int screenNum) {
    int dotS = 10;
    o.pushMatrix();
    o.stroke(255);
    o.strokeWeight(3);
    o.fill(255);
    o.translate(x-screenW*screenNum, y);
    o.rotateZ(this.angle);
    angle += .001;
    for (int i = 0; i < points.size()-1; i++) {
      o.ellipse(points.get(i).x, points.get(i).y, dotS, dotS);
      o.line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
    }
    o.ellipse(points.get(points.size()-1).x, points.get(points.size()-1).y, dotS, dotS);
    o.popMatrix();
  }

  void move(float speed) {
    this.x += speed;
    if (this.x > screenW*4 + 300) this.x = -300;
    else if (this.x < -300) this.x = screenW*4 + 300;
  }

  void randomPoints() {
    int numPoints = int(random(3, 5));
    int p = 1;
    float xp = 0;
    float yp = 0;
    float ang = 0;
    while (p <= numPoints) {
      p++;
      float len = random(100, 200);
      if (p == 3) {
        int join = millis()%3;
        if (join == 0) {
          xp = points.get(1).x;
          yp = points.get(1).y;
        } else if (join == 1) {
          xp = points.get(0).x;
          yp = points.get(0).y;
        } else {
          int num = int(random(1, 8));
          float newAng = num * (2 * PI) / 8;
          xp += len * cos(newAng);
          yp += len * sin(newAng);
        }
      } else {
        int num = int(random(1, 8));
        float newAng = num * (2 * PI) / 8;
        xp += len * cos(newAng);
        yp += len * sin(newAng);
      }
      points.add(new PVector(xp, yp));
    }
  }
}

void displaySymbolLines() {
  for (int j = 1; j < 3; j++) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(LIGHTEST);
    if (millis()/3000%3 == 0) {
      for (int i = 0; i < 4; i++) {
        displaySymbolLine(s, random(s.width/3, s.width/4*3), 30 + random(50)); //s.width/2 + s.width/5 * sin(millis()/500.0 + i), 30 + random(50));
      }
    } else {
      for (int i = 0; i < 4; i++) {
        displaySymbolLine(s, s.width/2, 20);
      }
    }
    s.endDraw();
  }
}


void displaySymbolLine(PGraphics s, float x, float y) {
  int sz = 30;
  int padding = 5;
  for (int i = 0; i < symbols.length; i++) {
    s.image(symbols[i], x, y + i*( sz + padding), sz, sz);
  }
}


//////////////////////////////////////////////////////////////////////////////////
// TRIANGULATION
//////////////////////////////////////////////////////////////////////////////////
//https://github.com/robu3/delaunay
// https://www.openprocessing.org/sketch/385808
ArrayList<PVector> pts;
DelaunayTriangulator dt;

void Triangulate() {
  dt = new DelaunayTriangulator();
  dt.points = pts.toArray(new PVector[pts.size()]);
  dt.triangles = dt.Calculate();
}

void initializeTriangulation(int cuenum) {
  if (cuenum != lastCueDelaunay) {
    lastCueDelaunay = cuenum;
    pts = new ArrayList<PVector>();
    pts.add( new PVector( 0, 0 ) );
    pts.add( new PVector( screenW, 0 ) );
    pts.add( new PVector( screenW, screenH ) );
    pts.add( new PVector( 0, screenH ) );
    // add a certain nb of pts proportionally to the size of the canvas
    // ~~ truncates a floating point number and keeps the integer part, like floor()
    int n = int ( screenW / 300.0 * screenH / 300.0 );
    for ( int i = 0; i < n; i ++ ) {
      pts.add( new PVector( int(random( screenW )), int(random( screenH )) ) );
    }

    Triangulate();
  }
}

public class DelaunayTriangulator {
  PVector[] points;
  ArrayList<Triangle> triangles;

  // sort points in clockwise order (in place)
  // insertion sort
  // NOTE: not currently in use
  private PVector[] SortClockwise(PVector[] pts, PVector center) {
    // sort in clockwise order
    // left -> right
    for (int i = 1; i < pts.length; i++) {
      PVector p = pts[i];
      int pos = i;

      while (pos > 0 && IsCcw(p, pts[pos - 1], center)) {
        // larger value shifts up
        pts[pos] = pts[pos - 1];
        // insert position moves down
        pos = pos - 1;
      }

      // correct position determined
      pts[pos] = p;
    }
    return pts;
  }

  // returns true if A is CCW in relation to B
  // reference: http://stackoverflow.com/questions/6989100/sort-points-in-clockwise-order
  // NOTE: not currently in use

  private boolean IsCcw(PVector a, PVector b, PVector center) {
    PVector diffA = PVector.sub(center, a);
    PVector diffB = PVector.sub(center, b);

    if (diffA.x >= 0 && diffB.x < 0) {
      return true;
    }
    if (diffA.x == 0 && diffB.x == 0) {
      return diffA.y > diffB.y;
    }

    // (0, 0, 1) is the perpendicular vector
    // it is the vector perpendicular to the xy plane
    float dot = PVector.dot(diffA.cross(diffB), new PVector(0, 0, 1));
    if (dot < 0) {
      return true;
    } else if (dot > 0) {
      return false;
    }

    // a & b are on the same line from the center point
    // use distance; further is CCW
    return diffA.mag() > diffB.mag();
  }  

  // find a triangle that contains all the points
  // this used as a starting reference for the algorithm
  public Triangle GetSuperTriangle() {
    // find min & max x and y values
    float xMin = points[0].x;
    float yMin = points[0].y;
    float xMax = xMin;
    float yMax = yMin;

    for (int i = 0; i < points.length; i++) {
      PVector p = points[i];
      if (p.x < xMin) {
        xMin = p.x;
      }
      if (p.x > xMax) {
        xMax = p.x;
      }
      if (p.y < xMin) {
        xMin = p.y;
      }
      if (p.y > xMax) {
        xMax = p.y;
      }
    }

    // build triangle that contains the min and max values
    float dx = xMax - xMin;
    float dy = yMax - yMin;
    float dMax = dx > dy ? dx : dy;
    float xMid = (xMin + xMax) / 2f;
    float yMid = (yMin + yMax) / 2f;

    Triangle superTri = new Triangle(
      new PVector(xMid - 2f * dMax, yMid - dMax), 
      new PVector(xMid, yMid + 2f * dMax), 
      new PVector(xMid + 2f * dMax, yMid - dMax)
      );

    return superTri;
  }

  // Calculates / creates delaunay triangles for the
  // current set of points
  public ArrayList<Triangle> Calculate()
  {
    // the buffer of current triangles
    ArrayList<Triangle> triangleBuffer = new ArrayList<Triangle>();

    // final collection of completed triangles
    ArrayList<Triangle> completed = new ArrayList<Triangle>();

    // add the super triangle
    Triangle superTriangle = GetSuperTriangle();
    triangleBuffer.add(superTriangle);

    // add each point
    PVector point;
    ArrayList<Edge> edgeBuffer = new ArrayList<Edge>();
    for (int i = 0; i < points.length; i++) {
      point = points[i];
      edgeBuffer.clear();

      // iterate over all current triangles (in reverse)
      // checking to see if the current point is included
      // in a triangles circumcircle
      for (int j = triangleBuffer.size() - 1; j >= 0; j--) {
        Triangle tri = triangleBuffer.get(j);

        PVector circumcenter = tri.GetCircumcenter();
        float rad = circumcenter.dist(tri.points[0]);

        if (circumcenter.x + rad < point.x) {
          // triangle is complete
          // TODO can we end evaluation for current point here?
          completed.add(tri);
        }

        if (circumcenter.dist(point) < rad) {
          // inside
          // add edges to buffer and remove the triangle
          edgeBuffer.add(new Edge(tri.points[0], tri.points[1]));
          edgeBuffer.add(new Edge(tri.points[1], tri.points[2]));
          edgeBuffer.add(new Edge(tri.points[2], tri.points[0]));
          triangleBuffer.remove(j);
        }
      }

      // edge buffer time
      // check for duplicate edges
      // if found, remove them
      for (int j = 0; j < edgeBuffer.size() - 1; j++) {
        Edge edgeA = edgeBuffer.get(j);
        if (edgeA != null) {
          for (int k = j + 1; k < edgeBuffer.size(); k++) {
            Edge edgeB = edgeBuffer.get(k);
            if (edgeA.IsEqual(edgeB)) {
              edgeBuffer.set(j, null);
              edgeBuffer.set(k, null);
            }
          }
        }
      }

      // build new triangles from
      // the remaining edges
      for (int j = 0; j < edgeBuffer.size(); j++) {
        Edge edge = edgeBuffer.get(j);
        if (edge == null) {
          continue;
        }

        // make sure to order points in a clockwise fashion
        Triangle tri = new Triangle(edge.p1, edge.p2, point);
        triangleBuffer.add(tri);
      }
    }

    // remove triangles with
    // the super triangle vertices
    for (int i = triangleBuffer.size() - 1; i >= 0; i--) {
      if (triangleBuffer.get(i).SharesVertex(superTriangle)) {
        triangleBuffer.remove(i);
      }
    }

    // set local triangles collection
    triangles = triangleBuffer;

    return triangleBuffer;
  }

  public DelaunayTriangulator() {
    triangles = new ArrayList<Triangle>();
  }
}

class Edge {
  public PVector p1;  
  public PVector p2;  

  public boolean IsEqual(Edge other) {
    if (other == null) {
      return false;
    } else {
      return (p1 == other.p1 && p2 == other.p2) || (p2 == other.p1 && p1 == other.p2);
    }
  }

  public Edge(PVector a, PVector b) {
    p1 = a;
    p2 = b;
  }
}

void drawDelaunayTriCube(int index) {

  for (int j = index*2; j < (index+1)*2; j++) {
    PGraphics s = screens[j].s;
    s.beginDraw();
    if (dt != null)
      if (j % 2 == 0) {
        s.pushMatrix();
        s.scale(-1, 1);
        s.translate(-screenW, 0);
        for (Triangle t : dt.triangles) t.display(s);
        s.popMatrix();
      } else {
        for (Triangle t : dt.triangles) t.display(s);
      }
    s.endDraw();
  }
}

void drawDelaunayTriAll() {
  int j = 0;
  for (Screen s : screens) {
    s.s.beginDraw();
    if (dt != null)
      if (j == 1 || j == 3) {
        s.s.pushMatrix();
        s.s.scale(-1, 1);
        s.s.translate(-screenW, 0);
        for (Triangle t : dt.triangles) t.display(s.s);
        s.s.popMatrix();
      } else {
        for (Triangle t : dt.triangles) t.display(s.s);
      }
    j++;
    s.s.endDraw();
  }
}

class Triangle {
  PVector[] points;
  // used for fill using lerpColor
  float r = random(0.8);
  color col = color(255);
  // used for drawing lines on triangles
  // number of lines to draw proportionnally to the triangle size
  float n;    // direction point for the lines
  int drawTo = (int)(Math.random()*3);

  // returns the circumcenter for the specified triangle
  // the circumcenter is the intersection of two perpendicular bisectors
  // for any given triangle
  public PVector GetCircumcenter(PVector a, PVector b, PVector c) {
    // determine midpoints (average of x & y coordinates)
    PVector midAB = Midpoint(a, b);
    PVector midBC = Midpoint(b, c);

    // determine slope
    // we need the negative reciprocal of the slope to get the slope of the perpendicular bisector
    float slopeAB = -1 / Slope(a, b);
    float slopeBC = -1 / Slope(b, c);

    // y = mx + b
    // solve for b
    float bAB = midAB.y - slopeAB * midAB.x;
    float bBC = midBC.y - slopeBC * midBC.x;

    // solve for x & y
    // x = (b1 - b2) / (m2 - m1)
    float x = (bAB - bBC) / (slopeBC - slopeAB);
    PVector circumcenter = new PVector(
      x, 
      (slopeAB * x) + bAB
      );

    return circumcenter;
  }

  // Returns the circumcenter of this triangle
  public PVector GetCircumcenter() {
    return GetCircumcenter(points[0], points[1], points[2]);
  }

  // Returns true if p is in the circumcircle of this triangle
  public boolean CircumcircleContains(PVector p) {
    PVector center = GetCircumcenter();
    float rad = center.dist(points[0]);
    return center.dist(p) <= rad;
  }

  // Returns the points in points contained in the circumcircle
  public ArrayList<PVector> GetContainedPoints(PVector[] points) {
    ArrayList<PVector> contained = new ArrayList<PVector>();
    for (int i = 0; i < points.length; i++) {
      if (CircumcircleContains(points[i])) {
        contained.add(points[i]);
      }
    }

    return contained;
  }

  // returns the midpoint between two points
  public PVector Midpoint(PVector a, PVector b) {
    // midpoint is the average of x & y coordinates
    return new PVector(
      (a.x + b.x) / 2, 
      (a.y + b.y) / 2
      );
  }

  // returns the slope of the line between two points
  public float Slope(PVector from, PVector to) {
    return (to.y - from.y) / (to.x - from.x);
  }

  // returns true if point is in the circle located at center with the specified radius
  public boolean IsInCircle(PVector point, PVector center, float radius) {
    // could also use the pythagorean theorem for this
    return point.dist(center) < radius;
  }

  // returns true if we share a vertex with another triangle
  public boolean SharesVertex(Triangle other) {
    for (int i = 0; i < points.length; i++) {
      for (int j = 0; j < other.points.length; j++) {
        if (points[i] == other.points[j]) {
          return true;
        }
      }
    }

    return false;
  }


  public Triangle() {
    points = new PVector[3];
  }

  public Triangle(PVector[] pts) {
    points = pts;
  }

  // constructor using vectors
  public Triangle(PVector a, PVector b, PVector c) {
    color cyan = color(0, 255, 255);
    color blue = color(0, 0, 255);
    color lime = color(70, 255, 0);
    color pink = color(255, 0, 155);
    points = new PVector[3];
    points[0] = a;
    points[1] = b;
    points[2] = c;
    n = getD(points[0], points[1], points[2]);
    color[] colors = {cyan, pink, blue, lime};
    col = colors[int(random(4))];
  }

  public void display(PGraphics s) {


    s.noStroke();
    //s.fill( lerpColor( color(255), color(0), this.r ) );
    s.fill(col);

    s.triangle( points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y );

    switch( this.drawTo ) {
    case 0:
      drawLines(s, points[0], points[1], points[2] );
      break;
    case 1:
      drawLines(s, points[2], points[0], points[1] );
      break;
    case 2:
      drawLines(s, points[1], points[0], points[2] );
      break;
    }

    s.stroke( color(0) );
    s.strokeJoin( BEVEL );
    s.strokeWeight( 15 );
    s.noFill();
    s.triangle( points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y );
  };
  float getD(PVector p1, PVector p2, PVector p3) {
    return (dist( p1.x, p1.y, ( p2.x + p2.x )*1.0 / 2, ( p3.y + p3.y )*1.0 / 2 ) / random( 25, 50 ) ) + 1 ;
  }
  void drawLines(PGraphics s, PVector from, PVector to1, PVector to2 ) {
    float c =  -.05 + .7*cos( frameCount *1.0 / 360 * TWO_PI ) / 2;

    for ( int i = 1; i <= this.n; i++ ) {
      PVector p1 = new PVector( 
        lerp( from.x, to1.x, ( i - 1 )*1.0 / this.n ), 
        lerp( from.y, to1.y, ( i - 1 )*1.0 / this.n )
        );
      PVector  p2 = new PVector(
        lerp( from.x, to2.x, ( i - 1 )*1.0 / this.n ), 
        lerp( from.y, to2.y, ( i - 1 )*1.0 / this.n )
        );
      PVector  p3 = new PVector(
        lerp( from.x, to2.x, ( i - 0.5 + c )*1.0 / this.n ), 
        lerp( from.y, to2.y, ( i - 0.5 + c )*1.0 / this.n )
        );
      PVector  p4 = new PVector( 
        lerp( from.x, to1.x, ( i - 0.5 + c )*1.0 / this.n ), 
        lerp( from.y, to1.y, ( i - 0.5 + c )*1.0 / this.n )
        );

      //line( p1.x, p1.y, p2.x, p2.y );

      s.noStroke();
      s.fill( color(0) );
      s.quad( p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y );
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////
// Some LINE STUFF
//////////////////////////////////////////////////////////////////////////////////

void ellipseRun(PGraphics s, float w, float sp, float per, color c1, color c2) {
  s.noStroke();
  for (int i = s.width*2; i > 0; i-= (sp+w)) {
    s.noFill();
    s.strokeWeight(w/2);


    float newW = map(per, 0, 1, 0, s.width*2);
    newW += i;
    newW %= s.width*2;
    s.stroke(lerpColor(c1, c2, newW/ s.width));
    s.ellipse(s.width/2, s.height/2, newW, newW);
  }
}
void splitRect(PGraphics s, color c1, color c2) {
  int mode = (currentCycle-1)/4%4;
  s.fill(c2);
  s.noStroke();
  if (mode > 0) {
    for (int x = 0; x <= pow(2, mode); x++) {
      s.pushMatrix();
      //s.translate(10*sin(percentToNumBeats(8)*2*PI), 0);
      for (int y = 0; y <= pow(2, mode); y++) {
        if (y%2 ==0) s.rect(x*s.width/pow(2, mode)*2, y*s.height/pow(2, mode), s.width/pow(2, mode), s.height/pow(2, mode));
        else s.rect(x*s.width/pow(2, mode)*2 + s.width/pow(2, mode), y*s.height/pow(2, mode), s.width/pow(2, mode), s.height/pow(2, mode));
      }
      s.popMatrix();
    }
  }
}

void cycleCubeMovingStripes(int lw, int lsp, float per, color c1, color c2, color l1, color l2) {
  if ((currentCycle-1)/4 % 2 == 0) {
    drawVertLinesScreen(screens[0].s, lw, lsp, per, c1, 0);
    colorMode(HSB);
    color c = color(hue(c1), saturation(c1), brightness(c2) - 70);
    drawVertLinesScreen(screens[1].s, lw, lsp, per, c, 0);
    colorMode(RGB);
    screens[2].blackOut();
    screens[3].blackOut();
    displayCubeLines(l1, 0);
  } else {
    drawVertLinesScreen(screens[2].s, lw, lsp, per, c2, 0);
    colorMode(HSB);
    color c = color(hue(c2), saturation(c2), brightness(c2) - 70);
    drawVertLinesScreen(screens[3].s, lw, lsp, per, c, 0);
    colorMode(RGB);
    screens[0].blackOut();
    screens[1].blackOut();
    displayCubeLines(0, l2);
  }
}

void cycleCubeDelaunay(color l1, color l2) {
  if ((currentCycle-1)/4 % 2 == 0) {
    drawDelaunayTriCube(0);
    screens[2].blackOut();
    screens[3].blackOut();
    displayCubeLines(l1, 0);
  } else {
    drawDelaunayTriCube(1);
    screens[0].blackOut();
    screens[1].blackOut();
    displayCubeLines(0, l2);
  }
}

void cycleCubeLight(color c1, color c2, color l1, color l2) {
  if ((currentCycle-1)/4 % 2 == 0) {
    PGraphics s = screens[0].s;
    s.beginDraw();
    s.background(c1);
    s.noStroke();
    s.fill(c2);
    s.rect(0, 0, s.width, s.height/2);
    s.fill(c1);
    s.ellipse(s.width/2, s.height/2, s.width/2, s.width/2);
    s.fill(c2);
    s.arc(s.width/2, s.height/2, s.width/2, s.width/2, 0, PI);
    s.endDraw();
    colorMode(HSB);
    color c = color(hue(c1), saturation(c1), brightness(c2) - 70);
    screens[1].drawSolid(c);
    colorMode(RGB);
    screens[2].blackOut();
    screens[3].blackOut();
    displayCubeLines(l1, 0);
  } else {
    screens[2].drawSolid(c2);
    colorMode(HSB);
    color c = color(hue(c2), saturation(c2), brightness(c2) - 70);
    screens[3].drawSolid(c);
    colorMode(RGB);
    screens[0].blackOut();
    screens[1].blackOut();
    displayCubeLines(0, l2);
  }
}

void drawHorizLinesGradientScreen(PGraphics s, int lh, int lsp, float per, color c1, color c2) {
  s.noStroke();
  int extra = (lh + 2*lsp);
  for (int i = 0; i < s.height + extra; i += (lh + lsp)) {

    float y = map(per, 0, 1, -extra, s.height);

    y += i;
    if (y >= s.height) y -= (extra + s.height);
    s.fill(lerpColor(c1, c2, y/s.height));
    s.rect(0, y, s.width, lh);
  }
}

void drawVertLinesGradientScreenAcross(PGraphics s, int lw, int lsp, int screenNum, float per, color c1, color c2, color c3) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {

    float x = map(per, 0, 1, -extra, s.width);

    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.fill(getCycleColor(c1, c2, c3, (x+screenNum * screenW)/(screenW*4)));
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesGradientScreen(PGraphics s, int lw, int lsp, float per, color c1, color c2) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {

    float x = map(per, 0, 1, -extra, s.width);

    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.fill(lerpColor(c1, c2, x/s.width));
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesScreen(PGraphics s, int lw, int lsp, float per, color c, int direction) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {
    s.fill(c);
    //s.fill(255);
    float x = 0;
    if (direction > 0) x = map(per, 0, 1, -extra, s.width);
    else if (direction < 0) x = map(1-per, 0, 1, -extra, s.width);
    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesGradientAll(int lw, int lsp, float per, color c1, color c2) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    drawVertLinesGradientScreen(screens[j].s, lw, lsp, per, c1, c2);
    screens[j].s.endDraw();
  }
}

void drawVertLinesGradientAcrossAll(int lw, int lsp, float per, color c1, color c2, color c3) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    drawVertLinesGradientScreenAcross(screens[j].s, lw, lsp, j, per, c1, c2, c3);
    screens[j].s.endDraw();
  }
}

void drawVertLinesAcrossAll(int lw, int lsp, float per, color c, int mode) {
  color [] colors = {c, c, c, c};
  drawVertLinesAcrossAll(lw, lsp, per, colors, mode);
}

void drawVertLinesAcrossAll(int lw, int lsp, float per, color[] colors, int mode) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    screens[j].s.blendMode(SCREEN);
    int direction = 0;
    if (mode == 0) direction = 1;
    else if (mode == 1) direction = -1;
    else if (mode == 2) {
      if (j == 0 || j == 1) direction = 1;
      else direction = -1;
    } else if (mode == 3) {
      if (j == 0 || j == 1) direction = -1;
      else direction = 1;
    }
    //temp.beginDraw();
    //temp.background(0);
    drawVertLinesScreen(screens[j].s, lw, lsp, per, colors[j], direction);
    //temp.endDraw();
    //screens[j].s.image(currentImages.get(0), -screenW * j, 0);
    //screens[j].s.mask(temp);
    screens[j].s.endDraw();
  }
}

void sphereEdgeInit() {
  tempSphere = createGraphics(sphereScreen.s.width, sphereScreen.s.height);
  tempSphere.beginDraw();
  tempSphere.background(0);
  tempSphere.noStroke();
  int startW = tempSphere.width - 50;
  for (int i = tempSphere.width; i >= startW; i--) {
    float br = map(i, tempSphere.width, startW, 0, 255);
    tempSphere.fill(br);
    tempSphere.ellipse(tempSphere.width/2, tempSphere.height/2, i, i);
  }
  tempSphere.endDraw();
}

// getColorFW
void gradientSphere(color c1, color c2, color c3) {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.blendMode(BLEND);

  //s.strokeWeight(1);
  s.noStroke();
  for (int i = s.width; i > 0; i --) {
    float per = map(i, s.width, 0, 0, 0.5);
    //per += millis()/4000.0;
    //per %= 1;
    s.fill(paradiseStrokeReturn(per, c2, c1, c3));
    s.ellipse(s.width/2, s.height/2, i, i);
  }


  //s.image(tempSphere, 0, 0, s.width, s.height);
  s.mask(tempSphere);
  s.blendMode(BLEND);
  s.endDraw();
}

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



//////////////////////////////////////////////////////////////////////////////////
// TESSERACT
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/205544
Tesseract tesseract;

void initTesseract() {
  tesseract = new Tesseract();
}

void displayTesseract2Screens() {
  updateSpectrum();
  beatCycle(300);
  updateTesseractBeat();
  displayTesseract(screens[1].s);
  displayTesseract(screens[2].s);
}

void updateTesseractBeat() {
  if (currentCycle%6 == 0) tesseract.turn(0, 1, .01);
  else if (currentCycle%6 == 1) tesseract.turn(0, 2, .01);
  else if (currentCycle%6 == 2) tesseract.turn(1, 2, .01);
  else if (currentCycle%6 == 3) tesseract.turn(0, 3, .01);
  else if (currentCycle%6 == 4) tesseract.turn(1, 3, .01);
  else if (currentCycle%6 == 5) tesseract.turn(2, 3, .01);
}

void displayTesseract(PGraphics s) {
  s.beginDraw();
  s.background(0);
  s.stroke(255);
  s.strokeWeight(2);
  s.pushMatrix();
  s.translate(s.width/2, s.height/2);
  tesseract.display(s);
  s.popMatrix();
  s.endDraw();
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
  int w = screenW*2; 
  int h = int(screenH*1.5); 
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

void rampUpAudioAmp() {
   addAudioAmp = true;
  audioAmpLev += 0.01;
  if (audioAmpLev > 1) audioAmpLev = 1;
}

void cycleAudioAmp(float start, float end, int numCycles) {
  float period = (end - start)/numCycles;
  audioLev = audioAmpLev*sin(period * millis()/1000.0);
}

void setAudioGrid(float flyingTerrInc) {
  updateSpectrum();

  beatCycle(300);
  if (currentCycle > previousCycle) {
    acceleratingTerr = true;
    previousCycle = currentCycle;
  }
  
  
  if (flyingTerrOn) flyingTerr -= flyingTerrInc;

  float yoff = flyingTerr;

  for (int y = 0; y < rowsTerr; y++) {
    float xoff = 0;
    float amp = 0.1;
    for (int x = 0; x < colsTerr; x++) {
      float f = getFreq(map(x, 0, colsTerr, 0, 100));


      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      //terrain[x][y] += f*amp;
      //terrain[x][y] += map(y,0,rowsTerr,-f*amp,f*amp);
      xoff += xoffInc;
    }
    yoff += xoffInc;
  }
}

void setMouseFlyingInc() {
  if (mouseX< width/3) flyingTerrInc = 0.02;
  else if (mouseX < width *2/3) flyingTerrInc = -0.02;
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
int zZoom = startingTerrain;
boolean isZoomingTerrain = true;

void displayTerrainCenter(float flyingRate) {
  PGraphics s = centerScreen.s;
  //setGrid();
  setAudioGrid(flyingRate);
  s.beginDraw();
  s.background(0);
  s.pushMatrix();
  s.translate(screenW*2, screenH/2, 0);
  if (beginningTerrain) s.rotateX(radians(millis()/100.0));
  else s.rotateX(radians(60));
  if (isZoomingTerrain) {
    float speed = map(zZoom, startingTerrain, endingTerrain, 10, 0);
    zZoom += speed;
    if (zZoom > endingTerrain) isZoomingTerrain = false;
  }
  s.translate(0, zZoom, 0);
  s.noFill();
  s.stroke(255);
  s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
  s.colorMode(HSB, 255);
  for (int y = 0; y < rowsTerr-1; y++) {
    s.beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < colsTerr; x++) {
      //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
      s.vertex(x * spacingTerr, y * spacingTerr, addAudioAmp?terrain[x][y]*audioLev:0);
      s.vertex(x * spacingTerr, (y+1) * spacingTerr, addAudioAmp?terrain[x][y+1]*audioLev:0);
    }
    s.endShape();
  }
  s.popMatrix();
  s.endDraw();
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
    } else if (location.x < -400) resetTreeBranchesAll();
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
void displayTreeBranchesAll() {
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.ellipseMode(CENTER);
    s.fill(255);
    s.noStroke();
    for (int i=0; i<paths.length; i++) {
      PVector loc = paths[i].location;
      float diam = paths[i].diameter;
      s.ellipse(loc.x, loc.y, diam, diam);
      paths[i].update();
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
    s.stroke(255);
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
  cycleWaves();
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

void cycleWaves() {
  updateSpectrum();
  beatCycle(500);
  if (currentCycle > previousCycle) {
    waves.add(new Wave(centerScreen.s.width/2, centerScreen.s.height/2));
    previousCycle = currentCycle;
  }
}


//////////////////////////////////////////////////////////////////////////////////
// LINES BOUNCE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/449873
// modified by jdeboi
float angleBottom = 0;

void displayLineBounceAll(color c1, color c2) {
  for (Screen s : screens) {
    displayLineBounce(s.s, 30, c2, c2);
  }
  angleBottom += 0.01;
}
void displayLineBounceCenter(float rate, int spacing, color c1, color c2) {
  displayLineBounce(centerScreen.s, spacing, c1, c2);
  angleBottom += rate;
}
void displayLineBounce(PGraphics s, int spacing, color c1, color c2) {
  s.beginDraw();
  s.background(0);

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



//////////////////////////////////////////////////////////////////////////////////
// MOVING THROUGH SPACE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/96938
ArrayList<PVector> starsSpace = new ArrayList<PVector>();
int convergeX = 1;
int convergeY = 1;

void displayMoveSpaceAll(float speed) {
  cycleStarsSpaceModes();
  for (Screen s : screens) {
    displayMoveSpace(s.s, speed);
  }
}

void displayMoveSpaceCenter(int mode, float speed) {
  displayMoveSpace(centerScreen.s, mode, speed);
}

void displayMoveSpaceCenterCycle(float speed) {
  cycleStarsSpaceModes();
  displayMoveSpace(centerScreen.s, speed);
}

//void displayMoveSpaceStage(float speed) {
//  cycleStarsSpaceModes();
//  displayMoveSpace(speed);
//}

//void displayMoveSpace(float speed) {
//  //int controlX = mouseX;
//  //int controlY = mouseY;
//  speed = constrain(speed, 0.6, 1.0);
//  int controlX = int(map(convergeX, 0, 2, width*(1-speed), width*speed));
//  int controlY = int(map(convergeY, 0, 2, height*(1-speed), height*speed));
//  float w2=width/2;
//  float h2= height/2;
//  float d2 = dist(0, 0, w2, h2);
//  noStroke();
//  fill(0, map(dist(controlX, controlY, w2, h2), 0, d2, 255, 5));
//  rect(0, 0, width, height);
//  fill(255);

//  for (int i = 0; i<20; i++) {   // star init
//    starsSpace.add(new PVector(random(width), random(height), random(1, 3)));
//  }

//  for (int i = 0; i<starsSpace.size(); i++) {
//    float x =starsSpace.get(i).x;//local vars
//    float y =starsSpace.get(i).y;
//    float d =starsSpace.get(i).z;

//    /* movement+"glitter"*/
//    starsSpace.set(i, new PVector(x-map(controlX, 0, width, -0.05, 0.05)*(w2-x), y-map(controlY, 0, height, -0.05, 0.05)*(h2-y), d+0.2-0.6*noise(x, y, frameCount)));

//    if (d>3||d<-3) starsSpace.set(i, new PVector(x, y, 3));
//    if (x<0||x>width||y<0||y>height) starsSpace.remove(i);
//    if (starsSpace.size()>999) starsSpace.remove(1);
//    ellipse(x, y, d, d);//draw stars
//  }
//}

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

    previousCycle = currentCycle;
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
void displayRedPlanet(PGraphics s) {
  s.beginDraw();
  //create the path
  pathPoints = circlePoints(s);

  for (int j=0; j<8; j++) {
    pathPoints = complexifyPath(pathPoints);
  }

  //draw the path
  s.stroke(random(100, 255), 20, 15, random(10, 55));
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
  float r = s.height/2;
  int x = s.width/2;
  int y = s.height/2;
  //float theta1 = random(TWO_PI);
  float theta1 = (randomGaussian()-0.5)*PI/4;
  float theta2 = theta1 + (randomGaussian()-0.5)*PI/3;
  PVector v1 = new PVector(x + r*cos(theta1), y+ r*sin(theta1)*.7 );
  PVector v2 = new PVector(x + r*cos(theta2), y + r*sin(theta2)*.7);
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
float countFW=150;
float  mapHeightFW;
int modeFW = 0;
color startCFW;
color midCFW;
color endCFW;

void initDisplayFlowyWaves(PGraphics s) {
  mapHeightFW = screenH;
  s.beginDraw();
  s.background(255);

  colorMode(HSB);
  startCFW = color(random(255), 255, 255);
  midCFW = color((hue(startCFW)+60)%255, 255, 255);
  endCFW = color((hue(startCFW)+120)%255, 255, 255);
  colorMode(RGB);
  s.endDraw();
}

void displayFlowyWaves(PGraphics s) {
  s.beginDraw();
  int fadeStart = 1150;
  int fadeEnd = 1200;
  if (countFW > fadeStart) {
    s.noStroke();
    color c = getColorFW(0, modeFW);
    s.fill(hue(c), saturation(c), brightness(c), map(countFW, fadeStart, fadeEnd, 2, 50));
    s.rect(0, 0, s.width, s.height);
  }
  s.noFill();
  changeColor(s, countFW);
  changePerlin();
  paintFW(s);
  countFW++;

  if (countFW > fadeEnd) {
    //s.background(255);
    countFW = 100;
    mapHeightFW = screenH;
  }
  mapHeightFW=mapHeightFW-1;
  s.endDraw();
}

void changeColor(PGraphics s, float cnt) {
  s.colorMode(HSB);
  s.stroke(getColorFW(cnt, modeFW));
}

color getColorFW(float cnt, int mode) {
  if (mode == 0) {
    cFW = sin(radians(cnt))+1;
    dFW = sin(radians(cnt+30))+1;
    eFW = sin(radians(cnt+60))+1;
    cFW = map(cFW, 0, 1, 0, 255);
    dFW = map(dFW, 0, 1, 0, 255);
    eFW = map(eFW, 0, 1, 0, 255);
    return color(cFW, dFW, 220);
  } else if (mode == 1) {
    cFW = sin(radians(cnt))+1;
    return color(cFW);
  } else {
    cFW = sin(radians(cnt))+1;
    dFW = sin(radians(cnt+30))+1;
    eFW = sin(radians(cnt+60))+1;
    cFW = map(cFW, 0, 1, 0, 255);
    dFW = map(dFW, 0, 1, 0, 255);
    eFW = map(eFW, 0, 1, 0, 255);

    float s = sin(radians(cnt));
    color c;
    if (s < -0.5) c = lerpColor(startCFW, midCFW, map(s, -1, -0.5, 0, 1));
    else if (s < 0.5) c = lerpColor(midCFW, endCFW, map(s, -0.5, 0.5, 0, 1));
    else  c = lerpColor(endCFW, startCFW, map(s, 0.5, 1, 0, 1));
    return c;
  }
}

void paintFW(PGraphics s) {
  for (int x=0; x<s.width; x=x+1) {
    myPerlin = noise(float(x)/200, countFW/200);
    float myY = map(myPerlin, 0, 1, 0, s.height-mapHeightFW);
    s.line(x, myY, x, s.height );
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
void fadeOutAllScreens(int seconds) {
  if (!startFade) {
    startFadeTime = millis();
    startFade = true;
  }
  float timePassed = (millis() - startFadeTime)/1000.0;
  int brig = constrain(int(map(timePassed, 0, seconds, 0, 255)), 0, 255);
  for (Screen s : screens) {
    s.drawFadeAlpha(brig);
  }
  for (Screen s : topScreens) {
    s.drawFadeAlpha(brig);
  }
  sphereScreen.drawFadeAlpha(brig);
  centerScreen.drawFadeAlpha(brig);
}

void fadeInAllScreens(int seconds) {
  if (!startFade) {
    startFadeTime = millis();
    startFade = true;
  } 
  float timePassed = (millis() - startFadeTime)/1000.0;
  int brig = constrain(int(map(timePassed, 0, seconds, 255, 0)), 0, 255);
  for (Screen s : screens) {
    s.drawFadeAlpha(brig);
  }
  for (Screen s : topScreens) {
    s.drawFadeAlpha(brig);
  }
  sphereScreen.drawFadeAlpha(brig);
  centerScreen.drawFadeAlpha(brig);
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
      //spaceRects[j].display(s);
      spaceRects[j].displayNeon(s, sw, c1);
      if (i== 1)spaceRects[j].update(mode);
    }
    s.popMatrix();
    s.rectMode(CORNER);
    s.endDraw();
  }
}



void displayTunnel(PGraphics s, int len, color c1, color c2) {
  int gap = 5;
  s.beginDraw();
  s.background(0);

  // top
  s.pushMatrix();
  s.rotateX(radians(-90 + gap));
  //s.translate(0, s.height, 0);
  s.beginShape();
  s.fill(c1);
  s.vertex(-1, -1);
  s.vertex(s.width+1, -1);
  s.fill(c2);
  s.vertex(s.width+1, len);
  s.vertex(-1, len);
  s.endShape();
  s.popMatrix();

  // bottom
  s.pushMatrix();
  s.rotateX(radians(-90));
  s.translate(0, 0, s.height);
  s.rotateX(radians(-gap));
  s.beginShape();
  s.fill(c1);
  s.vertex(-1, -1);
  s.vertex(s.width+1, -1);
  s.fill(c2);
  s.vertex(s.width+1, len);
  s.vertex(-1, len);
  s.endShape();
  s.popMatrix();

  // left
  s.pushMatrix();
  s.rotateY(radians(90 - gap));
  //s.translate (0,0, s.height);
  s.beginShape(QUADS);
  s.fill(c1);
  s.vertex(-1, -1);
  s.fill(c2);
  s.vertex(len, -1);
  s.vertex(len, s.height+1);
  s.fill(c1); 
  s.vertex(-1, s.height+1);
  s.endShape();
  s.popMatrix();

  // right
  s.pushMatrix();
  s.rotateY(radians(90));
  s.translate (0, 0, s.width);
  s.rotateY(radians(gap));
  s.beginShape(QUADS);
  s.fill(c1);
  s.vertex(-1, -1);
  s.fill(c2);
  s.vertex(len, -1);
  s.vertex(len, s.height+1);
  s.fill(c1); 
  s.vertex(-1, s.height+1);
  s.endShape();
  s.popMatrix();
  s.endDraw();
}

void displayCenterSpaceRects(int sw, int mode, color c1, color c2, color c3) {
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
    if (mode == SUPER_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, frameCount/10.0);
    else if (mode == KINDA_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, frameCount/100.0);
    else if (mode == SORTA_TRIPPY) rot.z = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, frameCount/1000.0);
    else if (mode == SEESAW)  vel.z = zVel * 4 * sin(millis()/500.0);
  }

  void zGradientStroke(PGraphics s, color c1, color c2, color c3) {
    float zper = map(pos.z, endPSpaceRects, frontPSpaceRects, 0, 2); 
    color grad;
    if (zper < 1) grad = lerpColor(c1, c2, zper);
    else grad = lerpColor(c2, c3, zper-1);
    s.stroke(grad);
  }

  void display(PGraphics s) {
    s.pushMatrix();
    s.rotateX(rot.x);
    s.rotateY(rot.y);
    s.rotateZ(rot.z);
    s.translate(pos.x, pos.y, pos.z);
    float dw = map(pos.z, frontPSpaceRects, endPSpaceRects, 0, 14*numRects);
    s.rect(0, 0, s.width-dw, s.height-dw);
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


  void displayCenter(PGraphics s, int side) {
    //float sz = map(-pos.z*pos.z, frontPSpaceRects, endPSpaceRects, s.width*4, 0); // spazz
    //float sz = map(pos.z*2, frontPSpaceRects, endPSpaceRects, s.width*4, 0);   // cool
    float sz = map(pos.z, frontPSpaceRects, endPSpaceRects, s.width*4, 0);
    if (side == 1) s.rect(s.width, s.height/2, sz, sz);
    else s.rect(0, s.height/2, sz, sz);
  }
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
  neonline(s, x-w/2, y+h/2, x-w/2, y-h/2, sw, c);

  s.popMatrix();
}
void neonline(PGraphics s, PVector p0, PVector p1, int sw, color c) {
  neonline(s, int(p0.x), int(p0.y), int(p1.x), int(p1.y), sw, c);
}
void neonline(PGraphics s, int x0, int y0, int x1, int y1, int sw, color c) {
  s.pushMatrix();
  s.noStroke();
  for (int i = 5; i >= 0; i--) {
    int w = sw+i*3;
    s.fill(c, 50 + i * 41);
    s.beginShape();
    s.vertex(x0, y0);
    s.vertex(x1, y1);
    s.vertex(x1, y1+w);
    s.vertex(x0, y0+w);

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

void displayLACircle(PGraphics s, float radius, float step){
  s.beginDraw();
  s.pushMatrix();
  s.translate(s.width / 2, s.height / 2);
  for(float y = -radius + step / 2; y <= radius - step / 2; y += step){
    float X = sqrt(sq(radius) - sq(y)); 
    float cRate = map(y, -radius + step / 2, radius + step / 2, 0, 1);
    //s.stroke(lerpColor(color(69, 189, 207), color(234, 84, 93), cRate));
    s.stroke(255 - cRate * y);
    s.beginShape();
    for(float x = -X; x <= X; x += 1){
      s.vertex(x, y);
    }
    s.endShape();
  }
  s.popMatrix();
  s.endDraw();
}

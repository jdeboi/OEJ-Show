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

void displayTesseract() {
  updateSpectrum();
  beatCycle(300);
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.stroke(255);
    s.s.strokeWeight(2);
    s.s.pushMatrix();
    s.s.translate(screenW/2, screenH/2);

    tesseract.display(s);
    s.s.popMatrix();

    if (currentCycle%6 == 0) tesseract.turn(0, 1, .01);
    else if (currentCycle%6 == 1) tesseract.turn(0, 2, .01);
    else if (currentCycle%6 == 2) tesseract.turn(1, 2, .01);
    else if (currentCycle%6 == 3) tesseract.turn(0, 3, .01);
    else if (currentCycle%6 == 4) tesseract.turn(1, 3, .01);
    else if (currentCycle%6 == 5) tesseract.turn(2, 3, .01);
    s.s.endDraw();
  }
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

  void display(Screen s) {
    float[][][] temp = new float[32][2][4];
    for (int i=0; i<32; i++)
      for (int j=0; j<2; j++)
        for (int k=0; k<4; k++)
          temp[i][j][k]=lines[i][j][k];
    persp(temp);
    resize(temp);
    for (int i=0; i<32; i++)
      s.s.line(temp[i][0][0], temp[i][0][1], temp[i][1][0], temp[i][1][1]);
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
boolean addAudioAmp = true;

void initTerrainCenter() {
  int w = screenW*4; 
  int h = 800; 
  int spacing = 20;
  this.colsTerr = w/spacing;
  this.rowsTerr = h/spacing;
  this.spacingTerr = spacing;
  terrain = new float[colsTerr][rowsTerr];
}
void setAudioGrid() {
  updateSpectrum();

  beatCycle(300);
  if (currentCycle > previousCycle) {
    acceleratingTerr = true;
    previousCycle = currentCycle;
  }
  updateFlying(800);

  float yoff = flyingTerr;

  for (int y = 0; y < rowsTerr; y++) {
    float xoff = 0;
    float amp = 0.5;
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

void displayTerrainSplit() {
  setAudioGrid();
  int j = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.pushMatrix();
    
    // 0  +screenW*2
    // 1  +screenW
    // 2 -screenW
    // 3 -2*screenW

    s.translate((2-j) * screenW, screenH/2, 0);
    s.rotateX(radians(60));


    s.noFill();
    s.stroke(255);
    s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
    s.colorMode(HSB, 255);
    for (int y = 0; y < rowsTerr-1; y++) {
      s.beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < colsTerr; x++) {
        //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
        s.vertex(x * spacingTerr, y * spacingTerr, addAudioAmp?terrain[x][y]:0);
        s.vertex(x * spacingTerr, (y+1) * spacingTerr, addAudioAmp?terrain[x][y+1]:0);
      }
      s.endShape();
    }
    s.popMatrix();
    s.endDraw();
    j++;
  }
}


void displayTerrainCenter() {
  PGraphics s = centerScreen.s;
  //setGrid();
  setAudioGrid();
  s.beginDraw();
  s.background(0);
  s.pushMatrix();
  if (beginningTerrain) {
    s.translate(screenW*2, screenH/2, 0);
    s.rotateX(radians(millis()/100.0));
  } else {
    s.translate(screenW*2, screenH/2, 0);
    s.rotateX(radians(60));
  }

  s.noFill();
  s.stroke(255);
  s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
  s.colorMode(HSB, 255);
  for (int y = 0; y < rowsTerr-1; y++) {
    s.beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < colsTerr; x++) {
      //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
      s.vertex(x * spacingTerr, y * spacingTerr, addAudioAmp?terrain[x][y]:0);
      s.vertex(x * spacingTerr, (y+1) * spacingTerr, addAudioAmp?terrain[x][y+1]:0);
    }
    s.endShape();
  }
  s.popMatrix();
  s.endDraw();
}



//void displayTerrainCenter() {
//  PGraphics s = centerScreen.s;
//  setAudioGrid();
//  s.beginDraw();
//  s.pushMatrix();
//  s.translate(screenW*4/2,screenH/2,-500);
//  s.rotateX(radians(80));
//  s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
//  for(int y = 0; y < rowsTerr-1; y++) {
//    s.beginShape(TRIANGLE_STRIP);
//    for(int x = 0; x < colsTerr; x++) {
//      //fill(getVertexColor(x,y),gridOpacity);
//      s.vertex(x * spacingTerr, y * spacingTerr, terrain[x][y]);
//      s.vertex(x * spacingTerr, (y+1) * spacingTerr, terrain[x][y+1]);
//    }
//    s.endShape();
//  }
//  s.popMatrix();
//  s.endDraw();
//}

// return frequency from 0 to 100 at x (band) between 0 and 100
float getFreq(float col) {
  int x = constrain((int)col, 0, 100);
  x = (int)(x * (bands.length/100.0));
  return constrain(bands[x], 0, 100);
}

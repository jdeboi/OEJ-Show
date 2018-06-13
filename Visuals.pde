
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


void triangleCenter(color c, int sw, int sz) {
  strokeWeight(sw);
  stroke(c);
  noFill();
  int x = (maskPoints[2].x+maskPoints[7].x)/2; 
  int y = (maskPoints[2].y+maskPoints[7].y)/2;
  float alt = sz*sqrt(3)/2.0;
  triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2);
}

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

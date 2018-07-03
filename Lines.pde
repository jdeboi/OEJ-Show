ArrayList<Line> lines;
boolean editingLines = false;
PVector selectedLineP = null;
int origLineW = 10;
int lineW = origLineW;
boolean startFadeLine = false;

void initLines() {
  strokeCap(ROUND);
  //snapOutlinesToMask();
  loadLines();
}

/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
// MODES
/////////////////////////////////////////////////////////////////////////////////////////////////

void displayLines(color c) {
  for (int i = 0; i < lines.size(); i++) {
    stroke(c);
    fill(c);
    lines.get(i).display(c);
  }
}

void displayLines() {
  pushMatrix();
  translate(0, 0, 2);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display();
  }
  popMatrix();
}

void displayLinesCube(int index, color c) {
  for (int i = index * 4; i < (index+1)*4; index++) {
    stroke(c);
    lines.get(i).display();
  }
}

void displayCubeLines(color c1, color c2) {
  stroke(c1);
  for (int i =  0; i < 8; i++) {
    lines.get(i).display();
  }
  stroke(c2);
  for (int i =  8; i < 16; i++) {
    lines.get(i).display();
  }
}

void displayCubesAlternateColorCycle(color c1, color c2) {
  if ((currentCycle)%2 == 0) displayCubeLines(c1, c2);
  else displayCubeLines(c2, c1);
}

void displayCycle4FaceLines(color c) {
  fill(c);
  stroke(c);
  display4FaceLines((currentCycle) %4);
}

void displayCycleSingleFaceLines(color c, int direction) {

  //for (int i = 0; i < 4; i++) {
  //  displayCycleSingleFace(i, c, direction);
  //}
  displayCycleSingleFace(0, c, direction);
  displayCycleSingleFace(3, c, direction);
}

void displayCycleSingleFace(int face, color c, int direction) {
  fill(c);
  stroke(c);
  int currentL = (currentCycle) %4;
  if (direction < 0) currentL = 3 - currentL;
  lines.get(face*4+currentL).display();
}

void display4FaceLines(int face) {
  for (int i =  face * 4; i < face * 4 + 4; i++) {
    lines.get(i).display();
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////////

void fadeOutAllLines(int seconds, color c) {
  if (!startFadeLine) {
    startFadeTime = millis();
    startFadeLine = true;
  } 
  float timePassed = (millis() - startFadeTime)/1000.0;
  int brig = constrain(int(map(timePassed, 0, seconds, 255, 0)), 0, 255);
  float h = hue(c);
  colorMode(HSB, 255);
  color cr = color(h, 255, brig);
  colorMode(RGB, 255);
  displayLines(cr);
}

void fftLines() {
  for (Line l : lines) {
    l.fftLine();
  }
}
void displayRandomLines(color c) {
  if ((millis()/100)%2 == 0) {
    for (Line l : lines) {
      if (int(random(2)) == 0)  l.lineC = c;
      else l.lineC = color(0, 0);
    }
  }
  for (Line l : lines) {
    l.display(l.lineC);
  }
}
void transitLineGradient(color c1, color c2, float per) {
  for (int i = 0; i < lines.size(); i++) {
    stroke(lerpColor(c1, c2, per));
    lines.get(i).displaySegment(per, 0.2);
  }
}
void transit(color c1, float per) {
  transit(c1, c1, c1, c1, per);
}
void transitFaceGradient(color c1, color c2, float per) {
  transit(c1, lerpColor(c1, c2, .33), lerpColor(c1, c2, .66), c2, per);
}
void transit(color c1, color c2, color c3, color c4, float per) {
  for (int i = 0; i < lines.size(); i++) {
    if (i < 4) {
      stroke(c1);
      fill(c1);
    } else if (i < 8) {
      stroke(c2);
      fill(c2);
    } else if (i < 12) {
      stroke(c3);
      fill(c3);
    } else {
      stroke(c4);
      fill(c4);
    }
    lines.get(i).displaySegment(per, 0.2);
  }
}

void wipeRight(float per) {
}

void displayXPoints(int x, color c) {
  fill(c);
  stroke(c);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointX(x);
  }
}

void displayYPoints(float rate) {
  for (int i = 1; i < lines.size(); i+= 2) {
    lines.get(i).displayPointY(rate, false);
  }
}

void displayGradientVertLines(color c1, color c2, float per) {
  int[] vertOrder = {3, 1, 7, 5, 11, 9, 15, 13}; 
  for (int i = 0; i < vertOrder.length; i++) {
    if (i%2 == 0) lines.get(vertOrder[i]).displayGradientLine(c1, c2, per, i/2, true);
    else lines.get(vertOrder[i]).displayGradientLine(c1, c2, per, i/2, false);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
void pulsing(color c, float per) {
  float b = 0;
  if (per < 0.5) b = map(per, 0, .5, 255, 0);
  else b = map(per, 0.5, 1, 0, 255);

  float hue = hue(c);

  colorMode(HSB, 255);
  for (int i = 0; i < lines.size(); i++) {
    stroke(hue, 255, b);
    fill(hue, 255, b);
    lines.get(i).display();
  }
  colorMode(RGB, 255);
}
void pulsingGrad(color c1, color c2, float per) {
  float b = 0;
  if (per < 0.5) b = map(per, 0, .5, 0, 1);
  else b = map(per, 0.5, 1, 1, 0);

  color c = lerpColor(c1, c2, b);
  for (int i = 0; i < lines.size(); i++) {
    stroke(c);
    fill(c);
    lines.get(i).display();
  }
}
void pulseVertLinesCenterBeat(float startT) {
  float per = percentToNextMeasure(startT, 4)*2;
  if (per > 1) per = map(per, 1, 2, 1, 0); 
  for (int i = 1; i < lines.size(); i+=2) {
    lines.get(i).displayCenterPulse(per);
  }
}
void pulseHorizLinesCenterBeat(float per) {
  per *= 2;
  if (per > 1) per = map(per, 1, 2, 1, 0); 
  for (int i = 0; i < lines.size(); i+=2) {
    lines.get(i).displayCenterPulse(per);
  }
}

void pulseVertHorizCenterBeatCycle(float per) {
  per *= 2;
  if (per > 1) per = map(per, 1, 2, 1, 0); 
  int j = ((currentCycle-1)/4)%2;
  for (int i = j; i < lines.size(); i+=2) {
    lines.get(i).displayCenterPulse(per);
  }
}

void pulseCornersBeat(float per) {
  per *= 2;
  if (per > 1) per = map(per, 1, 2, 1, 0); 
  for (int i = 0; i < lines.size(); i+=2) {
    lines.get(i).displayCenterPulse(per);
  }
}

void pulseLinesCenterBeat(float per) {
  per *= 2;
  if (per > 1) per = map(per, 1, 2, 1, 0); 
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayCenterPulse(per);
  }
}

void pulseVertLongCenterBeat(color c1, float per) {
  stroke(c1);
  fill(c1);
  if (per < 0.5) {
    float p = map(per, 0, 0.5, 0, 2);
    // lines going out
    lines.get(4).displayFlipSegment(0, constrain(p, 0, 1));
    lines.get(8).displaySegment(0, constrain(p, 0, 1)); 
    lines.get(0).displayFlipSegment(0, constrain(p-1, 0, 1));
    lines.get(12).displaySegment(0, constrain(p-1, 0, 1));

    lines.get(6).displaySegment(0, constrain(p, 0, 1));
    lines.get(10).displayFlipSegment(0, constrain(p, 0, 1)); 
    lines.get(2).displaySegment(0, constrain(p-1, 0, 1));
    lines.get(14).displayFlipSegment(0, constrain(p-1, 0, 1));
  } else {
    // lines coming in
    float p = map(per, 0.5, 1, 2, 0);
    lines.get(4).displayFlipSegment(0, constrain(p, 0, 1));
    lines.get(8).displaySegment(0, constrain(p, 0, 1)); 
    lines.get(0).displayFlipSegment(0, constrain(p-1, 0, 1));
    lines.get(12).displaySegment(0, constrain(p-1, 0, 1));

    lines.get(6).displaySegment(0, constrain(p, 0, 1));
    lines.get(10).displayFlipSegment(0, constrain(p, 0, 1)); 
    lines.get(2).displaySegment(0, constrain(p-1, 0, 1));
    lines.get(14).displayFlipSegment(0, constrain(p-1, 0, 1));
  }
}

void sineWaveVert(color c1, color c2, float per, float phaseStep) {
  float phase = 0;
  float period = per * 2 * PI;
  float h = 0.5 + 0.5* sin(period + phase);
  stroke(lerpColor(c1, c2, h));
  lines.get(3).displaySegment(0, h);

  phase += phaseStep;
  h = 0.5 + 0.5* sin(period + phase);
  stroke(lerpColor(c1, c2, h));
  lines.get(1).displayFlipSegment(0, h);
  lines.get(7).displaySegment(0, h);

  phase += phaseStep;
  h = 0.5 + 0.5* sin(period + phase);
  stroke(lerpColor(c1, c2, h));
  lines.get(5).displayFlipSegment(0, h);
  lines.get(11).displaySegment(0, h);

  phase += phaseStep;
  h = 0.5 + 0.5* sin(period + phase);
  stroke(lerpColor(c1, c2, h));
  lines.get(9).displayFlipSegment(0, h);
  lines.get(15).displaySegment(0, h);

  phase += phaseStep;
  h = 0.5 + 0.5* sin(period + phase);
  stroke(lerpColor(c1, c2, h));
  lines.get(13).displayFlipSegment(0, h);
}

/////////////////////////////////////////////////////////////////////////////////////////////////

void  sineGradientFaceCycle(color c1, color c2, float per, float phaseStep) {
  float phase = 0;
  float period = per * 2 * PI;
  float newPer = 0.5 + 0.5* sin(period + phase);
  for (int i = 0; i < 4; i++) {
    color grad = lerpColor(c1, c2, newPer);
    phase += phaseStep;
    newPer = 0.5 + 0.5* sin(period + phase);
    stroke(grad);
    fill(grad);
    display4FaceLines(i);
  }
}

void linesGradientFaceCycle(color c1, color c2) {
  int start = (currentCycle)%4;
  float phase = 1.0/4;
  float per = start*phase;
  for (int i = 0; i < 4; i++) {
    color grad = lerpColor(c1, c2, per);
    per += phase;
    per %= 1.0;
    stroke(grad);
    fill(grad);
    display4FaceLines(i);
  }
}



void cycleGrowFace(int face, int speed, int phase) {
  float snakeLoc = speed * 4;
  snakeLoc += phase;
  snakeLoc %= 4;

  // going clockwise starting from top left corner
  if (snakeLoc < 1) {
    float sLoc = snakeLoc;
    lines.get(face).displaySegment(0, sLoc);
  } else if (snakeLoc < 2) {
    float sLoc = snakeLoc - 1;
    lines.get(face+1).displaySegment(0, sLoc);
  } else if (snakeLoc < 3) {
    float sLoc = snakeLoc - 2;
    lines.get(face+2).displaySegment(0, sLoc);
  } else {
    float sLoc = snakeLoc - 3;
    lines.get(face+3).displaySegment(0, sLoc);
  }
}

void snakeFaceAll(color c, float speed, int phase) {
  stroke(c);
  fill(c);
  for (int i = 0; i < 4; i++) {
    snakeFace(i, speed, i*phase);
  }
}

void growShrinkBlockEntire(color c1, color c2, color c3, color c4, float per) {
  int currentC = currentCycle -1;
  if ((currentC/8)%4 == 0) growShrinkBlockEntire(c1, per);
  else if ((currentC/8)%4 == 1) growShrinkBlockEntire(c2, per);
  else if ((currentC/8)%4 == 2) growShrinkBlockEntire(c3, per);
  else  growShrinkBlockEntire(c4, per);
}
void growShrinkBlockEntire(color c, float per) {
  stroke(c);
  fill(c);
  float speed = 0;
  if (per < 0.5) speed = map(per, 0, 0.5, 0, 1);
  else speed = map(per, 0.5, 1, 1, 0);
  int [] order = { 0, 4, 8, 12, 13, 14, 10, 6, 2, 3};
  float snakeLoc = speed * 11;
  if (floor(snakeLoc) == 0) return;
  int numFullLines = floor(snakeLoc-1);

  for (int i = 0; i < numFullLines && i < order.length; i++) {
    lines.get(order[i]).display();
  }
  if (numFullLines < order.length && numFullLines >= 0) {
    lines.get(order[numFullLines]).displaySegment(0, (snakeLoc - numFullLines)/2);
  }
}

void snakeFace(int face, float speed, int phase) {
  float snakeLoc = speed * 4;
  snakeLoc += phase;
  snakeLoc %= 4;
  face *= 4;
  // going clockwise starting from top left corner
  if (snakeLoc < 1) {
    float sLoc = snakeLoc;
    lines.get(face).displaySegment(0, sLoc);
    lines.get(face+3).displayFlipSegment(0, 1-sLoc);
  } else if (snakeLoc < 2) {
    float sLoc = snakeLoc - 1;
    lines.get(face+1).displaySegment(0, sLoc);
    lines.get(face).displayFlipSegment(0, 1-sLoc);
  } else if (snakeLoc < 3) {
    float sLoc = snakeLoc - 2;
    lines.get(face+2).displaySegment(0, sLoc);
    lines.get(face+1).displayFlipSegment(0, 1-sLoc);
  } else {
    float sLoc = snakeLoc - 3;
    lines.get(face+3).displaySegment(0, sLoc);
    lines.get(face+2).displayFlipSegment(0, 1-sLoc);
  }
}



void showOne(float per) {
  per = map(per, 0, 1, 0, lines.size());
  int num = constrain(int(per), 0, lines.size()-1);
  lines.get(num ).display();
}





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// LINE CLASS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Line {

  PVector p1;
  PVector p2;
  int zIndex = 0;
  int z1 = 0;
  int z2 = 0;
  float zAve = 0;
  float ang;
  int id1, id2;
  int constellationG = 0;
  int twinkleT;
  int twinkleRange = 0;
  long lastChecked = 0;
  int rainbowIndex = int(random(255));
  color lineC;


  Line(float x0, float y0, float x1, float y1) {
    this.p1 = new PVector(x0, y0);
    this.p2 = new PVector(x1, y1);
  }


  Line(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }

  Line(int x1, int y1, int x2, int y2) {
    this.p1 = new PVector(x1, y1);
    this.p2 = new PVector(x2, y2);
  }

  void initLine() {
    leftToRight();
    ang = atan2(this.p1.y - this.p2.y, this.p1.x - this.p2.x);
    if (ang > PI/2) ang -= 2*PI;
    twinkleT = int(random(50, 255));
    twinkleRange = int(dist(p1.x, p1.y, p2.x, p2.y)/100);
  }

  void display(color c) {
    stroke(c);
    fill(c);
    display();
  }

  void display() {
    strokeCap(ROUND);
    strokeWeight(lineW);
    line(p1.x, p1.y, p2.x, p2.y);
    drawEndCaps(p1, p2);

    //if (editingLines) {
    //  stroke(255, 0, 0);
    //  ellipse(p1.x, p1.y, 10, 10);
    //  ellipse(p2.x, p2.y, 10, 10);
    //}
    strokeCap(SQUARE);
  }

  void displayCenterPulse(float per) {
    per = constrain(per, 0, 1.0);
    float midX = (p1.x + p2.x)/2;
    float midY = (p1.y + p2.y)/2;
    float x1 = map(per, 0, 1.0, midX, p1.x);
    float x2 = map(per, 0, 1.0, midX, p2.x);
    float y1 = map(per, 0, 1.0, midY, p1.y);
    float y2 = map(per, 0, 1.0, midY, p2.y);
    strokeWeight(lineW);
    line(x1, y1, x2, y2);
  }

  void moveP1(int x, int y) {
    p1.x += x;
    p1.y += y;
  }

  void moveP2(int x, int y) {
    p2.x += x;
    p2.y += y;
  }

  void displayZDepth() {
    colorMode(HSB, 255);
    stroke(map(zAve, 0, 9, 0, 255), 255, 255);
    display();
    colorMode(RGB, 255);
  }

  void leftToRight() {
    if (p1.x > p2.x) {
      PVector temp = new PVector(p1.x, p1.y);
      p1.set(p2);
      p2.set(temp);
    }
  }

  void rightToLeft() {
    if (p1.x < p2.x) {
      PVector temp = p1;
      p1.set(p2);
      p2.set(temp);
    }
  }

  void displayPercent(float per) {
    per*= 2;
    float p = constrain(per, 0, 1.0);
    PVector pTemp = PVector.lerp(p1, p2, p);
    strokeWeight(lineW);
    line(p1.x, p1.y, pTemp.x, pTemp.y);
    drawEndCaps(p1, pTemp);
  }

  void displayGradientLine(color c1, color c2, float per, float phase, boolean flip) {
    per += phase;
    per %= 1;

    float spacing = 1.0/screenH;
    for (float i = 0; i < 1.0; i+= spacing) {
      float grad = (i/2 + per)%1;
      stroke(getCycleColor(c1, c2, grad));
      if (flip) displayFlipSegment(i, spacing);
      else displaySegment(i, spacing);
    }
  }

  void displayPercentWid(float per) {
    per = constrain(per, 0, 1.0);
    int sw = int(map(per, 0, 1.0, 0, 5));
    strokeWeight(sw);
    line(p1.x, p1.y, p2.x, p2.y);
    drawEndCaps(p1, p2);
  }

  void fftLine() {
    lineW = int(map(bands[0], 0, 600, 0, 10));
    lineW = constrain(lineW, 0, 10);

    display();
    lineW = origLineW;
  }

  void twinkle(int wait) {
    int num = int(dist(p1.x, p1.y, p2.x, p2.y)/100);

    if (millis() - lastChecked > wait) {
      twinkleT = int(random(100, 255));
      lastChecked = millis();
      //if (twinkleT > 220) twinkleRange = num + int(random(3));
    }

    noStroke();
    fill(twinkleT);
    for (int i = 0; i < num; i++) {
      float x = map(i, -.5, twinkleRange, p1.x, p2.x);
      float y = map(i, -.5, twinkleRange, p1.y, p2.y);
      ellipse(x, y, 4, 10);
    }
  }

  void displayBandX(int start, int end, color c) {
    if (p1.x > start && p1.x < end) {
      display(c);
    }
  }

  void displayBandX(int start, int end) {
    if (p1.x > start && p1.x < end) {
      display(color(255));
    } else {
      displayNone();
    }
  }

  void displayBandY(int start, int end, color c) {
    if (p1.y > start && p1.y < end) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayBandZ(int start, int end, color c) {
    if (z1 >= start && z1 < end) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayBandZ(int band, color c) {
    if (z1 == band) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayNone() {
    //strokeWeight(18);
    display(color(0));
    //strokeWeight(2);
  }


  void displayEqualizer(int[] bandH, color c) {
    if (p1.x >= 0 && p1.x < width/4) {
      displayBandY(0, bandH[0], c);
    } else if (p1.x >= width/4 && p1.x < width/2) {
      displayBandY(0, bandH[1], c);
    } else if (p1.x >= width/2 && p1.x < width*3.0/4) {
      displayBandY(0, bandH[2], c);
    } else {
      displayBandY(0, bandH[3], c);
    }
  }

  void displayPointX(int x) {
    float ym;

    if (x > p1.x && x < p2.x) {
      ym = map(x, p1.x, p2.x, p1.y, p2.y);
      ellipse(x, ym, 10, 10);
    } else if (x > p2.x && x < p1.x) {
      ym = map(x, p2.x, p1.x, p2.y, p1.y);
      ellipse(x, ym, 10, 10);
    }
  }

  void displayPointY(float per, boolean flip) {
    float y = map(per, 0, 1, p1.y, p2.y);
    if (flip) y = map(per, 0, 1, p2.y, p1.y);
    float xm;
    if ( (y > p1.y && y < p2.y) ) {
      xm = map(y, p1.y, p2.y, p1.x, p2.x);
      ellipse(xm, y, 10, 10);
      //println(y + " " + xm);
    } else if (y > p2.y && y < p1.y) {
      xm = map(y, p2.y, p1.y, p2.x, p1.x);
      ellipse(xm, y, 10, 10);
      //println(y + " " + xm);
    }
  }

  int mouseOver() {
    float d = dist(p1.x, p1.y, mouseX, mouseY);
    if (d < 5) {
      return 0;
    }
    d = dist(p2.x, p2.y, mouseX, mouseY);
    if (d < 5) {
      return 1;
    }
    return -1;
  }

  void highlightOver() {
    float x = p1.x;
    float y = p1.y;
    strokeWeight(1);
    if (mouseOver() > -1) {
      if (mouseOver() == 1) {
        x = p2.x;
        y = p2.y;
      }
      noFill();
      stroke(255, 0, 0);
      ellipse(x, y, 20, 20);
      fill(255, 100, 0);
      ellipse(x, y, 10, 10);
    }
  }

  // www.jeffreythompson.org/collision-detection/line-point.php
  boolean mouseOverLine() {
    float x1 = p1.x;
    float y1 = p1.y;
    float x2 = p2.x;
    float y2 = p2.y;
    float px = mouseX;
    float py = mouseY;
    float d1 = dist(px, py, x1, y1);
    float d2 = dist(px, py, x2, y2);
    float lineLen = dist(x1, y1, x2, y2);
    float buffer = 0.2;    // higher # = less accurate
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
      return true;
    }
    return false;
  }

  void setZIndex(int k) {
    zIndex = k;
    println("zIndex of " + id1 + "" + id2 + " is now " + k);
  }


  void displayZIndex() {
    colorMode(HSB, 255);
    //display(color(map(zIndex, 0, numRectZ-1, 0, 255), 255, 255));
  }


  void displayRainbowCycle(int pulse) {
    //color c =  color(((i * 256 / lines.size()) + pulseIndex) % 255, 255, 255);
    colorMode(HSB, 255);
    for (float i = 0; i < 50; i++) {
      if (z1 <= z2) {
        float z = map(i, 0, 50, z1, z2);
        float s = map(z, 0, 9, 0, 255);
        stroke((s+pulse)%255, 255, 255);

        PVector pTemp = PVector.lerp(p1, p2, i/50.0);
        PVector pTempEnd = PVector.lerp(pTemp, p2, (i+1)/50.0);
        strokeWeight(lineW);
        line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
        drawEndCaps(pTemp, pTempEnd);
      }
    }
    colorMode(RGB, 255);
  }

  void displayRainbowRandom() {
    rainbowIndex++;
    if (rainbowIndex > 255) rainbowIndex = 0;
    colorMode(HSB, 255);
    display(color(rainbowIndex, 255, 255));
    colorMode(RGB, 255);
  }

  void displayFlipSegment(float startPer, float sizePer) {
    strokeWeight(lineW);
    PVector pTemp = PVector.lerp(p2, p1, startPer);
    PVector pTempEnd = PVector.lerp(pTemp, p1, startPer + sizePer);
    line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
    drawEndCaps(pTemp, pTempEnd);
  }

  void displaySegment(float startPer, float sizePer) {
    strokeWeight(lineW);
    strokeCap(ROUND);
    PVector pTemp = PVector.lerp(p1, p2, startPer);
    PVector pTempEnd = PVector.lerp(pTemp, p2, startPer + sizePer);

    line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
    drawEndCaps(pTemp, pTempEnd);
  }

  void setGradientZ(color c1, color c2, int jump) {
    colorMode(HSB, 255);
    int colhue = (frameCount%255) + zIndex*jump;
    if (colhue < 0) colhue += 255;
    else if (colhue > 255) colhue -= 255;
    colorMode(RGB, 255);
    float m;
    if (colhue < 127) {
      m = constrain(map(colhue, 0, 127, 0, 1), 0, 1);
      display(lerpColor(c1, c2, m));
    } else {
      m = constrain(map(colhue, 127, 255, 0, 1), 0, 1);
      display(lerpColor(c2, c1, m));
    }
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UTILITIES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void drawEndCaps(PVector p1, PVector p2) {
  if (dist(p1.x, p1.y, p2.x, p2.y) > 1) {
    ellipse(p1.x, p1.y, lineW/6, lineW/6);
    ellipse(p2.x, p2.y, lineW/6, lineW/6);
  }
}

void moveSelectedLine() {
  if (selectedP != null) {
    selectedP.move();
  }
}

void snapOutlinesToMask() {
  lines = new ArrayList<Line>();
  int[][] pts = {  
    { 0, 1, 8, 9 }, 
    { 1, 2, 7, 8 }, 
    { 2, 3, 6, 7 }, 
    { 3, 4, 5, 6}
  };
  for (int i = 0; i < 4; i++) {
    int g = 3;
    lines.add(new Line(maskPoints[keystoneNum][pts[i][0]].x+g, maskPoints[keystoneNum][pts[i][0]].y + g, maskPoints[keystoneNum][pts[i][1]].x-g, maskPoints[keystoneNum][pts[i][1]].y + g));
    lines.add(new Line(maskPoints[keystoneNum][pts[i][1]].x-g, maskPoints[keystoneNum][pts[i][1]].y + g, maskPoints[keystoneNum][pts[i][2]].x - g, maskPoints[keystoneNum][pts[i][2]].y - g));
    lines.add(new Line(maskPoints[keystoneNum][pts[i][2]].x -g, maskPoints[keystoneNum][pts[i][2]].y - g, maskPoints[keystoneNum][pts[i][3]].x + g, maskPoints[keystoneNum][pts[i][3]].y - g));
    lines.add(new Line(maskPoints[keystoneNum][pts[i][3]].x +g, maskPoints[keystoneNum][pts[i][3]].y - g, maskPoints[keystoneNum][pts[i][0]].x + g, maskPoints[keystoneNum][pts[i][0]].y + g));
  }
}

void displayEditingLines() {
  displayLines(color(255));
  if (editingLines) {
    for (Line l : lines) {
      l.highlightOver();
    }
    if (isDragging) {
      println(mouseX, mouseY);
      selectedLineP.set(mouseX, mouseY);
    }
  }
}

void checkLineClick() {
  for (Line l : lines) {
    int ptOver = l.mouseOver();
    if (ptOver > -1) {
      if (ptOver == 0) selectedLineP = l.p1;
      else selectedLineP = l.p2;
      isDragging = true;
      return;
    }
  }
}

void linesReleaseMouse() {
  isDragging = false;
  selectedLineP = null;
}

void loadLines() {
  lines = new ArrayList<Line>();
  processing.data.JSONObject linesJson;
  if (useTestKeystone) linesJson = loadJSONObject("data/lines/lines_Test.json");
  else linesJson = loadJSONObject("data/lines/lines.json");

  processing.data.JSONArray linesArray = linesJson.getJSONArray("lineList");
  for (int i = 0; i < 16; i++) {
    processing.data.JSONObject l = linesArray.getJSONObject(i);
    float x0 = l.getFloat("x0");
    float y0 = l.getFloat("y0");
    float x1 = l.getFloat("x1");
    float y1 = l.getFloat("y1");
    lines.add(new Line(x0, y0, x1, y1));
  }
}

void saveMappedLines() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();

  processing.data.JSONArray linesList = new processing.data.JSONArray();    

  for (int i = 0; i < lines.size(); i++) {
    processing.data.JSONObject lineJSON = new processing.data.JSONObject();
    Line l = lines.get(i);
    lineJSON.setFloat("x0", l.p1.x);
    lineJSON.setFloat("y0", l.p1.y);
    lineJSON.setFloat("x1", l.p2.x);
    lineJSON.setFloat("y1", l.p2.y);

    linesList.setJSONObject(i, lineJSON);
  }
  json.setJSONArray("lineList", linesList);
  if (useTestKeystone) saveJSONObject(json, "data/lines/lines_Test.json");
  else saveJSONObject(json, "data/lines/lines.json");
}

color getCycleColor(color c1, color c2, float per) {
  per *= 2;
  if (per < 1) {
    return lerpColor(c1, c2, per);
  } else {
    per = map(per, 1, 2, 0, 1);
    return lerpColor(c2, c1, per);
  }
}

color getCycleColor(color c1, color c2, color c3, float per) {
  per *=3;
  if (per < 1) {
    return lerpColor(c1, c2, per);
  } else if (per < 2) {
    per = map(per, 1, 2, 1, 0);
    return lerpColor(c2, c3, per);
  } else {
    per = map(per, 2, 3, 1, 0);
    return lerpColor(c3, c1, per);
  }
}

ArrayList<Line> lines;
int visualMode = -1;
boolean editingLines = false;
PVector selectedLineP = null;
int origLineW = 10;
int lineW = origLineW;

///////////////////////
// OTHER VARIABLES
int pulseIndex = 0;
int lastCheckedPulse = 0;
int pointDirection = 4;
int seesawVals[] = {0, 0};


/////////////////////
// VISUAL MODES
int V_NONE, 
  V_PULSING, 
  V_ROTATE_ANGLE_COUNT, 
  V_ROTATE_ANGLE, 
  V_PULSE_LINE_BACK, 
  V_PULSE_LINE_RIGHT, 
  V_PULSE_LINE_LEFT, 
  V_PULSE_LINE_UP, 
  V_PULSE_LINE_DOWN, 
  V_CYCLE_CONST, 
  V_SHOW_ONE, 
  V_ROTATE_ANGLE_BEATS, 
  V_PULSING_ON_LINE, 
  V_SEGMENT_SHIFT, 
  V_FADE, 
  V_DISPLAY, 
  V_TRANSIT;


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

void initLines() {
  snapOutlinesToMask();
  //loadLines();
  initLineModes();
}

void moveSelectedLine() {
  if (selectedP != null) {
    selectedP.move();
  }
}


void initLineModes() {
  int temp = -1;
  V_NONE = temp++; 
  V_PULSING = temp++; 
  //V_ROTATE_ANGLE_COUNT = temp++;
  //V_ROTATE_ANGLE = temp++; 
  //V_PULSE_LINE_BACK = temp++;
  V_PULSE_LINE_RIGHT = temp++;
  V_PULSE_LINE_LEFT = temp++;
  V_PULSE_LINE_UP = temp++;
  V_PULSE_LINE_DOWN = temp++;
  //V_CYCLE_CONST = temp++; 
  V_SHOW_ONE = temp++; 
  V_ROTATE_ANGLE_BEATS = temp++; 
  V_PULSING_ON_LINE = temp++; 
  V_SEGMENT_SHIFT = temp++; 
  V_FADE = temp++;
  V_TRANSIT = temp++;
  V_DISPLAY = temp++;
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

void displayLineMode() {
  changeMode();
  playMode();
}

void playMode() {
  if (visualMode == V_ROTATE_ANGLE_COUNT) rotateAngleCounter(100, 20);
  else if (visualMode == V_PULSE_LINE_BACK) pulseLineBack(500);
  else if (visualMode == V_PULSE_LINE_RIGHT) pulseLineRight(90, 80);
  else if (visualMode == V_PULSE_LINE_LEFT)  pulseLineLeft(90, 80);
  else if (visualMode == V_PULSE_LINE_UP) pulseLineUp(90, 80);
  else if (visualMode == V_PULSE_LINE_DOWN) pulseLineDown(90, 80);
  else if (visualMode == V_CYCLE_CONST) cycleConstellation(150);
  else if (visualMode == V_PULSING) pulsing(0, 90);
  else if (visualMode == V_SHOW_ONE) showOne(100);
  else if (visualMode == V_PULSING_ON_LINE) pulseLinesCenter(1);
  else if (visualMode == V_SEGMENT_SHIFT) segmentShift(10);
  else if (visualMode == V_TRANSIT) transit(30);
  else if (visualMode == V_DISPLAY) displayLines(255);
}

void changeMode() {
  if ((millis()/1000)%7 == 0) {
    //if (int(random(2)) == 0) visualMode = V_DISPLAY;
    //else visualMode = int(random(15));
    visualMode++;
    visualMode%=10;
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

//////////////////////////////////////////////////////////////////
void fftLines() {
  updateSpectrum();
  for (Line l : lines) {
    l.fftLine();
  }
}
void displayLinesCube(int index, color c) {
  for (int i = index * 4; i < (index+1)*4; index++) {
    stroke(c);
    lines.get(i).display();
  }
}
void handLight(float x, float y, int rad, color c) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).handLight(x, y, rad, c);
  }
}
void transit(int rate) {

  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    if (pulseIndex > 100) pulseIndex = 0;
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(pulseIndex / 100.0, .2);
  }
}

void transitHand(float per, color c) {
  stroke(c);
  per = constrain(per, 0, 1.0);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(per, .2);
  }
}

void loadLines() {
  lines = new ArrayList<Line>();
  processing.data.JSONObject linesJson;
  linesJson = loadJSONObject("data/lines/lines.json");

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
  //saveJSONObject(json, "data/lines/lines.json");

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
  saveJSONObject(json, "data/lines/lines.json");
}

void rainbowRandom() {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayRainbowRandom();
  }
}

void rainbowCycle(int amt) {
  colorMode(HSB, 255);
  pulseIndex+= amt;
  if (pulseIndex > 255) pulseIndex = 0;
  for (int i=0; i< lines.size(); i++) {
    //color c =  color(((i * 256 / lines.size()) + pulseIndex) % 255, 255, 255);
    lines.get(i).displayRainbowCycle(pulseIndex);
  }
  colorMode(RGB, 255);
}

void rainbow() {
  pulseIndex++;
  if (pulseIndex > 255) pulseIndex = 0;
  colorMode(HSB, 255);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).display(color(pulseIndex, 255, 255));
  }
  colorMode(RGB, 255);
}

void segmentShift(int jump) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displaySegment(pulseIndex / 100.0, .5);
  }
}

void rotateAngle(int rate, int angleGap) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+= angleGap;
    if (pulseIndex > -70 ) {
      pulseIndex = -280;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayAngle(pulseIndex, pulseIndex+angleGap, color(255));
  }
}

boolean startFadeLine = false;
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

void wipeRight(int amt, int w) {
  stroke(255);
  displayLines();
  fill(0);
  noStroke();
  pulseIndex += amt;
  if (pulseIndex > width) pulseIndex = 0;
  rect(pulseIndex, 0, w, height);
}

void rotateAngleCounter(int rate, int angleGap) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-= angleGap;
    if (pulseIndex < -280 ) {
      pulseIndex = -70;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayAngle(pulseIndex, pulseIndex+angleGap, color(255));
  }
}

void displayYPoints(int y, color c) {
  fill(c);
  stroke(c);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointY(y);
  }
}

void displayXPoints(int x, color c) {
  fill(c);
  stroke(c);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointX(x);
  }
}

void displayYPoints(int rate, int bottom, int top) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > top) {
    pulseIndex = top;
    pointDirection = -1;
  } else if (pulseIndex < bottom) {
    pulseIndex = bottom;
    pointDirection = 1;
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointY(pulseIndex);
  }
}

void displayXPoints(int rate, int left, int right) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > right) {
    pulseIndex = right;
    pointDirection = -1;
  } else if (pulseIndex < left) {
    pulseIndex = left;
    pointDirection = 1;
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPointX(pulseIndex);
    lines.get(i).displayPointX(pulseIndex+100);
  }
}

void randomLines(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    background(0);
    lastCheckedPulse = millis();
    for (int i = 0; i < 20; i++) {
      line(random(50, width - 100), random(50, height - 100), random(50, width - 100), random(50, height - 100));
    }
  }
}


void pulseLinesCenter(int rate) {
  pulseIndex += pointDirection * rate;
  if (pulseIndex > 100) {
    pulseIndex = 100;
    pointDirection = -1;
  } else if (pulseIndex < 0) {
    pulseIndex = 0;
    pointDirection = 1;
  }
  float per = pulseIndex / 100.0;
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayCenterPulse(per);
  }
}

void randomSegments(int rate) {
}

void twinkleLines() {
  for (int i = 0; i < lines.size(); i++) {
    fill(255);
    lines.get(i).twinkle(50);
  }
}

void pulseLineRight(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+= bandSize;
    if (pulseIndex > width) {
      pulseIndex = -bandSize;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandX(pulseIndex, pulseIndex+bandSize);
  }
}

void pulseLineLeft(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-=bandSize;
    if (pulseIndex < -bandSize) {
      pulseIndex = width;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandX(pulseIndex, pulseIndex+bandSize);
  }
}

void pulseLineUp(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex-=bandSize;
    if (pulseIndex < -bandSize) {
      pulseIndex = height;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandY(pulseIndex, pulseIndex+bandSize, color(255));
  }
}


void pulseLineDown(int rate, int bandSize) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex+=bandSize;
    if (pulseIndex > height) {
      pulseIndex = -bandSize;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandY(pulseIndex, pulseIndex+bandSize, color(255));
  }
}

void pulseLineBack(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    if (pulseIndex > 9) {
      pulseIndex = -1;
    }
    lastCheckedPulse = millis();
  }
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayBandZ(pulseIndex, color(255));
  }
}

void cycleConstellation(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    if (pulseIndex > 9) {
      pulseIndex = 1;
    }
    lastCheckedPulse = millis();
  }
  showConstellationLine(pulseIndex);
}

void showOne(int rate) {
  if (millis() - lastCheckedPulse > rate) {
    pulseIndex++;
    lastCheckedPulse = millis();
  }
  if (pulseIndex >= lines.size()) pulseIndex = 0;
  else if (pulseIndex < 0) pulseIndex = 0;
  lines.get(pulseIndex).display();
}

void pulsing(int hue, int rate) {
  pulseIndex += rate;
  pulseIndex %= 510;
  int b = pulseIndex;
  if (pulseIndex > 255) b = int(map(pulseIndex, 255, 510, 255, 0));
  colorMode(HSB, 255);
  for (int i = 0; i < lines.size(); i++) {
    stroke(hue, 255, b);
    fill(hue, 255, b);
    lines.get(i).display();
  }
  colorMode(RGB, 255);
}

void showConstellationLine(int l) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayConstellation(l, color(255));
  }
}

void linePercentW(int per) {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).displayPercentWid(per);
  }
}



//void cycleModes(int rate) {
//  if (millis() - stringChecked > rate) {
//    visualMode = int(random(1, 11));
//    stringChecked = millis();
//  }
//  playMode();
//}



void resetZIndex() {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).setZIndex(0);
  }
}

void resetConstellationG() {
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).setConstellationG(0);
  }
}


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
    initLine();
  }

  Line(int x0, int y0, int x1, int y1) {
    this.p1 = new PVector(x0, y0);
    this.p2 = new PVector(x1, y1);
    initLine();
  }

  Line(PVector p1, PVector p2, int id1, int id2) {
    this.p1 = p1;
    this.p2 = p2;
    initLine();
  }

  Line(int x1, int y1, int x2, int y2, int id1, int id2) {
    this.p1 = new PVector(x1, y1);
    this.p2 = new PVector(x2, y2);
    initLine();
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
    line(p1.x, p1.y, pTemp.x, pTemp.y);
  }

  void displayPercentWid(float per) {
    per = constrain(per, 0, 1.0);
    int sw = int(map(per, 0, 1.0, 0, 5));
    strokeWeight(sw);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  void fftLine() {
    lineW = int(map(bands[0], 0, 600, 0, 10));
    lineW = constrain(lineW, 0, 10);

    display();
    lineW = origLineW;
  }

  void fftConstellation(float c, float per) {
    per = constrain(per, 0, 1.0);
    int sw = int(map(per, 0, 1.0, 0, 5));
    sw = constrain(sw, 0, 5);
    if (sw < 1) noStroke();
    else {
      strokeWeight(sw);
    }
    if (constellationG == c)line(p1.x, p1.y, p2.x, p2.y);
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

  void randomSegment() {
    //float len = random(
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

  void displayConstellation(int num, color c) {
    if (constellationG == num) {
      display(c);
    } else {
      displayNone();
    }
  }

  void displayAngle(int start, int end, color c) {
    if (end < -360) {
      if (ang >= radians(start) || ang < end + 360) {
        display(c);
      }
    } else if (ang >= radians(start) && ang < radians(end)) {
      display(c);
    } else {
      displayNone();
    }
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

  void displayPointY(int y) {
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

  void setConstellationG(int k) {
    constellationG = k;
    println("constellation of " + id1 + "" + id2 + " is now " + k);
  }

  void setZIndex(int k) {
    zIndex = k;
    println("zIndex of " + id1 + "" + id2 + " is now " + k);
  }

  void displayByIDs(int id1, int id2) {
    if (findByID(id1, id2)) {
      display();
    }
  }

  void displayZIndex() {
    colorMode(HSB, 255);
    //display(color(map(zIndex, 0, numRectZ-1, 0, 255), 255, 255));
  }

  void displayByIDsPercent(int id1, int id2, float per) {
    if (findByID(id1, id2)) {
      displayPercent(per);
    }
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
        line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
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

  void handLight(float x, float y, int rad, color c) {
    float i = 0.0;
    float startX = p1.x;
    float startY = p1.y;
    boolean started = false;
    while (i < 1.0) {
      i+= .1;
      if (!started) {
        float dx = map(i, 0, 1.0, p1.x, p2.x);
        float dy = map(i, 0, 1.0, p1.y, p2.y);
        float dis = dist(x, y, dx, dy);
        if (dis < rad) {
          startX = dx;
          startY = dy;
          started = true;
        }
      } else {
        float dx = map(i, 0, 1.0, p1.x, p2.x);
        float dy = map(i, 0, 1.0, p1.y, p2.y);
        float dis = dist(x, y, dx, dy);
        if (dis > rad) {
          stroke(c);
          line(startX, startY, dx, dy);
          break;
        }
      }
    }
  }

  void displaySegment(float startPer, float sizePer) {
    PVector pTemp = PVector.lerp(p1, p2, startPer);
    PVector pTempEnd = PVector.lerp(pTemp, p2, startPer + sizePer);
    line(pTemp.x, pTemp.y, pTempEnd.x, pTempEnd.y);
  }

  boolean findByID(int id1, int id2) {
    return (this.id1 == id1 && this.id2 == id2) || (this.id2 == id1 && this.id1 == id2);
  }

  boolean findByID(int id) {
    return (this.id1 == id || this.id2 == id);
  }

  int getX1() {
    return int(p1.x);
  }

  int getX2() {
    return int(p2.x);
  }

  int getY1() {
    return int(p1.y);
  }

  int getY2() {
    return int(p2.y);
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

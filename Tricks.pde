
boolean personOnPlatform = false;

//////////////////////////////////////////////////////////////////////////////////
// CRUSH SPHERE
//////////////////////////////////////////////////////////////////////////////////
void updateSphereBoxHand() {
  float rot = map(mouseX, width/2 - 200, width/2 + 200, -PI, PI);
  sphereBoxRot.set(0, rot, 0);
}

void crushSphere() {
  updateSphereBoxHand();
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
// WAVE HANDS
//////////////////////////////////////////////////////////////////////////////////
void drawWaveHands() {
  //float rot = constrain(map(mouseX, width/2 -200, width/2 + 200, -PI/2, 0), -PI/2, 0);
  float rot = constrain(map(mouseX, width/2 -200, width/2 + 200, -PI/2, PI/2), -PI/2, PI/2);

  int h = int(hands[currentCycle%4].height*1.0*screenW/hands[currentCycle%4].width);
  for (int i = 0; i < 2; i++) {
    PGraphics s = screens[i*3].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(BLEND);
    s.pushMatrix();
    s.translate(screenW/2, screenH/2);
    s.rotateZ(rot);
    s.image(hands[currentCycle%4], -screenW/2, -h/2, screenW, h);
    s.popMatrix();
    s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// CONSTELLATION IMAGE
//////////////////////////////////////////////////////////////////////////////////
//void drawConstBrightImageHand(PGraphics s, int screenNum, int w) {
//  if (personOnPlatform) {
//    float lr = constrain(map(mouseX, width/2 - 200, width/2 + 200, -1, 1), -1, 1);
//    // maskPoints[keystoneNum][0].x + 50;

//    if (lr < 0) {
//      if (screenNum == 0) {
//        int h = int(w * 1.0 /symbols[screenNum].width * symbols[screenNum].height);
//        s.image(symbols[screenNum], s.width/2 - w/2, s.height/2 - h/2, w, h);
//        s.fill(0, -lr * 255);
//        s.rect(0, 0, s.width, s.height);
//      }
//    } else {
//      if (screenNum == 3) {
//        int h = int(w * 1.0 /symbols[screenNum].width * symbols[screenNum].height);

//        s.image(symbols[screenNum], s.width/2 - w/2, s.height/2 - h/2, w, h);

//        s.fill(0, lr * 255);
//        s.rect(0, 0, s.width, s.height);
//      }
//    }
//  }
//}

void drawSymbolsLeftRightImageHand(PGraphics s, int screenNum, int w) {
  if (personOnPlatform) {
    int lr = constrain(int((map(mouseX, width/2 - 200, width/2 + 200, 0, 4))), 0, 3);
    // maskPoints[keystoneNum][0].x + 50;

    if (lr == screenNum) {
      int h = int(w * 1.0 /symbols[screenNum].width * symbols[screenNum].height);
      s.image(symbols[screenNum], s.width/2 - w/2, s.height/2 - h/2, w, h);
      //s.image(symbols[screenNum], 0, 0, w, w);
    }
  }
}

void drawSymbolsLeftRightSmoothImageHand(PGraphics s, int screenNum, int w) {
  int padding = 50;
  if (personOnPlatform) {
    int lr = constrain(int((map(mouseX, width/2 - 200, width/2 + 200, padding, 4*screenW-w-padding))), padding, 4*screenW-w-padding);
    // maskPoints[keystoneNum][0].x + 50;

    int h = int(w * 1.0 /symbols[screenNum].width * symbols[screenNum].height);
    s.image(symbols[currentCycle%4], lr - screenW * screenNum, s.height/2 - h/2, w, h);
  }
}

//////////////////////////////////////////////////////////////////////////////////
// EYE
//////////////////////////////////////////////////////////////////////////////////
GShader shader;
int idxShader = -1;

void initEye() {
  shader = new GShader("shaders/eye.glsl");
  shader.addParameter("mouse", 0, width, 0, height);
}

void drawEye() { 
  int x = constrain(int(map(mouseX, width/2-200, width/2+200, 0, 600)), 0, 500);
  int y = constrain(int(map(mouseY, height/2, height, 0, height/2)), 0, 500);
  setEyePos(x, y);
  shader.setShaderParameters();

  PGraphics s = sphereScreen.s;
  s.beginDraw();
  //if (millis()%8000 < 100) {
  //  s.background(0);
  //} else {
  s.shader(shader.shader);
  s.rect(0, 0, s.width, s.height);
  //}
  s.endDraw();

  //fill(0);
  //image(pg, 0, 0);
}

void setEyePos(int x, int y) {
  for (Param p : shader.parameters) {  
    if (p.name.equals("mouse")) {
      float[] pts = {x, y};
      p.set( pts );
      return;
    }
  }
}

class Param 
{
  String name;
  float value;
  PVector value2;
  float minValue, maxValue;
  PVector minValue2, maxValue2;
  boolean is2d;

  Param(String name, float minValue, float maxValue) {
    this.name = name;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = 0.5 * (minValue + maxValue);
    is2d = false;
  }

  Param(String name, float minValue1, float maxValue1, float minValue2, float maxValue2) {
    this.name = name;
    this.minValue2 = new PVector(minValue1, minValue2);
    this.maxValue2 = new PVector(maxValue1, maxValue2);
    this.value2 = new PVector(0.5 * (this.minValue2.x + this.maxValue2.x), 
      0.5 * (this.minValue2.y + this.maxValue2.y) );
    is2d = true;
  }

  void set(float value) {
    this.value = value;
  }

  void set(float[] value) {
    this.value2.set(value[0], value[1]);
  }
}

class GShader
{
  String path;
  PShader shader;
  ArrayList<Param> parameters;

  GShader(String path) {
    this.path = path;
    shader = loadShader(path);
    parameters = new ArrayList<Param>();
  }

  void addParameter(String name, float minVal, float maxVal) {
    Param param = new Param(name, minVal, maxVal);
    parameters.add(param);
  }

  void addParameter(String name, float minVal1, float maxVal1, float minVal2, float maxVal2) {
    Param param = new Param(name, minVal1, maxVal1, minVal2, maxVal2);
    parameters.add(param);
  }

  void setShaderParameters() {
    PGraphics s = sphereScreen.s;
    shader.set("time", (float) millis()/1000.0);
    shader.set("resolution", float(s.width), float(s.height));
    for (Param p : parameters) {
      if (p.is2d) {
        shader.set(p.name, p.value2.x, p.value2.y);
      } else {
        shader.set(p.name, p.value);
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
void handsHorizFaceLines(color c) {
  int face = constrain(int(map(mouseX, width/2-300, width/2+300, 0, 4)), 0, 3);
  if (mouseY < height -100) display4FaceLines(c, face);
}



//////////////////////////////////////////////////////////////////////////////////
// TELEPORTING DOTS
//////////////////////////////////////////////////////////////////////////////////
// Author: FAL (website: https://www.fal-works.com/ )
Dot [] dotArray;
float effectiveRadius = 0;
boolean awayDots = false;

class Dot {
  PVector position;
  float displaySize = 3;
  color displayColor;
  PVector targetPosition;
  float currentMoveFrameCount = 0;
  boolean isMoving = false;
  float relayPointRatio = 0;
  PVector relayPointPosition;
  float startPointRatio = 0;
  PVector startPointPosition;
  float endPointRatio = 0;
  PVector endPointPosition;
  float moveDurationFrameCount = 17;

  Dot() {
    this.position = new PVector(0, 0);
    this.displayColor = color(255);
    this.targetPosition = new PVector(0, 0);
    this.relayPointPosition = new PVector(0, 0);
    this.startPointPosition = new PVector(0, 0);
    this.endPointPosition = new PVector(0, 0);
  }

  void setTarget(float x, float y) {
    float displacementX, displacementY;
    if (this.isMoving) {
      this.position.set(this.endPointPosition.x, this.endPointPosition.y);
    }
    this.targetPosition.set(x, y);
    this.currentMoveFrameCount = 0;
    this.isMoving = true;
    displacementX = x - this.position.x;
    displacementY = y - this.position.y;
    if (random(1) < 0.5) {
      this.relayPointRatio = abs(displacementX) / (abs(displacementX) + abs(displacementY));
      this.relayPointPosition.set(this.position.x + displacementX, this.position.y);
    } else {
      this.relayPointRatio = abs(displacementY) / (abs(displacementX) + abs(displacementY));
      this.relayPointPosition.set(this.position.x, this.position.y + displacementY);
    }
  }

  void update() {
    float endPointX, endPointY, ratio, startPointX, startPointY;
    if (this.isMoving) {
      this.currentMoveFrameCount++;
      this.startPointRatio = this.getStartPointRatio();
      this.endPointRatio = this.getEndPointRatio();
      if (this.startPointRatio < this.relayPointRatio) {
        ratio = this.startPointRatio / this.relayPointRatio;
        startPointX = this.position.x + ratio * (this.relayPointPosition.x - this.position.x);
        startPointY = this.position.y + ratio * (this.relayPointPosition.y - this.position.y);
      } else {
        ratio = (this.startPointRatio - this.relayPointRatio) / (1 - this.relayPointRatio);
        startPointX = this.relayPointPosition.x + ratio * (this.targetPosition.x - this.relayPointPosition.x);
        startPointY = this.relayPointPosition.y + ratio * (this.targetPosition.y - this.relayPointPosition.y);
      }
      this.startPointPosition.set(startPointX, startPointY);
      if (this.endPointRatio < this.relayPointRatio) {
        ratio = this.endPointRatio / this.relayPointRatio;
        endPointX = this.position.x + ratio * (this.relayPointPosition.x - this.position.x);
        endPointY = this.position.y + ratio * (this.relayPointPosition.y - this.position.y);
      } else {
        ratio = (this.endPointRatio - this.relayPointRatio) / (1 - this.relayPointRatio);
        endPointX = this.relayPointPosition.x + ratio * (this.targetPosition.x - this.relayPointPosition.x);
        endPointY = this.relayPointPosition.y + ratio * (this.targetPosition.y - this.relayPointPosition.y);
      }
      this.endPointPosition.set(endPointX, endPointY);
      if (this.currentMoveFrameCount >= this.moveDurationFrameCount) {
        this.position.set(this.targetPosition.x, this.targetPosition.y);
        this.isMoving = false;
      }
    }
  }

  void display() {
    if (this.isMoving) {
      strokeWeight(this.displaySize);
      //colorMode(HSB);
      stroke(this.displayColor);
      noFill();
      beginShape();
      vertex(this.startPointPosition.x, this.startPointPosition.y);
      if (this.startPointRatio < this.relayPointRatio && this.relayPointRatio < this.endPointRatio) {
        vertex(this.relayPointPosition.x, this.relayPointPosition.y);
      }
      vertex(this.endPointPosition.x, this.endPointPosition.y);
      endShape();
      //} else {
      //  noStroke();
      //  fill(this.displayColor);
      //ellipse(this.position.x, this.position.y, this.displaySize, this.displaySize);
    }
  }

  float getMoveProgressRatio() {
    return min(1, this.currentMoveFrameCount / this.moveDurationFrameCount);
  }

  float getStartPointRatio() {
    return -(pow(this.getMoveProgressRatio() - 1, 2)) + 1;
  }

  float getEndPointRatio() {
    return -(pow(this.getMoveProgressRatio() - 1, 4)) + 1;
  }

  float getDistance(float x, float y) {
    return dist(x, y, this.position.x, this.position.y);
  }
}

Dot createRandomDot() {
  Dot newDot = new Dot();
  newDot.position = new PVector(random(width), random(height));
  newDot.displaySize = 4 * width / 640;
  newDot.displayColor = createRandomColor(50, 100);
  return newDot;
};

color createRandomColor(float saturationValue, float brightnessValue) {
  //color newColor;

  return color(random(50, 200));
};

void processDotsAway(float effectiveRadius, float probability) {
  Dot eachDot;
  int i, len;
  for (i = 0, len = dotArray.length; i < len; i++) {
    eachDot = dotArray[i];
    if (eachDot.isMoving) {
      continue;
    }
    if (!(random(1) < probability)) {
      continue;
    }
    awayFromMouse(eachDot, effectiveRadius);
  }
}

void processDotsTo(float effectiveRadius, float probability) {
  Dot eachDot;
  int i, len;
  for (i = 0, len = dotArray.length; i < len; i++) {
    eachDot = dotArray[i];
    if (eachDot.isMoving) {
      continue;
    }
    if (!(random(1) < probability)) {
      continue;
    }
    attractToMouse(eachDot, effectiveRadius);
  }
}

void awayFromMouse(Dot dot, float effectiveRadius) {
  if (!(dot.getDistance(mouseX, mouseY) < effectiveRadius)) {
    return;
  }
  dot.setTarget(random(width), random(height/2, height));
}

void attractToMouse(Dot dot, float effectiveRadius) {
  float angle, distance, x, y;
  distance = random(1) * effectiveRadius;
  angle = random(1) * TWO_PI;
  x = mouseX + distance * cos(angle);
  if (x < 0) {
    x = -x;
  } else if (x > width) {
    x = width - (x - width);
  }
  y = mouseY + distance * sin(angle);
  if (y < height/2) {
    //y = -y;
    y = height/2 + (height/2 - y);
  } else if (y > height) {
    y = height - (y - height);
  }
  dot.setTarget(x, y);
}

void initDots(int num) {
  dotArray = new Dot[num];
  for (int i = 0; i < dotArray.length; i++) {
    dotArray[i] = createRandomDot();
  }
  effectiveRadius = 0.25 * width;
}

void displayDots() {
  Dot eachDot;
  blendMode(BLEND);
  //background(0, 0, 40);
  blendMode(SCREEN);
  for (int i = 0; i < dotArray.length; i++) {
    eachDot = dotArray[i];
    eachDot.update();
    eachDot.display();
  }
  if (awayDots) {
    processDotsAway(effectiveRadius, 1);
    processDotsAway(effectiveRadius, 0.001);
  } else {
    processDotsTo(effectiveRadius, 0.1);
  }
}

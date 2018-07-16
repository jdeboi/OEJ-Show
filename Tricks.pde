
boolean personOnPlatform = false;

int mxW = 100;

void changePlatform() {
  personOnPlatform = !personOnPlatform;
  sphereScreen.drawSolid(0);
}

float getFractalTreeAngle() {
  //(mouseX / (float) s.width) * 90f;
  return constrain(map(mouseX, width/2 - mxW, width/2 + mxW,  -PI/3, PI/3),  -PI/3, PI/3);
}
float getRotHandsDelta() {
  return constrain(map(mouseX, width/2 - mxW, width/2 + mxW,  -PI/6, PI/6),  -PI/6, PI/6);
}

PVector getBoidLocation() {
  return new PVector(map(mouseX, 0, width, 0, screenW*4), constrain(map(mouseY, height/2, height, 0, screenH), 0, screenH));
}

//////////////////////////////////////////////////////////////////////////////////
// CRUSH Z
//////////////////////////////////////////////////////////////////////////////////
int getZCrushHand() {
  return int(constrain(map(mouseX, width/2 - mxW, width/2 + mxW, 0, -800), -800, 0));
}

// an old idea
void pinkTint() {
    //int index = constrain(int(mouseX*1.0/width*4), 0, 3);
    //display4FaceLines(pink, index);
    //PGraphics s = screens[index].s;
    //s.beginDraw();
    //s.fill(pink, 50);
    //s.blendMode(SCREEN);
    //s.noStroke();
    //s.rect(0, 0, s.width, s.height);
    //s.endDraw();
}
//////////////////////////////////////////////////////////////////////////////////
// DIRTY LINES
//////////////////////////////////////////////////////////////////////////////////
void drawVertDirtyOutsideHand() {
  float lr = constrain(map(mouseX, width/2 - mxW, width/2 + mxW, -1, 1), -1, 1);
  drawVertDirtyOutsideSpeed(lr);
}

//////////////////////////////////////////////////////////////////////////////////
// MOTH FLAP
//////////////////////////////////////////////////////////////////////////////////
PImage body, left, right;
PImage [] handEyeClosing;
void initMoth() {
  body = loadImage("images/constellations/mothbody.png");
  left = loadImage("images/constellations/mothleft.png");
  right = loadImage("images/constellations/mothright.png");
  body.resize(screenW, screenW);
  left.resize(screenW, screenW);
  right.resize(screenW, screenW);
  constellations[4].resize(int(constellations[4].width * .5), int(constellations[4].height*.5));

  handEyeClosing = new PImage[3];
  handEyeClosing[0] = loadImage("images/constellations/closing1.png");
  handEyeClosing[1] = loadImage("images/constellations/closing2.png");
  handEyeClosing[2] = loadImage("images/constellations/closing3.png");

  constellations[0].resize(int(constellations[0].width * .25), int(constellations[0].height*.25));
  handEyeClosing[0].resize(int(handEyeClosing[0].width * .25), int(handEyeClosing[0].height*.25));
  handEyeClosing[1].resize(int(handEyeClosing[1].width * .25), int(handEyeClosing[1].height*.25));
  handEyeClosing[2].resize(int(handEyeClosing[2].width * .25), int(handEyeClosing[2].height*.25));
}

void displayHandEyeAcrossAll(float per) {
  updateNodeConstellation(screens[0].s, screenH);
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    displayNodeConstellation(s);
    displayHandEye(s, i, per);
    s.endDraw();
  }
}

boolean eyeBlinking = false;
int eyeMode = -1;
int lastEyeCheck = 0;
void displayHandEye(PGraphics s, int screenNum, float per) {
  float totalW = screenW*4 + constellations[0].width;
  float pixelsPastGo = totalW*per;
  int pixelsOnScreen = int(pixelsPastGo - screenNum*screenW);
  s.pushMatrix();
  int y = int(s.height/2 - constellations[0].height/2 + 30*sin(millis()/1000.0));
  s.image(constellations[0], pixelsOnScreen, y); 

  if (millis()/1000%4 == 0) {
    eyeBlinking = true;
    eyeMode = -1;
    lastEyeCheck = millis();
  }
  if (eyeBlinking) {
    if (eyeMode > -1) {
      if (eyeMode <= 2) {
        s.image(handEyeClosing[eyeMode], pixelsOnScreen, y);
      } else {
        s.image(handEyeClosing[4-eyeMode], pixelsOnScreen, y);
      }
    }
    if (millis() - lastEyeCheck > 50) {
      lastEyeCheck = millis();
      eyeMode++;
      if (eyeMode > 4) {
        eyeBlinking = false;
      }
    }
  }
  s.popMatrix();
}

void displaySwimWhaleAcrossAll(float per) {
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    displaySwimWhale(s, i, per);
    s.endDraw();
  }
}

void displaySwimWhale(PGraphics s, int screenNum, float per) {

  PImage whale = constellations[4];
  //int h = s.height/2;
  //float w = (1.0* s.height/h*s.width);
  float totalW = screenW*4 + whale.width;
  float pixelsPastGo = totalW*per;
  int pixelsOnScreen = int(pixelsPastGo - screenNum*screenW);
  s.pushMatrix();
  s.scale(-1, 1.0);
  int y = int(s.height/2 - whale.height/2 + 50*sin(millis()/700.0));
  s.image(whale, -pixelsOnScreen, y); //, w, h);
  s.popMatrix();
}

void displaySarahMothFlap() {
  updateNodeConstellation(screens[0].s, screenH);
  float per = constrain(map(mouseY, height*3.0/4, height, 0, 0.5), 0, .5);
  PGraphics s = screens[1].s;
  s.beginDraw();
  s.background(0);
  displayNodeConstellation(s);
  displayMothFlap(s, s.width/2, 0, per);
  s.endDraw();

  s = screens[2].s;
  s.beginDraw();
  s.background(0);
  displayNodeConstellation(s);
  displayMothFlap(s, -s.width/2, 0, per);
  s.endDraw();

  for (int i = 0; i < 4; i+=3) {
    s = screens[i].s;
    s.beginDraw();
    s.background(0);
    displayNodeConstellation(s);
    s.endDraw();
  }
}

void displayMothFlyAcross(float per) {
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    displayMothFly(s, i, per);
    s.endDraw();
  }
}

void displayMothFly(PGraphics s, int screenNum, float per) {
  //int h = s.height/2;
  //float w = (1.0* s.height/h*s.width);
  float totalW = screenW*4 + body.width;
  float pixelsPastGo = totalW*per;
  int pixelsOnScreen = int(pixelsPastGo - screenNum*screenW);

  s.pushMatrix();
  //s.translate(s.width/2, s.height/2);
  //s.rotateZ(radians(30));
  //s.translate(-s.width/2, -s.height/2);
  //s.scale(-1, 1.0);
  displayMothFlap(s, pixelsOnScreen, 0, 0.5+0.5*sin(millis()/300.0));
  s.popMatrix();
}

void displayMothFlap(PGraphics s, int x, int y, float per) {
  per *= 2;
  int maxAngle = 55;
  if (per < 1) per = map(per, 0, 1, 0, radians(maxAngle));
  else per = constrain(map(per, 1, 2, radians(maxAngle), 0), 0, maxAngle) ;

  s.pushMatrix();
  s.translate(x, y);
  s.blendMode(LIGHTEST);
  s.image(body, 0, 0);
  s.noStroke();
  s.textureMode(NORMAL);


  s.pushMatrix();
  s.translate(s.width/2, 0);
  s.rotateY(per);
  s.translate(-s.width/2, 0);
  s.beginShape();
  s.texture(left);
  s.vertex(0, 0, 0, 0);
  s.vertex(s.width, 0, 1, 0);
  s.vertex(s.width, s.height, 1, 1);
  s.vertex(0, s.height, 0, 1);
  s.endShape();
  s.popMatrix();

  s.pushMatrix();
  s.translate(s.width/2, 0);
  s.rotateY(-per);
  s.translate(-s.width/2, 0);
  s.beginShape();
  s.texture(right);
  s.vertex(0, 0, 0, 0);
  s.vertex(s.width, 0, 1, 0);
  s.vertex(s.width, s.height, 1, 1);
  s.vertex(0, s.height, 0, 1);
  s.endShape();
  s.popMatrix();
  s.popMatrix();
}

//void displayMothFlapHand(PGraphics s) {
//  float per = constrain(map(mouseY, height/2 - 200, height/2 + 200, .5, 0), 0, .5);
//  s.beginDraw();
//  s.background(0);
//  displayMothFlap(s, per);
//  s.endDraw();
//}


//////////////////////////////////////////////////////////////////////////////////
// CRUSH SPHERE
//////////////////////////////////////////////////////////////////////////////////
void updateSphereBoxHand() {
  float rot = map(mouseX, width/2 - mxW, width/2 + mxW, -PI, PI);
  sphereBoxRot.set(0, rot, 0);
}

void crushSphere(int z) {
  updateSphereBoxHand();
  for (int i = 1; i < 3; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    if (i == 1) {
      s.pushMatrix();
      s.scale(-1.0, 1.0);
      s.translate(-screenW, 0, 0);
      displaySphereBox(s, z);
      s.popMatrix();
    } else {
      //s.background(pink);
      displaySphereBox(s, z);
    }
    s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// WAVE HANDS
//////////////////////////////////////////////////////////////////////////////////
void drawWaveHands() {
  //float rot = constrain(map(mouseX, width/2 -mxW, width/2 + mxW, -PI/2, 0), -PI/2, 0);
  float rot = constrain(map(mouseX, width/2 -mxW, width/2 + mxW, -PI/2, PI/2), -PI/2, PI/2);

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

void drawConstBright() {
  updateNodeConstellation(screens[0].s, screenH);
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(BLEND);
    displayNodeConstellation(s);
    drawConstBrightImageHand(s, i, screenW);


    s.blendMode(BLEND);
    s.endDraw();
  }
}

void drawConstBrightImageHand(PGraphics s, int screenNum, int w) {
  updateNodeConstellation(screens[0].s, screenH);
  float lr = constrain(map(mouseX, width/2 - mxW, width/2 + mxW, -1, 1), -1, 1);
  s.noStroke();
  drawImageCenteredMaxFit(s, constellations[screenNum]);
  s.blendMode(SUBTRACT);
  float dis = 0;
  if (screenNum == 0) dis = abs(lr + 1);
  else if (screenNum == 1) dis = abs(lr + .5);
  else if (screenNum == 2) dis = abs(lr - .5);
  else if (screenNum == 3) dis = abs(lr - 1);
  s.fill(map(dis, 0, .5, 0, 255));
  s.rect(0, 0, s.width, s.height);
}

void drawConstLRHand() {
  updateNodeConstellation(screens[0].s, screenH);
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(BLEND);
    displayNodeConstellation(s);
    drawConstLeftRightSmoothImageHand(s, i, screenW);
    s.endDraw();
  }
}

void drawConstLeftRightSmoothImageHand(PGraphics s, int screenNum, int w) {
  int padding = 50;
  int lr = constrain(int((map(mouseX, width/2 - mxW, width/2 + mxW, padding, 4*screenW-w-padding))), padding, 4*screenW-w-padding);
  drawImageMaxFit(s, constellations[currentCycle/4%4], lr - screenW * screenNum);
}

void updateNodeConstellationMainHand() {
  float per = constrain(map(mouseX, width/2 - mxW, width/2 + mxW, -1, 1), -1, 1);
  int minY = maskPoints[keystoneNum][0].y;
  int maxY = maskPoints[keystoneNum][9].y + 50;
  for (int i=0; i<nodes.length; i++) {
    nodes[i].moveHand(minY, maxY, per);
  }
}

//////////////////////////////////////////////////////////////////////////////////
// SYMBOLS IMAGE
//////////////////////////////////////////////////////////////////////////////////


void drawSymbolsLeftRightImageHand(PGraphics s, int screenNum, int w) {
  if (personOnPlatform) {
    int lr = constrain(int((map(mouseX, width/2 - mxW, width/2 + mxW, 0, 4))), 0, 3);
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
    int lr = constrain(int((map(mouseX, width/2 - mxW, width/2 + mxW, padding, 4*screenW-w-padding))), padding, 4*screenW-w-padding);
    // maskPoints[keystoneNum][0].x + 50;

    int h = int(w * 1.0 /symbols[screenNum].width * symbols[screenNum].height);
    s.image(symbols[currentCycle%4], lr - screenW * screenNum, s.height/2 - h/2, w, h);
  }
}

//////////////////// the big constellations
void moveConstellationLinesHand() {
  float per = constrain(map(mouseX, width/2 - mxW, width/2 + mxW, -1, 1), -1, 1);
  for (int i = 0; i < constellationLines.length; i++) {
    constellationLines[i].move(per*7);
  }
}


void drawConstellationLinesHand() {
  moveConstellationLinesHand();
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    drawConstellationLines(s, i);
    s.endDraw();
  }
}

///////////////// network, baby constellations
void updateNodeConstellationHand() {
  float per = constrain(map(mouseX, width/2 - mxW, width/2 + mxW, -1, 1), -1, 1);
  for (int i=0; i<nodes.length; i++) {
    nodes[i].moveHand(per);
  }
}

//////////////////////////////////////////////////////////////////////////////////
// EYE
//////////////////////////////////////////////////////////////////////////////////
PImage iris;
PShape eyeball;
void initEye() {
  iris = loadImage("images/iris.png");
  noStroke();
  eyeball = createShape(SPHERE, sphereScreen.s.width*.43); 
  eyeball.setTexture(iris);
}

void drawEye() {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.background(0);
  s.translate(s.width/2, s.height/2);
  s.rotateX(constrain(map(mouseY, height, height/2, -PI/5, PI/4), -PI/5, PI/4));
  s.rotateY(constrain(map(mouseX, width/2 - 100, width/2 + 100, PI/3.5, PI/1.5), PI/3.5, PI/1.5));
  s.shape(eyeball);
  s.endDraw();
}
//GShader shader;
//int idxShader = -1;

//void initEye() {
//  shader = new GShader("shaders/eye.glsl");
//  shader.addParameter("mouse", 0, width, 0, height);
//}

//void drawEye() { 
//  int x = constrain(int(map(mouseX, width/2-mxW, width/2+mxW, 0, 600)), 0, 500);
//  int y = constrain(int(map(mouseY, height/2, height, 0, height/2)), 0, 500);
//  setEyePos(x, y);
//  shader.setShaderParameters();

//  PGraphics s = sphereScreen.s;
//  s.beginDraw();
//  //if (millis()%8000 < 100) {
//  //  s.background(0);
//  //} else {
//  s.shader(shader.shader);
//  s.rect(0, 0, s.width, s.height);
//  //}
//  s.endDraw();

//  //fill(0);
//  //image(pg, 0, 0);
//}

//void setEyePos(int x, int y) {
//  for (Param p : shader.parameters) {  
//    if (p.name.equals("mouse")) {
//      float[] pts = {x, y};
//      p.set( pts );
//      return;
//    }
//  }
//}

//class Param 
//{
//  String name;
//  float value;
//  PVector value2;
//  float minValue, maxValue;
//  PVector minValue2, maxValue2;
//  boolean is2d;

//  Param(String name, float minValue, float maxValue) {
//    this.name = name;
//    this.minValue = minValue;
//    this.maxValue = maxValue;
//    this.value = 0.5 * (minValue + maxValue);
//    is2d = false;
//  }

//  Param(String name, float minValue1, float maxValue1, float minValue2, float maxValue2) {
//    this.name = name;
//    this.minValue2 = new PVector(minValue1, minValue2);
//    this.maxValue2 = new PVector(maxValue1, maxValue2);
//    this.value2 = new PVector(0.5 * (this.minValue2.x + this.maxValue2.x), 
//      0.5 * (this.minValue2.y + this.maxValue2.y) );
//    is2d = true;
//  }

//  void set(float value) {
//    this.value = value;
//  }

//  void set(float[] value) {
//    this.value2.set(value[0], value[1]);
//  }
//}

//class GShader
//{
//  String path;
//  PShader shader;
//  ArrayList<Param> parameters;

//  GShader(String path) {
//    this.path = path;
//    shader = loadShader(path);
//    parameters = new ArrayList<Param>();
//  }

//  void addParameter(String name, float minVal, float maxVal) {
//    Param param = new Param(name, minVal, maxVal);
//    parameters.add(param);
//  }

//  void addParameter(String name, float minVal1, float maxVal1, float minVal2, float maxVal2) {
//    Param param = new Param(name, minVal1, maxVal1, minVal2, maxVal2);
//    parameters.add(param);
//  }

//  void setShaderParameters() {
//    PGraphics s = sphereScreen.s;
//    shader.set("time", (float) millis()/1000.0);
//    shader.set("resolution", float(s.width), float(s.height));
//    for (Param p : parameters) {
//      if (p.is2d) {
//        shader.set(p.name, p.value2.x, p.value2.y);
//      } else {
//        shader.set(p.name, p.value);
//      }
//    }
//  }
//}

////////////////////////////////////////////////////////////////////////////////
void handsHorizFaceLines(color c) {
  int face = constrain(int(map(mouseX, width/2-mxW, width/2+mxW, 0, 4)), 0, 3);
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


import deadpixel.keystone.*;  // to modify keystone lib and then make a jar file: jar cvf keystone.jar .

//////
// projector is 1920 x 1080
// to figure out pixel height of cube => 1080 * (7'/12.5') = 604.5
// so max pixels of cube will be 600 high (and since it's a cube, 600 wide), so 600 x 600 pixels
// so the biggest video resolution if you split the video across two screens will be 1200 x 600,  which close to the common resolution 1280x720
// unless you wanted it to spread across all 4, and then it's 1920x1080, but you'll have to crop out 1/2 of the video height

// conclusion: max video resolution can be is 1280x720
// reducing some, like to 920x540, will save some processing
int screenW = 400;
int screenH = 400;

int sphereW = 400;
int topScreenW = 350;
int topScreenH = 200;
//////
Keystone ks;
Keystone ksC;
int keystoneNum = 0;
CornerPinSurface [] surfaces;
CornerPinSurface [] topSurfaces;
CornerPinSurface centerSurface;
CornerPinSurface sphereSurface;
Screen [] screens;
Screen [] topScreens;
Screen centerScreen;
Screen sphereScreen;
boolean useCenterScreen = true;
int numScreens = 4;
int centerX, centerY;
boolean editingMapping = false;
int numMappings = 2;

class Screen {

  PGraphics s;
  int snakeLoc;
  
  int zIndex = 0;
  //Tesseract tesseract;

  Screen(int w, int h, int z) {
    s = createGraphics(w, h, P3D);
    snakeLoc = int(random(0, w*2 + h*2));
    zIndex = z;
  }

  void blackOut() {
    s.beginDraw();
    s.background(0);
    s.endDraw();
  }

  void drawSolid(color c) {
    s.beginDraw();
    s.background(c);
    s.endDraw();
  }

  void drawGif(Gif g, int x, int y, int w, int h) {
    s.beginDraw();
    s.image(g, x, y, w, h);
    s.endDraw();
  }

  void drawImage(PImage img, int x, int y) {
    s.beginDraw();
    s.blendMode(BLEND);
    s.background(0);
    s.image(img, x, y);
    s.endDraw();
  }

  void drawBlend(PImage img1, PImage img2, int x, int y, int mode) {
    s.beginDraw();
    s.image(img1, x, y);
    s.blend(img2, x, y, screenW, screenH, x, y, screenW, screenH, mode);
    s.endDraw();
  }

  void drawImageMirror(PImage img, int x, int y) {
    s.beginDraw();
    s.pushMatrix();
    s.scale(-1.0, 1.0);
    s.image(img, -screenW+x, y);
    s.popMatrix();
    s.endDraw();
  }

  void drawFFTBars() {
    s.beginDraw();
    s.background(0);
    float rectW = screenW / beat.detectSize();
    for (int i = 0; i < beat.detectSize(); ++i) {    
      if ( beat.isOnset(i) ) {  // test one frequency band for an onset
        s.fill(200);
        s.rect( i*rectW, 0, rectW, screenH);
      }
    }
    int lowBand = 5;
    int highBand = 15;
    int numberOfOnsetsThreshold = 4; // at least this many bands must have an onset for isRange to return true 
    if ( beat.isRange(lowBand, highBand, numberOfOnsetsThreshold) ) {
      s.fill(232, 0, 2, 200);
      s.rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, screenH);
    }
    s.endDraw();
  }

  void drawImage(PImage img, int x, int y, int w, int h) {
    s.beginDraw();
    s.blendMode(BLEND);
    s.background(0);
    s.image(img, x, y, w, h);
    s.endDraw();
  }

  void drawTriangle(color c, int sw, int x, int y, int sz) {
    s.beginDraw();
    s.strokeWeight(sw);
    s.stroke(c);
    s.noFill();
    float alt = sz*sqrt(3)/2.0;
    s.triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2); //50, 50, 100, 10, 150, 50);
    s.endDraw();
  }

  void drawFadeAlpha(int alpha) {
    s.beginDraw();
    s.blendMode(BLEND);
    s.noStroke();
    s.fill(0, alpha);
    s.rect(0, 0, s.width, s.height);
    s.endDraw();
  }

  void outlineScreen(color c, int sw) {
    s.beginDraw();
    s.noFill();
    s.strokeWeight(sw);
    s.stroke(c);
    s.rect(0, 0, screenW, screenH);
    s.endDraw();
  }

  void snakeOutline(color c, int sw, int sLen, int speed) {
    s.beginDraw();
    s.noFill();
    s.strokeWeight(sw);
    s.stroke(c);
    int maxSnake = screenW*2 + screenH*2;
    snakeLoc += speed;
    if (snakeLoc > maxSnake) snakeLoc = 0;

    // going clockwise starting from top left corner
    if (snakeLoc < screenW) {
      int sLoc = snakeLoc;
      if (sLoc > sLen) s.line(sLoc - sLen, 0, sLoc, 0);
      else {
        s.line(0, 0, sLoc, 0);
        s.line(0, sLen - sLoc, 0, 0);
      }
    } else if (snakeLoc < screenW + screenH) {
      int sLoc = snakeLoc - screenW;
      if (sLoc > sLen) s.line(screenW, sLoc - sLen, screenW, sLoc);
      else {
        s.line(screenW - (sLen-sLoc), 0, screenW, 0);
        s.line(screenW, 0, screenW, sLoc);
      }
    } else if (snakeLoc < screenW*2 + screenH) {
      int sLoc = snakeLoc - screenW - screenH;
      if (sLoc > sLen) s.line(screenW - sLoc, screenH, screenW - sLoc + sLen, screenH);
      else {
        s.line(screenW, screenH, screenW - sLoc, screenH);
        s.line(screenW, screenH - sLen + sLoc, screenW, screenH);
      }
    } else {
      int sLoc = snakeLoc - 2*screenW - screenH;
      if (sLoc > sLen) s.line(0, screenH - sLoc, 0, screenH - sLoc + sLen);
      else {
        s.line(0, screenH, 0, screenH - sLoc);
        s.line(sLen - sLoc, screenH, 0, screenH);
      }
    }
    s.endDraw();
  }
}

void blackoutScreens() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].blackOut();
  }
  for (int i = 0; i < 2; i++) {
    topScreens[i].blackOut();
  }
  sphereScreen.blackOut();
  centerScreen.blackOut();
}

void drawSolidTop(color c) {
  for (Screen ts : topScreens) {
    ts.drawSolid(c);
  }
}

void drawSolidAllCubes(color c) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawSolid(c);
  }
}

void drawSolidAll(color c) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawSolid(c);
  }
  for (int i = 0; i < 2; i++) {
    topScreens[i].drawSolid(c);
  }
  centerScreen.drawSolid(c);
  sphereScreen.drawSolid(c);
}


void snakeOutlineAll(color c, int sw, int sLen, int speed) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].snakeOutline(c, sw, sLen, speed);
  }
}

void drawOutlineAll(color c, int sw) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].outlineScreen(c, sw);
  }
}

void drawImageAll(PImage img, int x, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, x, y);
  }
}

void drawImageAll(PImage img, int x, int y, int w, int h) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, x, y, w, h);
  }
}

void drawGifAll(Gif g, int x, int y, int w, int h) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawGif(g, x, y, w, h);
  }
}

void drawImageAcross(PImage img, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, -i*screenW, y, screenW*4, img.height*screenW*4/img.width);
  }
}

void drawGifAcross(Gif g, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawGif(g, -i*screenW, y, screenW*4, g.height*screenW*4/g.width);
  }
}




void initScreens() {
  ks = new Keystone(this);

  surfaces = new CornerPinSurface[numScreens];
  screens = new Screen[numScreens];
  for (int i = 0; i < numScreens; i++) {
    surfaces[i] = ks.createCornerPinSurface(screenW, screenH, 20);
    screens[i] = new Screen(screenW, screenH, -1);
  }

  topSurfaces = new CornerPinSurface[2];
  topScreens = new Screen[2];
  for (int i = 0; i < 2; i++) {
    topSurfaces[i] = ks.createCornerPinSurface(topScreenW, topScreenH, 20);
    topScreens[i] = new Screen(topScreenW, topScreenH, 1);
  } 

  if (useCenterScreen) {
    centerSurface = ks.createCornerPinSurface(screenW*4, screenH, 20);
    centerScreen = new Screen(screenW*4, screenH, -2);
  }

  sphereSurface = ks.createCornerPinSurface(sphereW, sphereW, 20);
  sphereScreen = new Screen(sphereW, sphereW, 1);


  loadKeystone(0);
}

void saveKeystone() {
  if (useTestKeystone) ks.save("data/keystone/testEnv/keystoneCenter" + keystoneNum + ".xml");
  else ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
}
void loadKeystone(int i) {
  keystoneNum = i;
  if (useTestKeystone) ks.load("data/keystone/testEnv/keystoneCenter" +  i + ".xml");
  else ks.load("data/keystone/keystoneCenter" +  i + ".xml");
}

void renderScreens() {
  // screens below mask


  for (int i = 0; i < numScreens; i++) {
    pushMatrix();
    translate(0, 0, screens[i].zIndex);
    surfaces[i].render(screens[i].s);
    popMatrix();
  }

  pushMatrix();
  translate(0, 0, centerScreen.zIndex);
  centerSurface.render(centerScreen.s);
  popMatrix();

  // screens above mask
  pushMatrix();
  translate(0, 0, topScreens[0].zIndex);
  for (int i = 0; i < 2; i++) {
    topSurfaces[i].render(topScreens[i].s);
  }

  sphereSurface.render(sphereScreen.s);

  popMatrix();
}

void numberScreens() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].s.beginDraw();
    screens[i].s.fill(255);
    screens[i].s.noStroke();
    screens[i].s.textSize(50);
    screens[i].s.text(i, 50, 50);
    screens[i].s.endDraw();
  }
}

void circleSphere() {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.fill(255, 0, 0);
  s.ellipse(s.width/2, s.height/2, s.width, s.width);
  s.endDraw();
}

void sphereImage(PImage p) {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.image(p, 0, 0, s.width, s.width);
  s.endDraw();
}

void drawSolidCenter(color c) {
  centerScreen.drawSolid(c);
}
void drawSolidOuter(color c) {
  screens[0].drawSolid(c);
  screens[3].drawSolid(c);
}

void drawSolidInner(color c) {
  screens[1].drawSolid(c);
  screens[2].drawSolid(c);
}

void centerScreenFrontInner() {
  centerScreen.zIndex = -2;
  screens[0].zIndex = -1;
  screens[1].zIndex = -3;
  screens[2].zIndex = -3;
  screens[3].zIndex = -1;

  drawSolidAll(color(0));
}

void centerScreenFrontAll() {
  centerScreen.zIndex = -1;
  for (Screen s : screens) {
    s.zIndex = -2;
  }
  drawSolidInner(color(0));
}

void cubesFront() {
  centerScreen.zIndex = -2;
  for (Screen s : screens) { 
    s.zIndex = -1;
  }
  drawSolidCenter(color(0));
}

void innerScreensOut() {
  cubesFront();
  screens[1].blackOut();
  screens[2].blackOut();
}

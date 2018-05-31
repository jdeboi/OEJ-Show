
import deadpixel.keystone.*;
Keystone ks;
int numScreens = 4;
CornerPinSurface [] surfaces;
Screen [] screens;
int screenW = 400;
int screenH = 400;

class Screen {

  PGraphics s;
  int snakeLoc;

  Screen() {
    s = createGraphics(screenW, screenH, P3D);
    //snakeLoc = int(random(0, screenW*2 + screenH*2));
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
  
  void drawCN() {
    s.beginDraw();
    s.strokeWeight(1);
    s.stroke(255);
    drawCurvyNetwork(s);
    s.endDraw();
  }
  
  void drawImage(PImage img, int x, int y) {
    s.beginDraw();
    s.image(img, x, y);
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
    }
    else if (snakeLoc < screenW + screenH) {
      int sLoc = snakeLoc - screenW;
      if (sLoc > sLen) s.line(screenW, sLoc - sLen, screenW, sLoc);
      else {
        s.line(screenW - (sLen-sLoc), 0, screenW, 0);
        s.line(screenW, 0, screenW, sLoc);
      }
    }
    else if (snakeLoc < screenW*2 + screenH) {
      int sLoc = snakeLoc - screenW - screenH;
      if (sLoc > sLen) s.line(screenW - sLoc, screenH, screenW - sLoc + sLen, screenH);
      else {
        s.line(screenW, screenH, screenW - sLoc, screenH);
        s.line(screenW, screenH - sLen + sLoc, screenW, screenH);
      }
    }
    else  {
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
}

void drawSolidAll(color c) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawSolid(c);
  }
}

void drawCNAll() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawCN();
  }
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

void initScreens() {
  ks = new Keystone(this);
  surfaces = new CornerPinSurface[numScreens];
  screens = new Screen[numScreens];
  for (int i = 0; i < numScreens; i++) {
    surfaces[i] = ks.createCornerPinSurface(screenW, screenH, 20);
    screens[i] = new Screen();
  }
  ks.load();
}

void renderScreens() {
  for (int i = 0; i < numScreens; i++) {
    surfaces[i].render(screens[i].s);
  }
}

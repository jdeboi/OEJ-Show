/**
 * This is a simple example of how to use the Keystone library.
 *
 * To use this example in the real world, you need a projector
 * and a surface you want to project your Processing sketch onto.
 *
 * Simply drag the corners of the CornerPinSurface so that they
 * match the physical surface's corners. The result will be an
 * undistorted projection, regardless of projector position or 
 * orientation.
 *
 * You can also create more than one Surface object, and project
 * onto multiple flat surfaces using a single projector.
 *
 * This extra flexbility can comes at the sacrifice of more or 
 * less pixel resolution, depending on your projector and how
 * many surfaces you want to map. 
 */

import deadpixel.keystone.*;

Keystone ks;

int numScreens = 1;
CornerPinSurface [] surfaces;
PGraphics [] screens;
int screenW = 1600;
int screenH = 400;

void setup() {
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  size(1200, 800, P3D);

  ks = new Keystone(this);
  initScreens();
  //surface = ks.createCornerPinSurface(400, 300, 20);
  //surface2 = ks.createCornerPinSurface(400, 300, 20);
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  //offscreen = createGraphics(400, 300, P3D);
  //offscreen2 = createGraphics(400, 300, P3D);
}

void draw() {
  drawScreens();
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}

void initScreens() {
  surfaces = new CornerPinSurface[numScreens];
  screens = new PGraphics[numScreens];
  for(int i = 0; i < numScreens; i++) {
    surfaces[i] = ks.createCornerPinSurface(screenW, screenH, 20);
    screens[i] = createGraphics(screenW, screenH, P3D);
  }
}

void drawScreens() {
  for (int i = 0; i < surfaces.length; i++) {
    PVector surfaceMouse = surfaces[i].getTransformedMouse();
    screens[i].beginDraw();
    screens[i].background(255);
    screens[i].fill(0, 255, 0);
    screens[i].ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
    screens[i].ellipse(50, 100, 75, 75);
    screens[i].endDraw();
  }
  background(0);
  for (int i = 0; i < numScreens; i++) {
    surfaces[i].render(screens[i]);
  }
}

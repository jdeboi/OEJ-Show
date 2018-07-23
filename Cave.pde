OEJCave cave;
final int STARTUP_STROKE = 1;
final int RAINBOW_PULSE = 2;
final int RAINBOW_FILL = 3;
final int ICE = 4;
final int RANDOM = 5;
//final int GRAD = 6;
final int GRAD_ALL = 7;
final int GRAD1 = 8;
final int GRAD2 = 9;
//final int GRAD_ALL = 7;
//final int GRAD_PAIR1 = 8;
//final int GRAD_PAIR2 = 9;
final int CAST_LIGHT = 10;
final int CAST_LIGHT_SIDE = 11;
final int CAST_BLUE = 12;
//
final int START =-1;
final int DARK_PULSE = -2;
final int RAINBOW_STROKE = -6;
final int TESTING = -7;
final int SPACE_MTN = -8;

final int SPAWN = 1;
final int SPAWNING = 2;
final int BOUNCE = 3;
final int CRISSCROSS = 4;


class OEJCave {


  int STALAG = 0;
  int STALAC = 1;
  int STYLE1 = 0; // from corner
  int STYLE2 = 1; // from center
  ArrayList<Feature> features = new ArrayList();
  Grid [] grids;

  // light
  int lightStep = 0;
  int lightDir = 1;


  float translateX = 340, translateY, translateZ, rotX, rotY, rotZ, zoom, dx, dy, dz, rx, ry, rz;
  int lastX, lastY;

  // camera
  int groundPlane = 400;
  float eyeX, eyeY, eyeZ, centerXCave, centerYCave, centerZCave, upX, upY, upZ;

  //int step = 0;


  int maxBounce = 280;
  int maxCrisscross  = 100;

  boolean fadingToWhite = false;
  int rainbowDir = 30;
  int rainbowSpeed = 5;
  //////////////////////
  int [] colorSettings = {1, 1, 1, 1};
  int [] colorSettingIndexes = {0, 0, 0, 0};

  int SETUP_SHAPE = 1;
  int DRIP = 2;
  // yes
  // 0 is for resetting startup_stroke


  int masterSetting = 6;

  color [] lerpC;
  int spaceIndex = 0;
  int choiceIndex = 0;


  boolean zSet = false;
  boolean firstLine = true;
  boolean drawFirstLine = false;
  int cubeZ = -250;

  float zCamera = 0;
  float fov, aspect;

  boolean isMoving = false;
  boolean showPoints = false;

  boolean dripping = true;
  boolean neuralizing = false;
  boolean bouncing = true;

  // feature movement
  int featureMovementSetting = 0;
  int bounceIndex = 0;

  boolean randomLerp = true;
  boolean drawImage = false;
  boolean randomDance = true;

  int rainbowIndex = 0;

  //Timer minTimer, eightSecTimer, tenSecTimer;
  boolean tenSecEffect = false;
  boolean cycleSettings = false;

  OEJCave(PGraphics s) {
    defaultCamera(s);
    startLerpColors();
    setDigitalFeatures(s);
    initGrids(s);
  }

  void displayCaveLeftRightBounce() {
    if (currentCycle > previousCycle  || currentCue > previousCue) {
      if (currentCycle %2 == 0) {
        colorSettings[0] = GRAD1;
        colorSettings[1] = GRAD1;
        randomizeLerpColorsPair(0);
      } else {
        colorSettings[2] = GRAD2;
        colorSettings[3] = GRAD2;
        randomizeLerpColorsPair(1);
      }
    }
  }

  void displayCaveLeftRightBounceHand() {
    if (mouseX > width/2 && pmouseX <= width/2) {
      colorSettings[2] = GRAD2;
      colorSettings[3] = GRAD2;
      randomizeLerpColorsPair(1);
    } else if (mouseX < width/2 && pmouseX >= width/2) {
      colorSettings[0] = GRAD1;
      colorSettings[1] = GRAD1;
      randomizeLerpColorsPair(0);
    }
  }


  void displayCaveAllBounce() {
    if (currentCycle > previousCycle || currentCue > previousCue) changeGradAll();
  }

  void changeGradAll() {
    randomizeLerpColorsAllSame();
    for (int i = 0; i < 4; i++) {
      colorSettings[i] = GRAD_ALL;
    }
  }

  //void changeGradPair() {
  //  randomizeLerpColorsAllSame();
  //  for (int i = 0; i < 4; i++) {
  //    colorSettings[i] = GRAD;
  //  }
  //}

  void drawCaveScreens() {
    updateDrip();
    updateRandom();
    checkMovement();
    checkRainbow();

    drawCaveFlatGrid(0, screens[0].s);
    drawCave(1, screens[1].s);
    //drawCaveFlatGrid(2, screens[2].s);
    drawCave(2, screens[2].s);
    drawCaveFlatGrid(3, screens[3].s);
  }

  //void nextCaveColorSetting(int index) {
  //  if (currentCycle > previousCycle) {
  //    if (currentCycle % 4 == 0) advanceColorSetting(index);
  //  }
  //}

  //void nextCaveMoveSetting() {
  //  if (currentCycle > previousCycle) {
  //    if (currentCycle % 8 == 0) changeMovementSetting(int(random(5)));
  //  }
  //}

  void changeAllColorSettings(int mode) {
    for (int i = 0; i < 4; i++) {
      changeColorSetting(i, mode);
    }
  }

  void drawCaveFlatGrid(int screenNum, PGraphics s) {
    s.beginDraw();
    s.background(0);
    s.pushMatrix();
    s.translate(0, 0, 400);
    s.strokeWeight(1);
    s.stroke(255, 0, 255);
    s.fill(255);
    drawFeatures(screenNum, s);
    s.strokeWeight(1);
    s.stroke(0, 255, 255);
    s.fill(0);
    drawFlatCaveWalls(screenNum, s);
    s.popMatrix();
    s.endDraw();
  }


  void drawCave(int screenNum, PGraphics s) {
    s.beginDraw();
    s.background(0);
    s.ellipseMode(CENTER);

    //s.camera(eyeX, eyeY, eyeZ, centerXCave, centerYCave, centerZCave, upX, upY, upZ);
    //setLights(s);

    s.pushMatrix();
    //s.translate(s.width/2, s.height/2, 0);
    //s.rotateX(radians(rotX+rx));
    //s.rotateY(radians(rotY+ry));
    //s.rotateZ(radians(rotZ+rz));
    //s.translate(-s.width/2, -s.height/2, 400);
    s.translate(0, 0, 400);

    // draw features
    s.strokeWeight(1);
    s.stroke(255, 0, 255);
    s.fill(255);

    drawFeatures(screenNum, s);

    //// draw grids
    s.strokeWeight(1);
    //s.colorMode(RGB);
    //s.stroke(0, 255, 255);
    s.fill(0);
    drawGrids(screenNum, s);
    s.popMatrix();




    s.endDraw();
  }

  void updateDrip() {
    for (Feature f : features) {
      f.updateDrip();
    }
  }

  void checkMovement() {
    if (featureMovementSetting == BOUNCE) {
      bounceIndex++;
      if (bounceIndex >= maxBounce) {
        bounceIndex = 0;
        changeMovementSetting(0);
      }
    } else if (featureMovementSetting == CRISSCROSS) {
      bounceIndex++;
      if (bounceIndex > maxCrisscross) {
        bounceIndex = 0;
        changeMovementSetting(0);
      }
    }
  }

  void checkRainbow() {
    if (fadingToWhite) {
      if (rainbowIndex < -255) rainbowDir = rainbowSpeed;
      else if (rainbowIndex > 0) rainbowDir = -rainbowSpeed;
    } else {
      if (rainbowIndex < 0) rainbowDir = rainbowSpeed;
      else if (rainbowIndex > 255) rainbowDir=-rainbowSpeed;
    }
    rainbowIndex += rainbowDir;
  }



  void setDigitalFeatures(PGraphics s) {
    for (int i = 0; i < 15; i++) {
      s.fill(255);
      s.stroke(0, 255, 255);
      features.add(new Feature(s.width, s.height, STALAG));
      features.get(i*2).init();
      features.add(new Feature(s.width, s.height, STALAC));
      features.get(i*2+1).init();
    }
  }

  float getCentimeters(float ft, float in) {
    float total = ft * 12 + in;
    return total * 2.54;
  }

  //////////// DRAW ////////////////

  void drawFeatures(int index, PGraphics s) {
    for (int i = 0; i < features.size(); i++) {
      features.get(i).display(index, s);
    }
  }

  void drawFlatCaveWalls(int screenNum, PGraphics s) {
    grids[0].drawFlatCave(screenNum, s, true);
    grids[1].drawFlatCave(screenNum, s, false);
    grids[0].drawFlatCave(screenNum, s, false);
    grids[2].drawFlatCave(screenNum, s, false);
    grids[3].drawFlatCave(screenNum, s, false);
  }

  void drawGrids(int screenNum, PGraphics s) {
    for (int i = 0; i < grids.length; i++) {
      grids[i].display(screenNum, s);
    }
  }

  void cubeCave(PGraphics s, float w, float h, float d) {
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

  void initGrids(PGraphics s) {
    int gridMode = 0;
    grids = new Grid[4];
    grids[0] = new Grid(s.width*2, int(s.height*3.5), 25, -s.width/4, s.height, -450, -90, 0, 0, gridMode); // left floor
    grids[1] = new Grid(s.width*2, int(s.height*3.5), 25, -s.width/4, 0, -50, -90, 0, 0, 3);           //ceiling
    grids[2] = new Grid(s.width*3, s.height+150, 35, s.width*2, -100, 200, 0, 110, 0, 1);         // right
    grids[3] = new Grid(s.width*3, s.height+150, 35, 0, -100, 200, 0, 95, 0, 2);         // left
  }

  void setLights(PGraphics s) {
    s.colorMode(RGB, 255);
    s.ambientLight(255, 255, 255);
    lightStep += lightDir*25;
    if (lightStep > s.width*2) lightDir = -1;
    else if (lightStep < -s.width) lightDir = 1;

    pointLight(245, 245, 245, s.width/2+200, s.height/2, -500);
  }

  void defaultCamera(PGraphics s) {
    eyeX = s.width/2.0;
    eyeY = s.height/2.0;
    eyeZ = (s.height/2.0) / tan(PI*30.0 / 180.0);
    centerXCave = s.width/2.0;
    centerYCave = s.height/2.0;
    centerZCave = 0;
    upX = 0;
    upY = 1;
    upZ = 0;
  }

  //void drawCubeCave(PGraphics s) {
  //  pushMatrix();
  //  translate(s.width/2, s.height/2, 0);
  //  rotateY(radians(45));
  //  noFill();
  //  strokeWeight(3);
  //  stroke(255, 0, 255);
  //  cubeCave(s, s.width, s.height, s.width);
  //  popMatrix();
  //}

  color getBrightnessPixel(color p, int index, int max) {
    colorMode(RGB);
    float r = red   (p);
    float g = green (p);
    float b = blue  (p);

    float adjustBrightness = ((float) index / max);
    r *= adjustBrightness;
    g *= adjustBrightness;
    b *= adjustBrightness;
    // Constrain RGB to between 0-255
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    b = constrain(b, 0, 255);
    // Make a new color and set pixel in the window
    color c = color(r, g, b);
    return c;
  }

  color getRandomCaveColor() {
    colorMode(HSB, 255);
    //return color(random(120, 180), random(200, 255), random(30, 150));
    return(50);
  }

  void updateRandom() {
    for (int i = 0; i < features.size(); i++) {
      features.get(i).updateRandomHues();
    }
  }


  void changeColorSetting(int screenNum, int setting) {
    if (setting == STARTUP_STROKE) {
      if (int(random(2)) == 0) fadingToWhite = false;
      else fadingToWhite = true;
      rainbowIndex = -255;
    } 
    //else rainbowIndex = 0;

    drawImage = false;
    switch(setting) {
      //case GRAD_ALL:
      //  //randomizeLerpColorsAllSame();
      //  break;
      //case GRAD_PAIR1:
      //  //randomizeLerpColorsPair(0);
      //  break;
      //case GRAD_PAIR2:
      //setting = GRAD;
      //randomizeLerpColorsPair(1);
      //break;
    case START: 
      startLerpColors();
      break;
    case 0: 
      fadingToWhite = false;
      setting = STARTUP_STROKE;
      break;
    }
    colorSettings[screenNum] = setting;
  }

  boolean changeMovementSetting(int setting) {
    if (featureMovementSetting == 0) {
      featureMovementSetting = setting;
      return true;
    } else if (featureMovementSetting == BOUNCE || featureMovementSetting == CRISSCROSS) {
      if (bounceIndex == 0) {
        featureMovementSetting = setting;
        return true;
      }
      return false;
    } else if (featureMovementSetting == SPAWNING) {
      featureMovementSetting = SPAWN;
      return false;
    } else if (featureMovementSetting == SPAWN) {
      if (featuresStillMelting()) return false;
      else {
        featureMovementSetting = setting;
        return true;
      }
    }
    return false;
  }

  void advanceMovementSetting() {
    choiceIndex++;
    int [] choices = {BOUNCE, BOUNCE, 0, CRISSCROSS, 0};
    //int [] choices = {CRISSCROSS};
    if (choiceIndex >= choices.length) choiceIndex = 0;
    changeMovementSetting(choices[choiceIndex]);
  }

  void randomizeLerpColorsAllSame() {
    colorMode(HSB, 255);
    lerpC[0] = color(random(0, 255), 255, 255);
    lerpC[1] = color(random(0, 255), 255, 255);
    lerpC[2] = lerpC[0];
    lerpC[3] = lerpC[1];
  }

  color getLerpColorAllSame(int screenNum) {
    return lerpC[1];
  }

  color getLerpColorSides(int screenNum) {
    return lerpC[screenNum/2 + 1];
  }

  //color getSameLerp(int screenNum) {

  //  return

  void setCastLightStroke(PGraphics s, Feature feat, int screenNum, int i) {

    if (screenNum == 1 || screenNum == 2) {
      colorMode(HSB, 255);
      lerpC[0] = color(255);
      lerpC[1] = 0;
      lerpC[2] = lerpC[0];
      lerpC[3] = lerpC[1];
      s.stroke(0);
      s.fill(feat.getLerpColor(screenNum/2, i));
    } else {
      lerpC[0] = 0;
      lerpC[1] = 0;
      lerpC[2] = 0;
      lerpC[3] = 0;
      s.fill(0);
      s.stroke(0);
    }
  }

  void setCastLightSideStroke(PGraphics s, Feature feat, int screenNum, int i) {
    int brCol = getCaveHandSide();
    int spacing = 505;
    float x = feat.x;
    //if (screenNum == 1) {
    //  brCol = int(map(mouseY, height, height/2, -spacing, cols+spacing));
    //  int br = 0;
    //  if (i <= brCol)  br = constrain(int(map(i, brCol - spacing, brCol, 0, 255)), 0, 255);
    //  else if (i > brCol) br = constrain(int(map(i, brCol, brCol+spacing, 255, 0)), 0, 255);
    //  s.stroke(0, 0, br);
    //} else {
    brCol -= screenNum * width/4;
    int br = 0;
    if (x <= brCol)  br = constrain(int(map(x, brCol - spacing, brCol, 0, 355)), 0, 255);
    else if (x > brCol) br = constrain(int(map(x, brCol, brCol+spacing, 355, 0)), 0, 255);
    colorMode(HSB, 255);
    lerpC[0] = color(50, 255, br);
    lerpC[1] = color(0, 0, 0, 0);
    lerpC[2] = lerpC[0];
    lerpC[3] = lerpC[1];
    s.stroke(0);
    s.fill(feat.getLerpColor(screenNum/2, i));
  }

  // CAST_LIGHT CHANGE SCREEN NUM
  void lightGridTopBot(PGraphics s, int screenNum, int i, int cols) {
    int spacing = 15;
    if (screenNum == 1 || screenNum == 2) {
      int brCol = getCaveHandUpDown(spacing, cols);
      int br = 0;
      if (i <= brCol)  br = constrain(int(map(i, brCol - spacing, brCol, 0, 255)), 0, 255);
      else if (i > brCol) br = constrain(int(map(i, brCol, brCol+spacing, 255, 0)), 0, 255);
      s.stroke(0, 0, br);
    } else s.stroke(0);
    s.fill(0);
  }

  void lightGridTopBot(PGraphics s, int screenNum, int i, int cols, boolean isFlat) {
    s.noStroke();//stroke(255);
  }



  void lightGridSide(PGraphics s, int screenNum, int i, int cols) {
    s.noStroke();
    s.noFill();
    //int brCol = constrain(int(map(mouseX, width/2 - 200, width/2 + 200, 0, cols*4)), 0, cols*4);

    //int spacing = 60;

    //if (screenNum == 1) {
    //  brCol -= screenNum * cols;

    //  int br = 0;
    //  if (i <= brCol)  br = constrain(int(map(i, brCol - spacing, brCol, 0, 255)), 0, 255);
    //  else if (i > brCol) br = constrain(int(map(i, brCol, brCol+spacing, 255, 0)), 0, 255);
    //  s.stroke(0, 0, br);
    //} else {
    //  brCol -= screenNum * cols;
    //  int br = 0;
    //  if (i <= brCol)  br = constrain(int(map(i, brCol - spacing, brCol, 0, 255)), 0, 255);
    //  else if (i > brCol) br = constrain(int(map(i, brCol, brCol+spacing, 255, 0)), 0, 255);
    //  s.stroke(0, 0, br);
    //}
    //else {
    //  s.noStroke();
    //  s.noFill();
    //}
  }

  void randomizeLerpColorsPair(int pair) {
    colorMode(HSB, 255);
    lerpC[pair*2] = color(random(0, 255), 255, 255);
    lerpC[pair*2+1] = color(random(0, 255), 255, 255);
    colorMode(RGB, 255);
  }

  void startLerpColors() {
    colorMode(HSB, 255);
    lerpC = new color[4];
    lerpC[0] = color(15, 255, 255);
    lerpC[1] = color(175, 255, 255);
    lerpC[2] = color(15, 255, 255);
    lerpC[3] = color(175, 255, 255);
    colorMode(RGB, 255);
  }

  boolean featuresStillMelting() {
    for (int i = 0; i < features.size(); i++) {
      if (features.get(i).melting) return true;
    }
    return false;
  }

  class Feature {

    float x, y, z, base, featureH, ySpacing, radiusDec;
    int ySteps;
    int [] rectSizes;
    int lastCheck;
    int dripCount;
    float rot = radians(-45);
    int type = 0;
    int maxDrip = 120;
    int [] hues;
    int [] lerpColors;
    long lastUpdated;



    float bounceXIndex = 0;
    float bounceYIndex = 0;
    float bounceZIndex = 0;
    int bounceDirection = 0;



    float meltIndex = 0;
    boolean melting = false;
    int meltDirection = -1;
    long lastMeltCheck = 0;
    int wt, ht;

    Feature(int wt, int ht, int type, float x, float z, float base, float radiusDec, float ySpacing) {
      this.wt = wt;
      this.ht = ht;
      this.type = type;
      this.x = x;
      if (type == STALAG) this.y = ht;
      else this.y = 0;
      this.z = z;

      this.base = base;
      this.radiusDec = radiusDec;
      this.ySpacing = ySpacing;
      this.rectSizes = rectSizes;
      this.lastUpdated = millis();
    }

    Feature(int wt, int ht, int type) {
      this.type = type;
      z = random(-700, -500);
      //if (type == STALAG) z = random(-1000, -700);
      //else z = random(-800, -400);
      if (int(random(0, 2)) == 0 ) x = random (0, wt/4.0); // to the left
      else x = int(random (3*wt/4.0, wt)); // to the right
      //if (z < -400) {
      //  if (int(random(0, 2)) == 0 ) x = random (0, wt/3); // to the left
      //  else x = int(random (2*wt/3, wt)); // to the right
      //} else {
      //  float a = wt/4;
      //  float b = 1;
      //  float xt = map(z, 0, -3000, 0, 2*PI);
      //  if (int(random(0, 2)) == 0 ) x = random (wt/2-a*cos(b*xt)-wt, wt/2-a*cos(b*xt)-wt);
      //  else x = int(random (wt/2-a*cos(b*xt)+50, wt/2-a*cos(b*xt)+wt));
      //} 
      base = random(10, 80);
      radiusDec = random(3, 8);
      ySpacing = random(10, 20);
      if (type == STALAG) this.y = ht;
      else this.y = 0;
    }

    void init() {
      ySteps = int(base / radiusDec);
      featureH = ySpacing * ySteps;
      meltIndex = ySpacing;
      lastCheck = 0;
      dripCount = int(random(0, maxDrip));
      setRandomRectSizes();
      hues = new int[ySteps];
      updateRandomHues();
      bounceDirection = 1;
      if (int(random(2)) == 0) bounceDirection = -1;
    }

    void randomizePosition() {
      if (type == STALAG) z = random(-3500, -500);
      else z = random(-3500, -100);

      if (z > -800) {
        if (int(random(0, 2)) == 0 ) x = random (200, wt/3);
        else x = int(random (2*wt/3, wt-200));
      } else if (z > -1300) {
        float a = 250;
        float b = 1;
        float xt = map(z, 0, -3000, 0, 2*PI);
        if (int(random(0, 2)) == 0 ) x = random (wt/2-a*cos(b*xt)-1000, wt/2-a*cos(b*xt)-400);
        else x = int(random (wt/2-a*cos(b*xt)+50, wt/2-a*cos(b*xt)+600));
      } else {
        float a = 250;
        float b = 1;
        float xt = map(z, 0, -3000, 0, 2*PI);
        if (int(random(0, 2)) == 0 ) x = random (wt/2-a*cos(b*xt)-800, wt/2-a*cos(b*xt)-400);
        else x = int(random (wt/2-a*cos(b*xt)+50, wt/2-a*cos(b*xt)+400));
      }
      base = random(10, 80);
      radiusDec = random(3, 8);
      ySpacing = random(10, 20);
      ySteps = int(base / radiusDec);
      featureH = ySpacing * ySteps;
      meltIndex = 0;
      lastCheck = 0;
      dripCount = int(random(0, maxDrip));
      setRandomRectSizes();
      hues = new int[ySteps];
      updateRandomHues();
    }


    void updateRandomHues() {
      for (int i = 0; i < ySteps; i++) {
        hues[i] = int(random(0, 255));
      }
    }

    int getRainbowHue(int index) {
      return index * 13;
    }

    void setHues(int h) {
      for (int i = 0; i < ySteps; i++) {
        hues[i] = h;
      }
    }


    color getLerpColor(int pairNum, int index) {
      colorMode(RGB, 255);
      float m = map(index, ySteps, 0, 0, 1);
      return lerpColor(lerpC[pairNum*2], lerpC[pairNum*2+1], m);
    }



    void setGradientHues(int start, int end) {
      for (int i = 0; i < ySteps; i++) {
        hues[i] = int (map(i, 0, ySteps, start, end));
      }
    }

    void updateFeature() {
      //ySteps = base / radiusDec;
      featureH = ySpacing * ySteps;
    }

    void setColors(int screenNum, PGraphics s, int i) {
      s.colorMode(HSB, 255);
      switch(colorSettings[screenNum]) {
      case STARTUP_STROKE:
        setBlackFill(screenNum, s, i);
        if (personOnPlatform) gradientSetAllStrokePlatform(s, i, 125, 180, getCaveHand());
        else if (rainbowIndex < 0) gradientSetAllStrokeSat(s, i, 125, 180, 255+rainbowIndex);
        else gradientSetAllStroke(s, i, 125, 180);
        break;
      case CAST_LIGHT:
        setCastLightStroke(s, this, screenNum, i);
        break;
      case CAST_LIGHT_SIDE:
        setCastLightSideStroke(s, this, screenNum, i);
        break;
      case RAINBOW_PULSE:
        setBlackFill(screenNum, s, i);
        int h = int(map(z, -100, -3500, 0, 100));
        if (rainbowIndex < 0) {
          float sat;
          if (i > ySteps/2) sat = 0;
          else {
            if (ySteps/2 > 0) {
              float startSat = 255 + rainbowIndex;
              sat = map(i, 0, ySteps/2, startSat, 0);
            } else sat = 0;
          }
          s.stroke(h, sat, 225);
        } else if (h+rainbowIndex > 210) {
          float sat;
          if (i > ySteps/2) sat = 0;
          else {
            if (ySteps/2 > 0) {
              float startSat = map(h+rainbowIndex, 210, 510, 255, 0.001);
              sat = map(i, 0, ySteps/2, startSat, 0);
            } else sat = 0;
          }
          //stroke((h+rainbowIndex)%255, 255 - (rainbowIndex-210), 225);
          s.stroke((h+rainbowIndex)%255, sat, 225);
        } else {
          gradientStroke(s, i, (h+rainbowIndex)%255);
        }
        break;
      case RANDOM:
        if (randomDance) {
          if (int(random(500)) == 1) updateRandomHues();
        }
        s.stroke(0);
        s.fill(hues[i], 255, 155);
        break;
      case  RAINBOW_FILL:
        s.colorMode(HSB, 255);
        s.stroke(0);
        s.fill(getRainbowHue(i), 255, 255);
        break; 
      case GRAD_ALL:
        s.stroke(0);
        s.fill(getLerpColor(screenNum/2, i));
        break;
      case GRAD1:
        s.stroke(0);
        s.fill(getLerpColor(screenNum/2, i));
        break;
      case GRAD2:
        s.stroke(0);
        s.fill(getLerpColor(screenNum/2, i));
        break;
      case START:
        s.stroke(0);
        s.fill(getLerpColor(screenNum/2, i));
        break;
      case ICE:
        s.colorMode(RGB, 255);
        s.stroke(125, 255, 255);
        s.fill(0);
        break;
      default:
        s.fill(0);
        gradientSetAllStroke(s, i, 125, 180);
        break;
      }
      if (dripping) drip(screenNum, s, i);
    }

    void setBlackFill(int screenNum, PGraphics s, int index) {
      if (dripping) drip(screenNum, s, index);
      else s.fill(0);
    }

    void display(int screenNum, PGraphics s) {
      for (int i = 0; i < ySteps; i++ ) {
        setColors(screenNum, s, i);
        s.blendMode(BLEND);
        s.pushMatrix();

        //colorMode(HSB, 100);
        //fill(rainbowIndex/100, 100, 100);
        //rainbowIndex++;
        //if (rainbowIndex > 10000) rainbowIndex = 0;
        //getImageColors(i);


        if (type == STALAG) {

          if (featureMovementSetting == BOUNCE) s.translate(x+bounceXIndex, y - i*(ySpacing+bounceYIndex), z);
          else if (featureMovementSetting == CRISSCROSS) s.translate(x+bounceXIndex, y - i*ySpacing, z+bounceZIndex);
          else if (melting) s.translate(x, y - i*meltIndex, z);
          else s.translate(x, y - i*ySpacing, z);
          s.pushMatrix();
          s.rotateY(rot);

          cubeCave(s, base - radiusDec*i+rectSizes[i], ySpacing, base - radiusDec*i+rectSizes[i]);
          s.popMatrix();
        } else {
          if (featureMovementSetting == BOUNCE) s.translate(x+bounceXIndex, y + i*(ySpacing+bounceYIndex), z);
          else if (featureMovementSetting == CRISSCROSS) s.translate(x+bounceXIndex, y + i*ySpacing, z+bounceZIndex);
          else if (melting) s.translate(x, y + i*meltIndex, z);
          else s.translate(x, y + i*ySpacing, z);
          s.pushMatrix();
          s.rotateY(rot);
          cubeCave(s, base - radiusDec*i+rectSizes[i], ySpacing, base - radiusDec*i+rectSizes[i]);
          s.popMatrix();
        }

        s.popMatrix();
      }

      if (featureMovementSetting == BOUNCE) bounce();
      else if (featureMovementSetting == CRISSCROSS) crisscross(percentToNumBeats(8));
      else if (featureMovementSetting == SPAWNING) {
        if (int(random(500))==5) melting = true;
      }
      if (melting) {
        //if (millis() - lastMeltCheck > 100) {
        meltIndex+= meltDirection;
        lastMeltCheck = millis();
        if (meltIndex < 0) {
          randomizePosition();
          meltDirection = 1;
        } else if (meltIndex > ySpacing) {
          melting = false;
          meltDirection = -1;
        }
        //}
      }
    }

    //void bounce(float per) {
    //    per *= 4;
    //    int maxX = 100;
    //    int minX = -100;
    //    int maxZ = 100;
    //    int minZ = -100;
    //    //int maxBounce = 45; //70
    //    if (per < 1) {

    //      bounceXIndex = map(per, 0, 1, 0, -minX);
    //      bounceYIndex = map(per, 0, 1, 0, maxZ/2);
    //      //bounceXIndex -= bounceDirection;
    //      //bounceYIndex += abs(bounceDirection);
    //    } else if (per < 2) {
    //      //bounceXIndex += bounceDirection;
    //      //bounceYIndex += abs(bounceDirection);
    //      bounceXIndex = map(per, 1, 2, -minX, 0);
    //      bounceYIndex = map(per, 1, 2, maxZ/2, maxZ);
    //    } else if (per < 3) {
    //      //bounceXIndex;
    //      //bounceYIndex -= abs(bounceDirection);
    //      bounceXIndex = 0;
    //      bounceYIndex = map(per, 1, 2, maxZ, maxZ/2);
    //    } else if (per < 4) {
    //      bounceXIndex = 0;
    //      bounceYIndex = map(per, 1, 2, maxZ/2, 0);
    //      //bounceYIndex -= abs(bounceDirection);
    //      //bounceXIndex = 0;
    //    } else {
    //      bounceYIndex = 0;
    //      bounceXIndex = 0;
    //    }
    //  }

    void bounce() {
      int maxBounce = 45; //70
      if (bounceIndex < maxBounce) {
        //bounceYIndex = map(bounceIndex, 0, maxBounce, 0, 100);
        //bounceXIndex = map(bounceIndex, 0, maxBounce, 0, -100);
        bounceYIndex += abs(bounceDirection);
        bounceXIndex -= bounceDirection;
      } else if (bounceIndex < maxBounce*2) {
        bounceXIndex += bounceDirection;
        bounceYIndex += abs(bounceDirection);
        //bounceYIndex = map(bounceIndex, maxBounce, maxBounce*2, 0, 100);
        //bounceXIndex = map(bounceIndex, 0, maxBounce, 0, -100);
      } else if (bounceIndex < maxBounce*3) {
        //bounceXIndex;
        bounceYIndex -= abs(bounceDirection);
      } else if (bounceIndex < maxBounce*4) {
        bounceYIndex -= abs(bounceDirection);
        bounceXIndex = 0;
      } else {
        bounceYIndex = 0;
        bounceXIndex = 0;
      }
    }

    //void crisscross() {
    //  int xScale = 3; // 10
    //  int zScale = 2; // 5;
    //  int maxBounce = maxCrisscross/4; // 50
    //  if (bounceIndex < maxBounce) {
    //    if (x < (wt+translateX)/2) bounceXIndex -= bounceDirection*xScale;
    //    else bounceXIndex += bounceDirection*xScale;
    //    bounceYIndex = 0;
    //    bounceZIndex = 0;
    //  } else if (bounceIndex < maxBounce*2) {
    //    if (x < (wt+translateX)/2) bounceZIndex += bounceDirection*zScale;
    //    else bounceZIndex -= bounceDirection*zScale;
    //  } else if (bounceIndex < maxBounce*3) {
    //    if (x < (wt+translateX)/2) bounceXIndex += bounceDirection*xScale;
    //    else bounceXIndex -= bounceDirection*xScale;
    //  } else if (bounceIndex < maxBounce*4-2) {
    //    if (x < (wt+translateX)/2) bounceZIndex -= bounceDirection*zScale;
    //    else bounceZIndex += bounceDirection*zScale;
    //  }
    //}
    void crisscross(float per) {
      per *=5;
      int maxX = 350;
      int maxZ = 150;
      //int maxBounce = maxCrisscross/4; // 50
      float midX = (wt+translateX)/2;
      if (per < 1) {
        if (x < midX) bounceXIndex = map(per, 0, 1, 0, maxX);
        else bounceXIndex = map(per, 0, 1, 0, -maxX);
        bounceYIndex = 0;
        bounceZIndex = 0;
      } else if (per < 2) {
        if (x < midX) bounceZIndex  = map(per, 1, 2, 0, maxZ);
        else bounceZIndex  = map(per, 1, 2, 0, -maxZ);
      } else if (per < 3) {
        if (x < midX)  bounceXIndex = map(per, 2, 3, maxX, 0);
        else bounceXIndex = map(per, 2, 3, -maxX, 0);
      } else if (per < 4) {
        if (x < midX) bounceZIndex = map(per, 3, 4, maxZ, 0);
        else bounceZIndex = map(per, 3, 4, -maxZ, 0);
      } else {
        bounceXIndex = 0;
        bounceZIndex = 0;
        bounceIndex = 0;
        changeMovementSetting(0);
      }
    }



    void setRandomRectSizes() {
      rectSizes = new int[ySteps];
      for (int i = 0; i < rectSizes.length; i++) {
        rectSizes[i] = int(random(-5, 5));
      }
    }

    void setStandardRectSizes() {
      rectSizes = new int[ySteps];
      for (int i = 0; i < rectSizes.length; i++) {
        rectSizes[i] = 0;
      }
    }

    void gradientStroke(PGraphics s, int index, int hue) {
      s.colorMode(HSB, 255);
      float f;
      if (index > ySteps/2) f = 0;
      else {
        if (ySteps/2 > 0) f = map(index, 0, ySteps/2, 255, 0);
        else f = 0;
      }
      s.stroke(hue, f, 255);
    }

    void gradientSetAllStroke(PGraphics s, int index, int startHue, int endHue) {
      s.colorMode(HSB, 255);
      float h;
      if (z > -500) h = startHue;
      else h = map(z, -500, -3500, startHue, endHue);

      float f;
      if (index > ySteps/2) f = 0;
      else {
        if (ySteps/2 > 0) f = map(index, 0, ySteps/2, 255, 0);
        else f = 0;
      }
      s.stroke(h, f, 255);
    }

    void gradientSetAllStrokePlatform(PGraphics s, int index, int startHue, int endHue, float lr) {
      s.colorMode(HSB, 255);
      float h;
      lr *= 2;
      if (lr > 1) lr = map(lr, 1, 2, 1, 0);
      float per = (map(z, -500, -3500, 0, 1) + lr);
      if (per > 1) per = map(per, 1, 2, 1, 0);
      h = map(per, 0, 1, 125, 180);
      //h = lerpColor(startHue, endHue, per);

      float f;
      if (index > ySteps/2) f = 0;
      else {
        if (ySteps/2 > 0) f = map(index, 0, ySteps/2, 255, 0);
        else f = 0;
      }
      s.stroke(h, f, 255);
    }

    void gradientSetAllStrokeSat(PGraphics s, int index, int startHue, int endHue, int startSat) {
      s.colorMode(HSB, 255);
      float h;
      if (z > -500) h = startHue;
      else h = map(z, -500, -3500, startHue, endHue);

      float f;
      if (index > ySteps/2) f = 0;
      else {
        if (ySteps/2 > 0) f = map(index, 0, ySteps/2, startSat, 0);
        else f = 0;
      }
      s.stroke(h, f, 255);
    }

    void updateDrip() {
      if (millis() - lastCheck > 40) {
        if (type == STALAC) {
          dripCount++;
          if (dripCount > maxDrip) dripCount = 0;
          lastCheck = millis();
        } else {
          dripCount--;
          if (dripCount <0) dripCount = maxDrip;
          lastCheck = millis();
        }
      }
    }

    void drip(int screenNum, PGraphics s, int index) {
      s.colorMode(HSB, 255);

      if (colorSettings[screenNum] == RANDOM) hueDrip(s, index);
      else if (colorSettings[screenNum] == RAINBOW_FILL) rainbowDrip(s, index);
      else if (colorSettings[screenNum] == GRAD_ALL) colorDrip(screenNum, s, index);
      else if (colorSettings[screenNum] == GRAD1 || colorSettings[screenNum] == GRAD2) colorDrip(screenNum, s, index);
      else if (colorSettings[screenNum] == CAST_LIGHT ||  colorSettings[screenNum] == CAST_LIGHT_SIDE) colorDrip(screenNum, s, index);
      else if (colorSettings[screenNum] == START) colorDrip(screenNum, s, index);
      else blackDrip(s, index);
    }


    void colorDrip(int screenNum, PGraphics s, int index) {
      s.colorMode(RGB, 255);
      color c = getLerpColor(screenNum/2, index);
      s.colorMode(HSB, 255);

      int h = int(hue(c));
      int sat = int(saturation(c));
      int b = int(brightness(c));
      if (type == STALAC) {
        if (index == dripCount) s.fill(h, int(sat*(200.0/255)), b);
        else if (index == dripCount + 1) s.fill(h, int(sat*(150.0/255)), b);
        else if (index == dripCount + 2) s.fill(h, int(sat*(100.0/255)), b);
        else if (index == dripCount + 3) s.fill(h, int(sat*(50.0/255)), b);
        else s.fill(h, sat, b);
      } else {
        if (index == dripCount) s.fill(h, int(sat*(200.0/255)), b);
        else if (index == dripCount - 1) s.fill(h, int(sat*(150.0/255)), b);
        else if (index == dripCount - 2) s.fill(h, int(sat*(100.0/255)), b);
        else if (index == dripCount - 3) s.fill(h, int(sat*(50.0/255)), b);
        else s.fill(h, sat, b);
      }
    }

    void rainbowDrip(PGraphics s, int index) {
      if (type == STALAC) {
        if (index == dripCount) s.fill(getRainbowHue(index), 200, 255);
        else if (index == dripCount + 1) s.fill(getRainbowHue(index), 150, 255);
        else if (index == dripCount + 2) s.fill(getRainbowHue(index), 100, 255);
        else if (index == dripCount + 3) s.fill(getRainbowHue(index), 50, 255);
        else s.fill(getRainbowHue(index), 255, 255);
      } else {
        if (index == dripCount) s.fill(getRainbowHue(index), 200, 255);
        else if (index == dripCount - 1) s.fill(getRainbowHue(index), 150, 255);
        else if (index == dripCount - 2) s.fill(getRainbowHue(index), 100, 255);
        else if (index == dripCount - 3) s.fill(getRainbowHue(index), 50, 255);
        else s.fill(getRainbowHue(index), 255, 255);
      }
    }

    void hueDrip(PGraphics s, int index) {
      if (type == STALAC) {
        if (index == dripCount) s.fill(hues[index], 200, 255);
        else if (index == dripCount + 1) s.fill(hues[index], 150, 255);
        else if (index == dripCount + 2) s.fill(hues[index], 100, 255);
        else if (index == dripCount + 3) s.fill(hues[index], 50, 255);
        else s.fill(hues[index], 255, 255);
      } else {
        if (index == dripCount) s.fill(hues[index], 200, 255);
        else if (index == dripCount - 1) s.fill(hues[index], 150, 255);
        else if (index == dripCount - 2) s.fill(hues[index], 100, 255);
        else if (index == dripCount - 3) s.fill(hues[index], 50, 255);
        else s.fill(hues[index], 255, 255);
      }
    }

    void blackDrip(PGraphics s, int index) {
      if (type == STALAC) {
        if (index == dripCount) s.fill(255);
        else if (index == dripCount + 1) s.fill(150);
        else if (index == dripCount + 2) s.fill(100);
        else if (index == dripCount + 3) s.fill(50);
        else s.fill(0);
      } else {
        if (index == dripCount) s.fill(255);
        else if (index == dripCount - 1) s.fill(150);
        else if (index == dripCount - 2) s.fill(100);
        else if (index == dripCount - 3) s.fill(50);
        else s.fill(0);
      }
    }
  }

  final int ceiling = 3;
  final   int rightWall = 1;
  final   int leftWall = 2;
  final   int ground = 0;
  final   int flatWall = 4;

  public class Grid {

    int imgStep, gridMode, animateIndex;
    float cellSize;
    float xRot, yRot, zRot;
    float [][] noiseGrid;
    ColorPixel [][] colorGrid;


    int cols, rows, x, y, z;


    Grid(int w, int h, float cellSize) {
      this(w, h, cellSize, 0, 0, 0, 0, 0, 0, 0);
    }

    Grid(int w, int h, float cellSize, int x, int y, int z, float xRot, float yRot, float zRot, int gridMode) {
      this.cols = int(w/cellSize);
      this.rows = int(h/cellSize);
      this.x = x;
      this.y = y;
      this.z = z;
      this.gridMode = gridMode;

      this.cellSize = cellSize;
      this.xRot = xRot;
      this.yRot = yRot;
      this.zRot = zRot;
      noiseGrid = new float [cols][rows];
      colorGrid = new ColorPixel [cols][rows];
      animateIndex = -1;

      imgStep = cols*rows-1;
      setNoiseGrid();
      setColorGrid();
    }

    public void display(int screenNum, PGraphics s) {


      s.pushMatrix();
      s.translate(x, y, z);
      s.rotateY(radians(yRot));
      s.rotateX(radians(xRot));
      s.rotateZ(radians(zRot));
      s.textureMode(NORMAL);
      s.textureWrap(CLAMP);

      for (int i = 0; i < rows-1; i++ ) {
        s.colorMode(HSB, 255);
        s.beginShape(QUAD_STRIP);

        for (int j = 0; j < cols-1; j++) {

          if (colorSettings[screenNum] == RANDOM) randomizeSporadicColorGrid();


          if (gridMode == rightWall) drawRightGrid(screenNum, s, i, j);
          else if (gridMode == leftWall) drawLeftGrid(screenNum, s, i, j);
          else if (gridMode == ground) drawGround(screenNum, s, i, j);
          else if (gridMode == ceiling) drawCeiling(screenNum, s, i, j);
          else {

            s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i]*1.5); //, j*(neuralImgLeft.width*1.0/cols),i*(neuralImgLeft.height*1.0/rows));
            s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]*1.5); // ,j*(neuralImgLeft.width*1.0/cols),(i+1)*(neuralImgLeft.height*1.0/rows));
          }
        }
        s.endShape();
      }
      s.popMatrix();
    }

    public void drawFlatCave(int screenNum, PGraphics s, boolean isFlat) {
      s.pushMatrix();
      if (isFlat) {
        s.translate(-200, -300, -700);
        s.rotateY(0); //radians(yRot));
        s.rotateX(0); //radians(xRot));
        s.rotateZ(0); //radians(zRot));
      } else {
        s.translate(x, y, z);
        s.rotateY(radians(yRot));
        s.rotateX(radians(xRot));
        s.rotateZ(radians(zRot));
      }
      s.textureMode(NORMAL);
      s.textureWrap(CLAMP);

      for (int i = 0; i < rows-1; i++ ) {
        s.colorMode(HSB, 255);
        s.beginShape(QUAD_STRIP);
        for (int j = 0; j < cols-1; j++) {
          //if (colorSettings[screenNum] == RANDOM) randomizeSporadicColorGrid();

          if (isFlat) drawFlatGrid(screenNum, s, i, j);
          else if (gridMode == ground) drawGround(screenNum, s, i, j);
          else if (gridMode == ceiling) drawCeiling(screenNum, s, i, j);
          else if (gridMode == leftWall) drawLeftGrid(screenNum, s, i, j);
          else if (gridMode == rightWall) drawRightGrid(screenNum, s, i, j);
        }
        s.endShape();
      }
      s.popMatrix();
    }

    void drawFlatGrid(int screenNum, PGraphics s, int i, int j) {

      float b = 2;
      float a = 50;
      float xt = map(j, 0, cols-1, 0, 2*PI);
      float f;
      if (i < 30) {
        int alpha = 255;
        if (drawImage && isOverImage(i, j)) alpha = 75;

        setGridColors(screenNum, s, this, i, j, flatWall);
        s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i]+a*cos(b*xt));
        s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]+a*cos(b*xt));
      }
    }

    //void drawSphereGrid(PGraphics s) {
    //  for (int i = 0; i < rows-1; i++ ) {
    //    s.colorMode(HSB, 255);
    //    s.beginShape(QUAD_STRIP);
    //    for (int j = 0; j < cols-1; j++) {
    //      drawFlatGrid(0, s, i, j);
    //    }
    //    s.endShape();
    //  }
    //}

    public void drawLeftGrid(int screenNum, PGraphics s, int i, int j) {
      float b = 2;
      float a = 50;
      float xt = map(j, 0, cols-1, 0, 2*PI);

      setGridColors(screenNum, s, this, i, j, gridMode);

      int startW = int(20*30.0/cellSize);
      if (j > startW) {
        s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i] +a*cos(b*xt));
        s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1] +a*cos(b*xt));
      }
    }

    boolean isOverImage(int i, int j) {
      if (gridMode == ceiling || gridMode == ground) return false;
      else {
        if (gridMode == leftWall) {
          if (j > 10 && j < 90) return true;
          return false;
        } else {
          if (j > 60 && j < 120) return true;
          return false;
        }
      }
    }

    public void drawRightGrid(int screenNum, PGraphics s, int i, int j) {
      //float b = 2*PI/cols;
      float b = 2;
      float a = 50;
      float xt = map(j, 0, cols-1, 0, 2*PI);

      setGridColors(screenNum, s, this, i, j, gridMode);

      s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i]+a*cos(b*xt));
      s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]+a*cos(b*xt));
    }

    public void drawCeiling(int screenNum, PGraphics s, int i, int j) {
      setGridColors(screenNum, s, this, i, j, gridMode);
      s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i]*1.5);
      s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]*1.5);
    }

    public void drawGround(int screenNum, PGraphics s, int i, int j) {
      setGridColors(screenNum, s, this, i, j, gridMode);
      s.vertex(j * cellSize, cellSize*i, noiseGrid[j][i]*1.5);
      s.vertex(j * cellSize, cellSize*(i+1), noiseGrid[j][i+1]*1.5);
    }

    public void resetGrid() {
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          colorGrid[i][j].reset();
        }
      }
    }

    public void setColorGrid() {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          colorGrid[j][i] = new ColorPixel();
          colorGrid[j][i].randomColor();
        }
      }
    }

    public void randomizeColorGrid() {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          colorGrid[j][i].randomColor();
        }
      }
    }

    public void randomizeSporadicColorGrid() {
      if (int(random(50)) == 0) colorGrid[int(random(cols))][int(random(rows))].randomColor();
    }

    public void setNoiseGrid() {
      float yoff = .01;
      float xoff = 0;
      for (int j = 0; j < rows; j++) {
        for (int i = 0; i < cols; i++) {
          noiseGrid[i][j] = map(noise(xoff, yoff), 0, 1, -30, 30);
          xoff += .2;
        }
        yoff += .2;
      }
    }

    public void setWaveGrid() {
      float yoff = .01;
      float xoff = 0;
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          int xspacing = 20;
          float period = 200;
          float period2 = 200;
          float amplitude = 50;
          float amplitude2 = 50;
          float dx = (TWO_PI / period) * xspacing;
          float dx2 = (TWO_PI / period2) * xspacing;
          noiseGrid[j][i] = sin(i*dx)*amplitude + sin(j*dx2)*amplitude2;
          xoff += .2;
        }
        yoff += .2;
      }
    }
  }

  void setGridColors(int screenNum, PGraphics s, Grid g, int i, int j, int gridMode) {
    float f, alpha;
    alpha = 255;

    switch(colorSettings[screenNum]) {
    case STARTUP_STROKE:

      int startSat = 255;
      if (gridMode == ground) {
        if (personOnPlatform) {

          float lr = getCaveHand();
          float per = (map(i, 15, g.rows-1, 0, 1) + lr);
          if (per > 1) per = map(per, 1, 2, 1, 0);
          float h = map(per, 0, 1, 125, 180);
          //f = map(i, 15, g.rows-1, 125, 180);
          s.stroke(h, startSat, 225);
        } else {
          if (rainbowIndex < 0) startSat = 255 + rainbowIndex; // also left
          else startSat = 255;
          if (i < 15) s.stroke(125, startSat, 255);
          else {
            f = map(i, 15, g.rows-1, 125, 180);
            s.stroke(f, startSat, 225);
          }
        }
      } else if (gridMode == ceiling) {
        if (personOnPlatform) {
          if (i < 15) s.stroke(125, startSat, 255);
          else {
            float lr = getCaveHand();
            float per = (map(i, 15, g.rows-1, 0, 1) + lr);
            if (per > 1) per = map(per, 1, 2, 1, 0);
            float h = map(per, 0, 1, 125, 180);
            //f = map(i, 15, g.rows-1, 125, 180);
            s.stroke(h, startSat, 225);
          }
        } else {
          if (rainbowIndex < 0) startSat += rainbowIndex;
          if (i < 15) {
            s.stroke(125, startSat, 255);
          } else {
            f = map(i, 15, g.rows-1, 125, 180);
            s.stroke(f, startSat, 225);
          }
        }
      } else if (gridMode == flatWall) {
        if (personOnPlatform) {
          if (i < 15) s.stroke(125, startSat, 255);
          else {
            float lr = getCaveHand();
            float per = (map(i, 15, g.rows-1, 0, 1) + lr);
            if (per > 1) per = map(per, 1, 2, 1, 0);
            float h = map(per, 0, 1, 125, 180);
            //f = map(i, 15, g.rows-1, 125, 180);
            s.stroke(h, startSat, 225);
          }
        } else {
          if (rainbowIndex < 0) startSat += rainbowIndex;
          int startG = int(35*25.0/g.cellSize);  
          if (j < startG) {
            s.stroke(125, startSat, 255, alpha);
          } else {
            f = map(j, startG, g.cols-1, 125, 180);
            s.stroke(f, startSat, 225, alpha);
          }
        }
      } 
      // left, right wall
      else {
        if (personOnPlatform) {
          int startG = int(35*25.0/g.cellSize);  
          float lr = getCaveHand();
          float per = (map(j, startG, g.cols-1, 0, 1) + lr);
          if (per > 1) per = map(per, 1, 2, 1, 0);
          float h = map(per, 0, 1, 125, 180);
          //f = map(i, 15, g.rows-1, 125, 180);
          s.stroke(h, startSat, 225);
        } else {
          if (rainbowIndex < 0) startSat += rainbowIndex;
          int startG = int(35*25.0/g.cellSize);  
          if (j < startG) {
            s.stroke(125, startSat, 255, alpha);
          } else {
            f = map(j, startG, g.cols-1, 125, 180);
            s.stroke(f, startSat, 225, alpha);
          }
        }
      }
      break;
    case ICE:
      s.fill(255, 150);
      s.stroke(125, 255, 255);
      break;
    case RAINBOW_STROKE:
      if (gridMode == ground) {
        f = map((i+frameCount)%g.rows-1, 0, g.rows-1, 0, 255);
        s.stroke(rainbowIndex%255, 255, 225);
        break;
      } else {
        f = map(j, 0, g.cols-1, 0, 255);
        s.stroke((f+rainbowIndex)%255, 255, 225, alpha);
      }

      break;

    case RAINBOW_PULSE: 
      if (gridMode == ceiling || gridMode == ground) {
        f = map(i, 0, g.rows-1, 0, 255);
        if (rainbowIndex < 0) s.stroke(i, 255 + rainbowIndex, 225);
        else if ((i+rainbowIndex) > 210) s.stroke((i+rainbowIndex)%255, 255 - (rainbowIndex-210), 225);
        else  s.stroke((i+rainbowIndex)%255, 255, 225);
      } else {
        f  = map(j, 0, g.cols, 0, 255);
        if (rainbowIndex < 0) s.stroke(j, 255 + rainbowIndex, 225, alpha);
        else if ((j+rainbowIndex) > 210) {
          if (fadingToWhite) s.stroke((j+rainbowIndex)%255, 255 - (rainbowIndex-210), 225, alpha);
          else s.stroke((j+rainbowIndex)%255, 255, 225, alpha);
        } else  s.stroke((j+rainbowIndex)%255, 255, 225, alpha);
      }
      break;
    case CAST_LIGHT:
      if (gridMode == flatWall) lightGridTopBot(s, screenNum, i, g.cols, true);
      else if (gridMode == ceiling) lightGridTopBot(s, screenNum, i, g.cols);
      else if (gridMode == ground)  lightGridTopBot(s, screenNum, i, g.cols);
      else if (gridMode == leftWall) lightGridTopBot(s, screenNum, j-20, g.rows);
      else if (gridMode == rightWall) lightGridTopBot(s, screenNum, j-20, g.rows);

      break;
    case CAST_LIGHT_SIDE: 
      if (gridMode == flatWall) lightGridSide(s, screenNum, j, g.rows);
      if (gridMode == rightWall || gridMode == leftWall) lightGridSide(s, screenNum, i, g.cols);
      if (gridMode == ceiling || gridMode == ground) {
        s.noStroke();
        s.noFill();
      }
      break;
    case RAINBOW_FILL:
      f = map(i, 0, g.rows-1, -20, 255);
      s.stroke(f, 255, 225, alpha);
      break;
    case GRAD_ALL:
      s.stroke(getLerpColorAllSame(screenNum));
      s.fill(0);
      break; 
    case GRAD1:
      s.stroke(getLerpColorSides(screenNum));
      s.fill(0);
      break;
    case GRAD2:
      s.stroke(getLerpColorSides(screenNum));
      s.fill(0);
      break;
    case START:
      colorMode(HSB, 255);
      float h = hue(lerpC[screenNum]);
      float br = brightness(lerpC[screenNum]);
      float sat = saturation(lerpC[screenNum]);
      s.fill(0);
      s.stroke(h, sat, br-50, alpha);
      break;
    case RANDOM:
      h = hue(g.colorGrid[j][i].getColor());
      s.stroke(h, 255, 255, alpha);
      s.fill(0);
      break;
    default:
      s.stroke(0);
      s.fill(0);
      break;
    }
  }

  class ColorPixel {

    color colorFix;
    color colorSwap;
    boolean isMoving;

    ColorPixel() {
      colorFix = 0;
      colorSwap = 0;
      isMoving = true;
    }

    void updateColor(color c) {
      if (isMoving) {
        colorFix = c;
        colorSwap = c;
      } else colorSwap = c;
    }

    color getColorSwap() {
      return colorSwap;
    }

    color getStroke() {
      if (!isMoving) return 0; //color(255,255,255);
      else return color(0, 255, 255);
    }

    void checkUpdate(int x, int y, int w, int h) {
      //if (colorSwap == getVertexColor(x, y, w, h)) {
      isMoving = false;
      //}
    }

    color getColor() {
      return colorFix;
    }


    void randomColor() {
      colorMode(HSB, 255);
      colorFix = color(random(0, 255), 255, 255);
      colorSwap = colorFix;
    }

    void reset() {
      colorFix = 0;
      colorSwap = 0;
      isMoving = true;
    }
  }

  void drawSphereGrid() {
    PGraphics s = sphereScreen.s;
    s.beginDraw();
    s.background(0);
    grids[0].drawFlatCave(0, s, true);
    s.mask(tempSphere);
    s.endDraw();
  }

  color getSphereColor() {
    colorMode(HSB, 255);
    int mode = colorSettings[0];
    if (mode == CAST_LIGHT) return color(255);
    else if (mode == CAST_LIGHT_SIDE) return color(50, 255, 255);
    else if (mode == STARTUP_STROKE || mode == ICE) return color(125, 255, 255);
    else if (mode == RAINBOW_PULSE || mode == RAINBOW_FILL) return color(0, 255, 255);
    else return lerpC[1];
  }
}

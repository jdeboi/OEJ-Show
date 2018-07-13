import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;
int midiStartTime = 0;
boolean clickTrackStarted = false;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
//////////////////////////////////////////////////////////////////////////////////
void initViolate() {
  cues = new Cue[23];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(10.5, 'v', 0.0, 0);
  cues[2] = new Cue(21.8, 'v', 0.0, 0);
  cues[3] = new Cue(32.1, 'v', 0.0, 0);  // could be the trick
  cues[4] = new Cue(43, 'v', 0.0, 0);  // this is the same as 3, could be deleted?
  cues[5] = new Cue(53.8, 'v', 0.0, 0);
  cues[6] = new Cue(61.4, 'v', 0.0, 0); // DADADA
  cues[7] = new Cue(64.5, 'v', 0.0, 0);
  // could have one at 74
  cues[8] = new Cue(85.8, 'v', 0.0, 0);  // loww
  cues[9] = new Cue(91, 'v', 0.0, 0);
  cues[10] = new Cue(101.8, 'v', 0.0, 0);
  cues[11] = new Cue(112, 'v', 0.0, 0);
  cues[12] = new Cue(120.25, 'v', 0.0, 0); // DADADA
  cues[13] = new Cue(122.6, 'v', 0.0, 0);
  cues[14] = new Cue(133.4, 'v', 0.0, 0);
  cues[15] = new Cue(144.5, 'v', 0.0, 0); // striped down

  /////// DONE
  cues[16] = new Cue(155, 'v', 0.0, 0);  // ENTER AWESOME sound
  cues[17] = new Cue(176, 'v', 0.0, 0);
  cues[18] = new Cue(197.5, 'v', 0.0, 0);
  cues[19] = new Cue(219, 'v', 0.0, 0);
  cues[20] = new Cue(232, 'v', 0.0, 0);
  cues[21] = new Cue(233.5, 'v', 0.0, 0);

  cave = new OEJCave(screens[1].s);

  //songFile = new Song(234 , 90);
}

void deconstructViolate() {
  cave = null;
}

// black as a gradient color

void displayViolate() {
  displayLines(0);
  cave.drawCaveScreens();
  switch(currentCue) {
  case 0:
    cave.changeAllColorSettings(0);
    break;
  case 1: // something some come in bouncing on the beat
    cave.displayCaveAllBounce();
    break;
  case 2: // left, right, left, right
    cave.displayCaveLeftRightBounce();
    break;
  case 3:
    cave.changeAllColorSettings(0);
    break;
  case 4:
    //changeAllColorSettings(RAINBOW_PULSE);
    cave.changeAllColorSettings(CAST_LIGHT);
    break;
  case 5:
    //changeMovementSetting(CRISSCROSS);
    cave.changeAllColorSettings(0);
    break;
  case 6:
    cave.changeMovementSetting(CRISSCROSS);
    cave.displayCaveLeftRightBounce();
    break;
  case 7:
    cave.changeAllColorSettings(6);
    break;
  case 8:
    cave.changeAllColorSettings(0);
    break;
  case 9:
    cave.changeAllColorSettings(1);
    break;
  case 10:
    cave.changeAllColorSettings(2);
    break;
  case 11:
    cave.displayCaveAllBounce();
    break;
  case 12:
    cave.displayCaveAllBounce();
    break;
  case 13:
    cave.displayCaveAllBounce();
    break;
  case 14:
    cave.displayCaveAllBounce();
    break;
  case 15:
    cave.displayCaveAllBounce();
    break;

    ///////////////////////////////// DONE
  case 16:
    cave.displayCaveAllBounce();
    cave.changeMovementSetting(BOUNCE);
    break;
  case 17: 
    cave.changeAllColorSettings(RANDOM);
    cave.changeMovementSetting(BOUNCE);
    break;
  case 18: 
    cave.changeAllColorSettings(ICE);
    cave.changeMovementSetting(BOUNCE);
    break;
  case 19:
    cave.changeAllColorSettings(GRAD_ALL);
    break;
  case 20:
    fadeOutAllScreens(cues[currentCue].startT, 1);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}


void initCycles() {
  initVid("scenes/cycles/movies/vid1.mp4");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length()/1000 - 1, 'v', 0.0, 0);
}


void deconstructCycles() {
  vid1 = null;
  vid2 = null;
}




void initSong() {
  cues = new Cue[16];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(10.5, 'v', 0.0, 0);
  cues[2] = new Cue(18.5, 'v', 0.0, 0);
  cues[3] = new Cue(34.5, 'v', 0.0, 0);
  cues[4] = new Cue(50.5, 'g', 0.0, 0);
  cues[5] = new Cue(66.5, 'g', 0.0, 0);
  cues[6] = new Cue(74.5, 'v', 0.0, 0);
  cues[7] = new Cue(82.4, 'g', 0.0, 1);
  cues[8] = new Cue(98.4, 'g', 0.0, 1);
  cues[9] = new Cue(114.4, 'g', 0.0, 2);
  cues[10] = new Cue(130.4, 'g', 0.0, 2);
  //cues[10] = new Cue(138.5, 'v', 0.0, 0);
  cues[11] = new Cue(146.5, 'v', 0.0, 0);
  cues[12] = new Cue(162.5, 'v', 0.0, 0);
  cues[13] = new Cue(178.5, 'v', 0.0, 0);
  cues[14] = new Cue(186.6, 'v', 0.0, 0); // fade out
  cues[15] = new Cue(192, 'v', 0.0, 0);


  currentGifs.get(3).loop();
  currentGifs.get(4).loop();
  currentGifs.get(currentGifs.size()-1).loop();

  sphereImg = loadImage("images/sphere/grass.png");

  initTreeBranchesAll();
}

void deconstructSong() {
  sphereImg = null;
  paths = null;
}

void displaySong() {
  if (!personOnPlatform) sphereScreen.drawImage(sphereImg, 0, 0, sphereScreen.s.width, sphereScreen.s.height); //sphereScreen.drawGif(currentGifs.get(currentGifs.size()-1), 0, 0, sphereScreen.s.width, sphereScreen.s.height);
  else drawEye();

  switch(currentCue) {
  case 0:
    branchAll();

    break;
  case 1:
    branchAll();
    break;
  case 2:
    branchAll();
    break;
  case 3:
    branchAll();
    break;
  case 4: 

    treeRun(4);
    drawSolidOuter(color(0));
    break;
  case 5: 
    drawSolidOuter(color(0));
    treeRun(4);
    break;
  case 6: 
    drawSolidAllCubes(color(0));
    transit(white, color(55), color(55), white, percentToNumBeats(8));
    break;
  case 7: 
    updateTreeBranches();
    displayTreeBranchesOuter();
    displayTreeBranchesTop();
    //drawSolidOuter(color(0));
    treeRun(3);
    break;
  case 8: 
    updateTreeBranches();
    displayTreeBranchesOuter();
    displayTreeBranchesTop();
    //drawSolidOuter(color(0));
    treeRun(3);
    break;
  case 9: 
    //drawSolidOuter(color(0));
    updateTreeBranches();
    displayTreeBranchesOuter();
    displayTreeBranchesTop();
    treeRun(-1);
    break;
  case 10: 
    updateTreeBranches();
    displayTreeBranchesOuter();
    displayTreeBranchesTop();
    treeRun(-1);
    break;
  case 11: 
    drawSolidAllCubes(color(0));
    displayFractalTreeSong();
    break;
  case 12: 
    displayFractalTreeSong();
    break;
  case 13: 
    displayFractalTreeSong();
    break;
  case 14: 
    displayFractalTreeSong();
    fadeOutAllScreens(cues[currentCue].startT, 5);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void branchAll() {
  updateTreeBranches();
  displayTreeBranchesOuter();
  displayTreeBranchesInner();
  displayTreeBranchesTop();
  displayLinesOutsideFaces(color(255), color(255));
  displayLinesInnerFaces(color(55));
}

int treez = 0;
void treeRun(int addonGif) {

  //treez += 1;
  //if (currentCycle%4 == 0) treez = 0;

  for (int i = 1; i < 3; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    s.blendMode(ADD);

    //s.pushMatrix();
    //s.translate(0, 0, treez);
    //s.ellipse(s.width/2, s.height/2-25, treez*treez*.1, treez*treez*.1);
    //s.popMatrix();


    if (i == 2) {
      s.pushMatrix();
      s.scale(-1, 1);
      s.noStroke();
      s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenW);
      if (addonGif > -1) s.image(currentGifs.get(addonGif), -screenW, 0, screenW, screenW);

      s.ellipseMode(CENTER);
      s.fill(255);
      s.noStroke();
      s.popMatrix();
    } else {
      s.image(currentGifs.get(currentGif), 0, 0, screenW, screenW);
      if (addonGif > -1) s.image(currentGifs.get(addonGif), 0, 0, screenW, screenW);
    }
    s.stroke(255);
    s.strokeWeight(3);
    s.noFill();


    s.endDraw();
  }
}

void initCrush() {
  //initVid("scenes/crush/movies/crush.mp4");
  cues = new Cue[18];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(10.7, 'v', 0.0, 0);  // X
  cues[2] = new Cue(25.88, 'v', 0.0, 0);  // X
  cues[3] = new Cue(27.2, 'v', 0.0, 0);
  cues[4] = new Cue(28.4, 'g', 0.0, 0);
  cues[5] = new Cue(37.6, 'g', 0.0, 0);    

  cues[6] = new Cue(56.47, 'g', 0.0, 2);  // alternate cubes?
  cues[7] = new Cue(61.2+4.7, 'g', 0.0, 2);    // alternate cubes?
  cues[8] = new Cue(70.6+4.7, 'v', 20.0, 4);    // X
  //cues[6] = new Cue('v', 0, 75);   // X
  cues[9] = new Cue(80+4.7, 'g', 0.0, 3);   // xylophone
  cues[10] = new Cue(98.8+4.7, 'g', 0.0, 5);
  cues[11] = new Cue(105.9, 'g', 0.0, 6);
  cues[12] = new Cue(124.7, 'g', 0.0, 2);
  cues[13] = new Cue(143.6, 'g', 0.0, 4);
  cues[14] = new Cue(157.6+4.7, 'v', 0.0, 0);
  cues[15] = new Cue(2*60 + 56.6+4.7, 'g', 0.0, 1);
  cues[16] = new Cue(3*60 + 15.3+4.7, 'v', 0.0, 0);
  cues[17] = new Cue(3*60 + 24+4.7, 'v', 0.0, 0);

  initSphereBoxRot();

  // initTerrainCenter();
  resetAudioAmp();
  //sphereImg = loadImage("images/sphere/1.jpg");
  //centerScreen = new Screen(screenW*2, screenH, -2);
  //centerScreenFrontInner();
  initTerrain();
}

void deconstructCrush() {
}

boolean blackOutPlanet = false;
void resetRedPlanet() {
  if (!blackOutPlanet) {
    sphereScreen.blackOut();
    blackOutPlanet = true;
  }
}


void displayCrush() {
  int zCrush = 0;
  //cycleShapeFFTTop();
  if (!personOnPlatform) {
    displayRedPlanetSphere();
    zCrush = 0;
  } else {
    drawEye();
   
    zCrush = getZCrushHand();
  }

  switch(currentCue) {
  case 0:
    drawSolidAllCubes(0);
    break;
  case 1: // spherebox
    displayLinesInnerFaces(white);
    displaySphereBoxCrush(zCrush);
    fadeInCubes(cues[currentCue].startT, 2);
    renderCubes = true;
    break;
  case 2: // cube right
    renderCubes = false;
    drawSphereCrush(maskPoints[keystoneNum][3].x+150, 750, zCrush);

    drawSolidAllCubes(black);
    displayAllFaceLinesColor(0, 0, white, color(150));
    break;
  case 3: // cube left
    renderCubes = false;
    drawSphereCrush(maskPoints[keystoneNum][1].x-150, 750, zCrush);
    drawSolidAllCubes(black);
    displayAllFaceLinesColor(white, color(150), 0, 0);
    break;
  case 4: // oscillate outside, inside harom
    renderCubes = true;
    if (((currentCycle-1)/8)%2 == 0) {
      displayLinesOutsideFaces(color(255), color(255));
      drawSolidInner(0);
      for (int i = 0; i < screens.length; i+=3) {
        PGraphics s = screens[i].s;
        s.beginDraw();
        s.pushMatrix();
        s.translate(0, 0, zCrush);
        s.background(0);
        haromS(s, white, 3);
        s.popMatrix();
        s.endDraw();
      }
    } else {
      drawSolidOuter(0);
      displayLinesInnerFaces(white);
      for (int i = 1; i < 3; i++) {
        PGraphics s = screens[i].s;
        s.beginDraw();
        s.background(0);
        s.pushMatrix();
        s.translate(0, 0, zCrush);
        haromS(s, white, 3);
        s.popMatrix();
        s.endDraw();
      }
    }
    break;

  case 5: // all chill
    drawGifAllCrush(zCrush);
    break;
  case 6: // inner
    displayLinesInnerFaces(white);
    drawSolidOuter(0);

    displayDivisionOfIntensityInner(percentToNumBeats(8), 0, 0, zCrush);
    break;
  case 7:// puter
    displayLinesOutsideFaces(color(255), color(255));
    drawSolidInner(0);
    displayDivisionOfIntensityOuter(percentToNumBeats(8), 0, 0, zCrush);
    break;
  case 8:
    drawSolidAllCubes(color(0));
    if ((currentCycle -1)/8%2 == 0) {
      displayAllFaceLinesColor(white, color(150), 0, 0);
      displayDivisionOfIntensity(screens[0].s, percentToNumBeats(8), 0, 0, zCrush);
      displayDivisionOfIntensity(screens[1].s, percentToNumBeats(8), 0, 0, zCrush);
    } else {
      displayAllFaceLinesColor(0, 0, white, color(150));
      displayDivisionOfIntensity(screens[2].s, percentToNumBeats(8), 0, 0, zCrush);
      displayDivisionOfIntensity(screens[3].s, percentToNumBeats(8), 0, 0, zCrush);
    }
    break;
  case 9:
    drawGifAllCrush(zCrush);
    break;
  case 10: 
    drawGifAllCrush(zCrush);
    break;
  case 11: // spiral in groups of 2

    drawSolidAllCubes(color(0));
    int index = ((currentCycle -1)/4)%2;
    if (index == 0) displayAllFaceLinesColor(white, 0, white, 0);
    else displayAllFaceLinesColor(0, color(250), 0, color(150));
    for (int i = 0; i < 2; i++) {
      PGraphics s = screens[i*2 + index].s;
      s.beginDraw();
      s.blendMode(BLEND);
      s.pushMatrix();
      s.translate(0, 0, zCrush);
      s.background(0);
      s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
      s.popMatrix();
      s.endDraw();
    }
    break;
  case 12: // 
    drawGifAllCrush(zCrush);
    break;
  case 13: // 
    display4FaceLines(white, 1);
    display4FaceLines(white, 2);
    drawSolidOuter(0);
    currentGifDrawInner(zCrush);
    break;
  case 14:
    //cycleAudioAmp(percentToNumBeats(4));
    displayTerrainAllCrush();
    break;
  case 15: // draw the threshold
    displayLinesInnerFaces(white);
    for (int i = 1; i < 3; i++) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.background(0);
      s.pushMatrix();
      s.translate(0, 0, zCrush);
      s.blendMode(BLEND);
      //s.background(color(180, 0, 80));
      if (i == 1) {
        s.pushMatrix();
        s.scale(-1.0, 1.0);

        s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);//-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
        s.popMatrix();
      } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
      s.filter(THRESHOLD, .2);
      s.blendMode(BLEND);
      s.popMatrix();
      s.endDraw();
    }
    break;
  case 16:
    displaySphereBoxCrush(zCrush);
    fadeOutAllScreens(cues[currentCue+1].startT-3, 3);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void drawGifAllCrush(float z) {
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.blendMode(BLEND);
    s.background(0);
    //s.fill(0, 10);
    //s.noStroke();
    //s.rect(0, 0, screenW, screenH);
    s.pushMatrix();
    s.translate(0, 0, z);
    s.image(currentGifs.get(currentGif), 0, 0, screenW, screenW);
    //s.filter(THRESHOLD, .01);
    s.filter(GRAY);
    s.popMatrix();
    s.endDraw();
  }
}

void currentGifDrawInner(float z) {
  for (int i = 1; i < 3; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.pushMatrix();
    s.translate(0, 0, z);
    s.blendMode(BLEND);
    s.background(0);
    if (i == 1) {
      s.pushMatrix();
      s.scale(-1.0, 1.0);

      s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);//-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
      s.popMatrix();
    } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
    s.popMatrix();
    s.endDraw();
  }
}
void drawSphereCrush(int x, int y, int z) {
  pushMatrix();
  translate(x, y, -250 + z);
  rotateY(millis()/900.0);
  noFill();
  stroke(255);
  strokeWeight(1);
  //translate(x, y, -250);
  sphere(150);
  popMatrix();
}
void displayIntenseSphereCrush() {
  //for (int i = 1; i < 3; i++) {
  //  PGraphics s = screens[i].s;
  //  s.beginDraw();
  //  s.blendMode(BLEND);
  //  //s.background(color(180, 0, 80));
  //  if (i == 1) {
  //    s.pushMatrix();
  //    s.scale(-1.0, 1.0);

  //    s.image(currentGifs.get(4), -screenW, -300, screenW, currentGifs.get(1).height * currentGifs.get(2).width/screenW);
  //    s.popMatrix();
  //  } else s.image(currentGifs.get(4), 0, -300, screenW, currentGifs.get(1).height * currentGifs.get(2).width/screenW);
  //  //s.filter(THRESHOLD);
  //  //s.blendMode(BLEND);
  //  s.endDraw();
  //}
}

void initDelta() {
  //initVid("scenes/wizrock/movies/1_540.mp4");

  cues = new Cue[15];
  cues[0] = new Cue(3.89, 'v', 0, 0);
  cues[1] = new Cue(11.29, 'v', 0, 0);
  cues[2] = new Cue(25.39, 'v', 0, 0);
  cues[3] = new Cue(32.39, 'v', 0, 0);
  cues[4] = new Cue(47.39, 'v', 0, 0);
  cues[5] = new Cue(68.59, 'v', 0, 0);
  cues[6] = new Cue(97.89, 'v', 0, 0);
  cues[7] = new Cue(111.39, 'v', 0, 0);
  cues[8] = new Cue(131.89, 'v', 0, 0);
  cues[9] = new Cue(133.99, 'v', 0, 0);
  cues[10] = new Cue(148.39, 'v', 0, 0);
  cues[11] = new Cue(162.39, 'v', 0, 0);
  cues[12] = new Cue(177.39, 'v', 0, 0);
  cues[13] = new Cue(188.09, 'v', 0, 0);
  cues[14] = new Cue(198.39, 'v', 0, 0);
  cubesFront();

  initHands();
  initTheremin();
  initSymbols();
  initNodesSym(2);
}

void deconstructDelta() {
  hands = null;
  theremin = null;
  symbols = null;
  nodes = null;
}

int previousBeatIndex = 0;
int currentBeatIndex = 0;
int numBeatsIndex = 0;
void displayDelta() {

  if (!personOnPlatform) sphereScreen.blackOut();
  else {
    drawEye();
    drawWaveHands();
  }


  innerScreensOut();
  int h = int(hands[0].height*1.0*screenW/hands[0].width);

  switch(currentCue) {
  case 0:
    openCloseOutside();

    break;
  case 1:
    alternateDelta();
    break;
  case 2:
    chillSymbols();
    break;
  case 3:
    cycleHandsFFT();
    displayLines(white);
    break;
  case 4:
    datDeltaBass();
    break;
  case 5:
    crazyDelta();
    break;
  case 6:
    chillSymbols();
    break;
  case 7:
    chillSymbols();
    break;
  case 8:
    crazySymbols();
    break;
  case 9:
    crazierDelta();
    break;
  case 10:
    crazyDelta();
    break;
  case 11:
    crazyDelta();
    break;
  case 12:
    datDeltaBass();
    break;
  case 13:
    displaySymbolParticlesCenter();
    fadeOutAllScreens(cues[currentCue].startT, 5);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void openCloseOutside() {
  int h = int(hands[0].height*1.0*screenW/hands[0].width);
  PImage p;
  float per = percentToNumBeats(8);
  if (per < 0.5) {
    int num = int(map(per, 0, 0.5, 0, 5));
    p = hands[num];
  } else {
    int num = int(map(per, 0.5, 1, 4, -1));
    p = hands[num];
  }
  screens[0].drawImage(p, 0, screenH/2 -h/2, screenW, h);
  screens[3].drawImage(p, 0, screenH/2 -h/2, screenW, h);

  display4FaceLines(white, 0);
  display4FaceLines(white, 3);
}
void alternateDelta() {
  int h = int(hands[0].height*1.0*screenW/hands[0].width);
  if ((currentCycle-1)/2%2 == 0) {
    screens[0].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
    screens[3].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
  } else {
    screens[0].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
    screens[3].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
  }
  display4FaceLines(white, 0);
  display4FaceLines(white, 3);
}

void datDeltaBass() {
  drawSolidAllCubes(0);
  float[] deltaBeats2 = {1, 1, 1, -1, 1, .5, .5, -1, -1};
  currentBeatIndex = getMoveOnBeats(deltaBeats2, 8);


  if (currentBeatIndex >= 0) {
    if (currentBeatIndex != previousBeatIndex) {
      previousBeatIndex = currentBeatIndex;
      numBeatsIndex++;
    }
  }
  display4FaceLines(white, numBeatsIndex%4);
  drawImageCenteredMaxFitSole(screens[numBeatsIndex%4].s, theremin[numBeatsIndex%theremin.length]);
}

void crazySymbols() {
  int num = millis()/100%theremin.length;
  PImage p = theremin[num];

  drawImageCenteredMaxFitSole(screens[0].s, p);
  drawImageCenteredMaxFitSole(screens[3].s, p);

  num = millis()/100%symbols.length;
  p = symbols[num];
  drawImageCenteredMaxFitSole(screens[1].s, p);
  drawImageCenteredMaxFitSole(screens[2].s, p);

  displayLines(white);
}

void chillSymbols() {
  PImage p = theremin[((currentCycle-1)/4)%theremin.length];

  drawImageCenteredMaxFitSole(screens[0].s, p);
  drawImageCenteredMaxFitSole(screens[3].s, p);

  p = symbols[((currentCycle-1)/4) % symbols.length];
  drawImageCenteredMaxFitSole(screens[1].s, p);
  drawImageCenteredMaxFitSole(screens[2].s, p);

  displayLines(white);
}

void crazyDelta() {
  int h = int(hands[0].height*1.0*screenW/hands[0].width);
  if ((currentCycle-1)%2 == 0) {
    screens[0].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
    screens[3].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
  } else {
    screens[0].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
    screens[3].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
  }
  //PImage p = theremin[currentCycle % theremin.length];
  //drawImageCenteredMaxFitSole(screens[0].s, p);
  //drawImageCenteredMaxFitSole(screens[3].s, p);
  displaySymbolParticlesCenter();
}

void crazierDelta() {

  PImage p = symbols[currentCycle % symbols.length];
  float per = percentToNumBeats(4);
  if (per < 0.5) per = map(per, 0, .5, 255, 0);
  else per = map(per, .5, 1, 0, 255);
  for (int i = 0; i < 4; i+=3) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.noStroke();
    s.background(0);
    drawImageCenteredMaxFit(s, p);
    s.endDraw();
  }
  displaySymbolParticlesCenter();
}

void rotateDelta() {
  //float rot = PI/2 * numBeatsIndex;
  //for (int i = 0; i < 2; i++) {
  //  PGraphics s = screens[i*3].s;
  //  s.beginDraw();
  //  s.background(0);
  //  s.blendMode(BLEND);
  //  s.pushMatrix();
  //  s.translate(screenW/2, screenH/2);
  //  s.rotateZ(rot);
  //  s.image(hands[currentCycle%4], -screenW/2, -h/2, screenW, h);
  //  s.popMatrix();
  //  s.endDraw();
  //}
}


void initRite() {
  cues = new Cue[25];
  cues[0] = new Cue(0, 'v', 0, 0); // stars and constellations
  cues[1] = new Cue(8.4, 'v', 0.0, 0); // Y whale
  cues[2] = new Cue(16.4, 'v', 0.0, 0); // Y whale
  cues[3] = new Cue(24.3, 'v', 0.0, 0);  // X whale
  cues[4] = new Cue(32.3, 'v', 0.0, 0);  // X whale
  cues[5] = new Cue(40, 'v', 0.0, 0); // Woooo - sarah pumping wings
  cues[6] = new Cue(48.13, 'v', 0.0, 0); // Z - sarah pumping wings
  cues[7] = new Cue(56.09, 'v', 0.0, 0); // Z
  cues[8] = new Cue(64.00, 'v', 0.0, 0); // Z
  cues[9] = new Cue(71.9, 'v', 0.0, 0); // Z
  cues[10] = new Cue(79.6, 'v', 0.0, 0); // A
  cues[11] = new Cue(87.7, 'v', 0.0, 0); // A
  cues[12] = new Cue(95.5, 'v', 0.0, 0); /// BALLAD
  cues[13] = new Cue(103.6, 'v', 0.0, 0);/// BALLAD
  cues[14] = new Cue(111.5, 'v', 0.0, 0);/// BALLAD
  cues[15] = new Cue(119.5, 'v', 0.0, 0); /// BALLAD
  cues[16] = new Cue(127.35, 'v', 0.0, 0);// Woooo
  cues[17] = new Cue(135.4, 'v', 0.0, 0); // Woooo
  cues[18] = new Cue(143.3, 'v', 0.0, 0); // Z
  cues[19] = new Cue(151, 'v', 0.0, 0); // Z
  cues[20] = new Cue(159, 'v', 0.0, 0); // sax
  cues[21] = new Cue(167, 'v', 0.0, 0); // sax
  cues[22] = new Cue(174.5, 'v', 0.0, 0); // fade out
  cues[23] = new Cue(180, 'v', 0.0, 0);

  initConst();
  initMoth();
  initNodes(screens[0].s);
  //initNodesMain();
  initConstellationLines();

  cubesFront();
}

void deconstructRite() {
  constellationLines = null;
  constellations = null;
  nodes = null;
  nodesMain = null;
  body = null; 
  left = null; 
  right = null;
  handEyeClosing = null;
}

void displayRite() {
  if (!personOnPlatform) sphereScreen.blackOut();
  else {
    drawEye();

    updateNodeConstellationMainHand();
    displayNodeConstellationMain();
  }

  //displayMothFlyAcross(percentToNumBeats(64));
  //displayHandEyeAcrossAll(percentToNumBeats(64));
  //drawConstellationLines();


  switch(currentCue) {
  case 0:
    updateNodeConstellation(screens[0].s, screenH);
    for (int i = 0; i < 4; i++) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.background(0);
      //s.image(constellations[currentCycle/2%constellations.length], 0, 0);
      //drawImageCenteredMaxFit(screens[currentCycle/4%4].s, constellations[currentCycle/4%constellations.length]);
      displayNodeConstellation(s);
      s.endDraw();
    }
    break;
  case 1:
    nodesWhale();
    break;
  case 2:
    nodesWhale();
    break;
  case 3:
    nodesWhale();
    break;
  case 4:
    nodesWhale();
    break;
  case 5:
    displaySarahMothFlap();
    break;
  case 6:
    displaySarahMothFlap();
    break;
  case 7:
    displaySarahMothFlap();
    break;
  case 8:
    displaySarahMothFlap();
    break; 
  case 9:
    displaySarahMothFlap();
    break;
  case 10:
    cycleConst();
    break;
  case 11:
    cycleConst();
    break;
  case 12:
    displayHandEyeAcrossAll(percentToNumBeats(95.5, 64));
    break;
  case 13:
    displayHandEyeAcrossAll(percentToNumBeats(95.5, 64));
    break;
  case 14:
    displayHandEyeAcrossAll(percentToNumBeats(95.5, 64));
    break;
  case 15:
    displayHandEyeAcrossAll(percentToNumBeats(95.5, 64));
    break;
  case 16: // push const
    drawConstellationLinesHand();
    break;
  case 17:// push const
    drawConstellationLinesHand();
    break;
  case 18:
    drawConstellationLinesHand();
    break;
  case 19:
    drawConstellationLinesHand();
    break;
  case 20:
    cycleConst();
    break;
  case 21:
    cycleConst();
    break;
  case 22:
    cycleConst();
    fadeOutAllScreens(cues[currentCue].startT, 5);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void cycleConst() {
  updateNodeConstellation(screens[0].s, screenH);
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    //s.image(constellations[currentCycle/2%constellations.length], 0, 0);
    drawImageCenteredMaxFit(screens[currentCycle%4].s, constellations[currentCycle%constellations.length]);
    displayNodeConstellation(s);
    s.endDraw();
  }
}

void nodesWhale() {
  updateNodeConstellation(screens[0].s, screenH);
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    //s.image(constellations[currentCycle/2%constellations.length], 0, 0);
    //drawImageCenteredMaxFit(screens[currentCycle/4%4].s, constellations[currentCycle/4%constellations.length]);
    displayNodeConstellation(s);
    displaySwimWhale(s, i, percentToNumBeats(8, 64));

    s.endDraw();
  }
}



void initMoon() {

  if (backingTracks) {
    cues = new Cue[19];
    cues[0] = new Cue(6, 'v', 0, 0);
    cues[1] = new Cue(11, 'v', 0, 0);
    cues[2] = new Cue(64.7, 'v', 0, 0);
    cues[3] = new Cue(88, 'v', 0, 0);
    cues[4] = new Cue(95, 'v', 0, 0);
    cues[5] = new Cue(100, 'v', 0, 0);
    cues[6] = new Cue(114, 'v', 0, 0);
    cues[7] = new Cue(120, 'v', 0, 0);
    cues[8] = new Cue(124.9, 'v', 0, 0);
    cues[9] = new Cue(148.9, 'v', 0, 0);
    cues[10] = new Cue(172.5, 'v', 0, 0);
    cues[11] = new Cue(190.8, 'v', 0, 0);
    cues[12] = new Cue(208.8, 'v', 0, 0);
    cues[13] = new Cue(220.9, 'v', 0, 0);
    cues[14] = new Cue(232.9, 'v', 0, 0);
    cues[15] =  new Cue(256.8, 'v', 0.0, 0); 
    cues[16] =  new Cue(270, 'v', 0.0, 0); 
    cues[17] =  new Cue(280.9, 'v', 0.0, 0); 
    cues[18] =  new Cue(290.9, 'v', 0.0, 0);// end
  } else {
    cues = new Cue[18];
    //cues[0] = new Cue(0, 'v', 0, 0);
    //cues[1] = new Cue(5, 'v', 0.0, 0);
    //cues[2] = new Cue(58.7, 'v', 0.0, 0); 
    //cues[3] = new Cue(82.5, 'v', 0.0, 0); 
    //cues[4] = new Cue(88.8, 'v', 0.0, 0); 
    //cues[5] = new Cue(94.8, 'v', 0.0, 0); 
    //cues[6] = new Cue(108, 'v', 0.0, 0); 
    //cues[7] = new Cue(114, 'v', 0.0, 0); 
    //cues[8] = new Cue(118.9, 'v', 0.0, 0); 
    //cues[9] =  new Cue(142.9, 'v', 0.0, 0); // big boom
    //cues[10] =  new Cue(166.5, 'v', 0.0, 0); // calm
    //cues[11] =  new Cue(184.8, 'v', 0.0, 0);
    //cues[12] =  new Cue(202.8, 'v', 0.0, 0);
    //cues[13] =  new Cue(214.9, 'v', 0.0, 0);
    //cues[14] = new Cue(232.9, 'v', 0, 0);
    //cues[15] =  new Cue(230, 'v', 0.0, 0); 
    //cues[16] =  new Cue(238, 'v', 0.0, 0); 
    //cues[17] =  new Cue(243.0, 'v', 0.0, 0); // end
  }

  initStarSpace();
  drawSolidAll(color(0));
  currentImages.get(0).resize(sphereScreen.s.width, sphereScreen.s.height);
  cubesFront();
}

void deconstructMoon() {
  starsSpace = null;
}

void displayMoon() {
  int CONVERGE_CENTER = 0;
  int CONVERGE_VERT_LINE = 1;
  int DIAG_EXIT_VERT = 2;
  int CONVERGE_HORIZ_LINE = 3;
  int STATIC_STARS = 4;
  int DIVERGE_HORIZ_LINE = 5;
  int DIAG_EXIT_HORIZ = 6;
  int DIVERGE_VERT_LINE = 7;
  int LIGHT_SPEED = 8;

  if (!personOnPlatform) drawMoonSphere(currentImages.get(0));
  else drawEye();

  switch(currentCue) {
  case 0:    
    displayMoveSpaceAll(STATIC_STARS, 0.75);

    pulsing(color(255, 0, 0), percentToNumBeats(8));
    break;
  case 1: 
    displayMoveSpaceAll(STATIC_STARS, 0.86);

    pulsing(color(255, 0, 0), percentToNumBeats(8));
    break;
  case 2:
    displayMoveSpaceAll(DIVERGE_HORIZ_LINE, 0.86);

    pulsing(color(255, 0, 0), percentToNumBeats(8));
    break;
  case 3: 
    displayMoveSpaceAll(DIAG_EXIT_VERT, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 4: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 5: 
    displayMoveSpaceAll(DIVERGE_VERT_LINE, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 6: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 7: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 8: 
    displayMoveSpaceAll(LIGHT_SPEED, 0.86);

    displayLines(color(255, 0, 0));
    break;
  case 9:
    displayMoveSpaceAll(LIGHT_SPEED, 1);

    displayRandomLines(color(255, 0, 0));
    setLightning();

    break;
  case 10:
    displayMoveSpaceAll(DIVERGE_VERT_LINE, 0.66);

    displayLines(color(255, 0, 0));


    break;
  case 11:
    displayMoveSpaceAll(CONVERGE_VERT_LINE, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 12:
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 13:
    displayMoveSpaceAll(LIGHT_SPEED, 0.86);

    displayLines(color(255, 0, 0));
    resetFade(); 
    break;
  case 14:

    displayMoveSpaceAll(LIGHT_SPEED, 1);

    displayRandomLines(color(255, 0, 0));
    setLightning();
    break;
  case 15:
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, .9);
    displayLines(color(255, 0, 0));
    break;

  case 16: // fade out lines
    displayMoveSpaceAll(DIVERGE_VERT_LINE, .9);
    displayLines(color(255, 0, 0));
    startFadeLine = false;
    resetFade(); 
    break;
  case 17:
    displayMoveSpaceAll(CONVERGE_CENTER, 0.66);
    fadeOutAllScreens(cues[currentCue].startT, 8);

    displayLines(color(255, 0, 0));
    fadeOutAllLines(3, color(255, 0, 0));
    break;
  case 18: // fade out end
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void initLollies() {
  cues = new Cue[18];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(7.5, 'v', 0.0, 0);
  cues[2] = new Cue(21.8, 'v', 0.0, 0);
  cues[3] = new Cue(36, 'v', 0.0, 0);
  cues[4] = new Cue(50, 'v', 0.0, 0);
  cues[5] = new Cue(64, 'v', 0.0, 0);
  cues[6] = new Cue(78.8, 'v', 0.0, 0);
  cues[7] = new Cue(92.8, 'v', 0.0, 0);
  cues[8] = new Cue(107, 'v', 0.0, 0);
  cues[9] = new Cue(121, 'v', 0.0, 0);
  cues[10] = new Cue(135, 'v', 0.0, 0);
  cues[11] = new Cue(149.8, 'v', 0.0, 0);
  cues[12] = new Cue(164, 'v', 0.0, 0);
  cues[13] = new Cue(178, 'v', 0.0, 0);
  cues[14] = new Cue(192.5, 'v', 0.0, 0);
  cues[15] = new Cue(206.7, 'v', 0.0, 0);
  cues[16] = new Cue(213, 'v', 0.0, 0);
  cues[17] = new Cue(216, 'v', 0.0, 0);

  initSymbols();
  temp = createGraphics(screenW, screenH);
  initializeTriangulation(-1);
}

void deconstructLollies() {
  temp = null;
  symbols = null;
  pts = null;
  dt = null;
}

PGraphics temp, temp2;
int lastCueDelaunay = -2;

void displayLollies() {
  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else drawEye();

  initializeTriangulation(currentCue);

  if (currentCue == 0)  cycleCubeDelaunay(pink, pink);
  else if (currentCue < 16) {
    drawDelaunayTriAll();
    displayLines(pink);
  } else if (currentCue == 16) {
    drawDelaunayTriAll();
    fadeOutAllScreens(cues[currentCue].startT, 3);
    fadeOutAllLines(3, pink);
  } else {
    displayLines(color(0));
    drawSolidAll(color(0));
  }
}



void displayCycles() {
  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else drawEye();

  switch(currentCue) {
  case 0:
    mirrorVidCenter(vid1, -100, 0);
    break;
  case 1:
    drawSolidAll(color(0));
    drawImageAll(currentImages.get(0), 0, 0);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void initDirty() {
  cues = new Cue[17];

  //cues[2] = new Cue(22.07, 'v', 0, 0);
  //cues[4] = new Cue(60.69, 'v', 0, 0);
  cues[0] = new Cue(5.52, 'v', 0, 0);
  cues[1] = new Cue(11.03, 'v', 0, 0);
  cues[2] = new Cue(38.62, 'v', 0, 0);
  cues[3] = new Cue(49.66, 'v', 0, 0);
  cues[4] = new Cue(71.72, 'v', 0, 0);
  cues[5] = new Cue(82.76, 'v', 0, 0);
  cues[6] = new Cue(104.83, 'v', 0, 0);
  cues[7] = new Cue(115.86, 'v', 0, 0);
  cues[8] = new Cue(137.93, 'v', 0, 0);
  cues[9] = new Cue(154.48, 'v', 0, 0);
  cues[10] = new Cue(165.52, 'v', 0, 0);
  cues[11] = new Cue(176.55, 'v', 0, 0);
  cues[12] = new Cue(187.59, 'v', 0, 0);
  cues[13] = new Cue(198.62, 'v', 0, 0);
  cues[14] = new Cue(209.66, 'v', 0, 0);
  cues[15] = new Cue(217.93, 'v', 0, 0);
  cues[16] = new Cue(220, 'v', 0, 0);

  centerScreen = new Screen(screenW*2, screenH, -2);
  temp = createGraphics(screenW, screenH, P3D);
  temp2 = createGraphics(screenW*2, screenH, P3D);
  initSpaceRects();
}

void deconstructDirty() {
  terrain = null;
  sphereImg = null;
  centerScreen = null;
  temp = null;
  temp2 = null;
  spaceRects = null;
}

void displayDirty() {

  if (!personOnPlatform) {
    if (currentCue > 0) paradiseSphere(50, pink, blue, cyan); //displayStripedMoon(20);
  } else drawEye();

  colorMode(RGB, 255);
  switch(currentCue) { 
  case 0:
    fadeInAllLines(2, pink);
    break;

  case 1:
    glory();
    fadeInAllScreens(cues[currentCue].startT, 3);
    break;  
  case 2:
    fullGlory(-1);
    fadeInTopScreens(cues[currentCue].startT, 1.5);
    fadeInOutsideScreens(cues[currentCue].startT, 1.5);
    break;
  case 3:
    accordian();
    break;
  case 4:
    quietTime();
    break;
  case 5: 
    fullGlory(-1);
    fadeInTopScreens(cues[currentCue].startT, 1.5);
    break;
  case 6:
    fullGlory(0);
    break;
  case 7:
    accordian();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 8:
    quietTime();

    break;
  case 9:
    fullGlory(-1);
    fadeInOutsideScreens(cues[currentCue].startT, 1.5);
    break;
  case 10:
    fullGlory(-1);
    break;
  case 11:
    centerGlory();
    break;
  case 12:
    centerGlory();
    break;
  case 13:
    accordian();
    break;
  case 14:
    accordian();
    fadeOutAllScreens(cues[currentCue + 1].startT - 4, 4);
    break;
  case 15:
    drawSolidAll(color(0));
    fadeOutLinesCenterFocus(2, pink);
    break;
  default:     
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void centerGlory() {
  displayLinesCenterFocus(pink);
  resetSpaceRects(false);
  centerScreenFrontInner();
  displayCenterSpaceRects(5, -1, blue, cyan, pink);
  cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));

  platformSides();
}

void platformSides() {
  if (!personOnPlatform) drawVertDirtyOutside(percentToNumBeats(16));
  else drawVertDirtyOutsideHand();
}

void glory() {
  displayLines(pink);
  cubesFront();
  cyclingRects = true;
  displaySpaceRects(5, -1, pink, blue, cyan, false);
}

void accordian() {
  displayLinesCenterFocus(pink);
  cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));
  centerScreenFrontInner();
  displayTwoWayTunnels(percentToNumBeats(16));

  platformSides();
}

void fullGlory(int mode) {
  displayLines(pink);
  cubesFront();
  cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));
  displaySpaceRects(5, mode, pink, blue, cyan, false); 

  platformSides();
}

void quietTime() {
  displayLinesCenterFocus(pink);
  centerScreenFrontInner();
  displayLineBounceCenter(0.01, 50, cyan, pink, 5);
  drawSolidTop(color(0));

  if (personOnPlatform) drawVertDirtyOutsideHand();
}

//void initFifty() {
//  cues = new Cue[11];
//  cues[0] = new Cue(0, 'v', 0, 0); 
//  cues[1] = new Cue(6.5, 'v', 0.0, 0); // stop cycling rects
//  cues[2] = new Cue(19.5, 'v', 0.0, 0); // vocals come in; maybe single central slow rects w/ solid rects on top

//  cues[3] = new Cue(52, 'v', 0.0, 0); // "we're all coins"
//  cues[4] = new Cue(85, 'v', 0.0, 0); // teee tahhh tee tahh
//  cues[5] = new Cue(104, 'v', 0.0, 0); // same as 2; maybe this could be just a few solid shapes flying in
//  cues[6] = new Cue(120, 'v', 0.0, 0); 
//  cues[7] =  new Cue(136, 'v', 0.0, 0); // "we're all coins"
//  cues[8] =  new Cue(151, 'v', 0.0, 0);
//  cues[9] =  new Cue(172, 'v', 0.0, 0);  // teee tahhh tee tahh
//  cues[10] = new Cue(190, 'v', 0.0, 0);

//  drawSolidAll(color(0));
//  loadKeystone(LARGE_CENTER);
//  initSpaceRects();

//  resetFade();
//}

//void displayFifty() {
//  displayLinesCenterFocus(pink);

//  if (!personOnPlatform) sphereScreen.drawSolid(0);
//  else drawEye();

//  drawSolidOuter(color(0));

//  //colorMode(RGB, 255);
//  switch(currentCue) {   
//  case 0:

//    paradiseSphere(50, pink, blue, cyan);
//    cubesFront();

//    displaySpaceRects(5, -1, pink, blue, cyan); 
//    fadeInAllScreens(cues[0].startT, 3);
//    break;  
//  case 1:

//    paradiseSphere(50, pink, blue, cyan);
//    cubesFront();


//    displaySpaceRects(5, -1, pink, blue, cyan); 
//    cyclingRects = false;
//    hasResetRects = false;
//    break;
//  case 2:

//    paradiseSphere(50, pink, blue, cyan);
//    cyclingRects = false;
//    centerScreenFrontInner();
//    displayTwoWayTunnels();
//    fadeInCenter(cues[currentCue].startT, 2);
//    break;
//  case 3:
//    paradiseSphere(50, pink, blue, cyan);
//    centerScreenFrontInner();

//    displayLineBounceCenter(0.01, 50, cyan, pink, 5);
//    hasResetRects = false;
//    resetSpaceRects(false);
//    break;
//  case 4: 
//    cubesFront();
//    cyclingRects = true;
//    displaySpaceRects(5, 1, pink, blue, cyan);

//    break;
//  case 5:
//    cyclingRects = true;
//    resetSpaceRects(false);
//    paradiseSphere(50, 0, blue, cyan);


//    centerScreenFrontInner();

//    displayCenterSpaceRects(5, -1, blue, cyan, pink);
//    break;
//  case 6:
//    paradiseSphere(50, pink, blue, cyan);
//    cubesFront();
//    displaySpaceRects(5, -1, pink, blue, cyan); 
//    cyclingRects = true;
//    hasResetRects = false;
//    break;
//  case 7:
//    paradiseSphere(50, pink, blue, cyan);
//    centerScreenFrontInner();

//    displayLineBounceCenter(0.01, 50, cyan, pink, 5);
//    hasResetRects = false;
//    resetSpaceRects(false);

//    fadeOutCenter(cues[currentCue+1].startT - .5, .5);
//    break;
//  case 8:

//    paradiseSphere(50, pink, blue, cyan);
//    cyclingRects = false;
//    centerScreenFrontInner();
//    displayTwoWayTunnels();
//    fadeInCenter(cues[currentCue].startT, 2);
//    break;
//  case 9: // tee tahh
//    cubesFront();
//    cyclingRects = true;
//    displaySpaceRects(5, 1, pink, blue, cyan);

//    fadeOutAllScreens(cues[currentCue + 1].startT - 4, 4);
//    break;

//  default:     
//    drawSolidAll(color(0));
//    break;
//  }

//  //drawNeonRect(screens[1].s, 0, 0, 50, 50, 5, color(255));
//  //displayLines(color(255, 0, 255));
//}

void initWiz() {
  //initVid("scenes/wizrock/movies/1.mp4");
  cues = new Cue[11];
  cues[0] = new Cue(0, 'v', 0, 0); // intro
  cues[1] = new Cue(213, 'v', 0.0, 0);  // same as 1
  //cues[2] = new Cue(25.5, 'v', 0.0, 0); // 2
  cues[2] = new Cue(39, 'v', 0.0, 0);  // same as 1
  //cues[4] = new Cue(52, 'v', 0.0, 0);  // 2
  cues[3] = new Cue(65, 'v', 0.0, 0);  // "YOUU SUCCESS ..."
  // cues[6] = new Cue(78, 'v', 0.0, 0);
  cues[4] = new Cue(90.8, 'v', 0.0, 0);  // "paper cuts"
  cues[5] = new Cue(104, 'v', 0.0, 0);
  cues[6] = new Cue(117, 'v', 0.0, 0); // "hero"
  //cues[10] = new Cue(130, 'v', 0.0, 0);
  cues[7] = new Cue(143, 'v', 0.0, 0); // "YOUU SUCCESS ..."
  cues[8] = new Cue(168.9, 'v', 0.0, 0); // "paper cuts"
  cues[9] = new Cue(194, 'v', 0.0, 0); //
  cues[9] = new Cue(200, 'v', 0.0, 0); //
  cues[10] = new Cue(235, 'v', 0.0, 0);


  //loadKeystone(0);
  //initNodes(screens[0].s);
  //initTesseract();
  //initSquiggle(centerScreen.s);
  //initDrip(centerScreen.s);
  initDots(100);
  initAllFlowyWaves();

  //initNodesMain();
  initSymbols();
}

void deconstructWiz() {
  dotArray = null;
  tempImg = null;
  symbols = null;
}

boolean resetSquiggleLines = false;

void displayWiz() {
  if (!personOnPlatform) {
    gradientSphere(red, cyan, blue);
  } else {
    drawEye();
    //handsHorizFaceLines(cyan);
    //displayDots();
  }

  cubesFront();
  //tessPink();
  //wizPinkVidConst();
  //cubesFront();

  //updateNodeConstellationMain();
  //displayNodeConstellationMain();

  if (currentCue < cues.length -1) displayFlowyWavesWiz();
  else {
    displayLines(color(0));
    drawSolidAll(color(0));
  }

  //switch(currentCue) {
  //case 0:
  //  break;
  //case 1:
  //centerScreenFrontAll();
  //displaySquiggleParticles(centerScreen.s);
  //displayDripParticles(centerScreen.s);
  //  //resetSquiggleLines = true;
  //  break;
  //  //case 1:
  // 
  //  //break;
  //case 2:
  //  sineWaveVert(red, blue, percentToNumBeats(8), 0.8);
  //  break;
  //case 3:
  //  growShrinkBlockEntire(white, red, yellow, blue, percentToNumBeats(8));
  //  break;
  //case 4:
  //  pulseVertLongCenterBeat(red, percentToNumBeats(8));


  //  break;
  //case 5:
  //  linesGradientFaceCycle(red, black); 
  //  break;
  //case 6: 
  //  displayCycleSingleFaceLines(white, -1); 
  //  break;
  //case 7:
  //  snakeFaceAll(red, percentToNumBeats(8), 2);
  //  break;
  //case 8:
  //  pulsing(blue, percentToNumBeats(8));
  //  break;
  //case 9:
  //  transit(white, red, yellow, blue, percentToNumBeats(4));
  //  break;
  //default:
  //  drawSolidAll(color(0));
  //  break;
  //}
}

void tessPink() {
  updateTesseractBeat(0.03);
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(pink);
    displayTesseractNoBack(s);
    s.endDraw();
  }
}
void wizPinkVidConst() {
  updateNodeConstellation(screens[0].s);
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    //screens[i].s.image(vid1, -i*s.width, -100, s.width*2, s.height*s.width*2/s.width);
    if (i%2 == 0) s.image(vid1, 0, 0, s.width*vid1.height/s.height, s.height);
    else {
      s.pushMatrix();
      s.scale(-1.0, 1.0);
      s.image(vid1, -s.width, 0, s.width*vid1.height/s.height, s.height);
      s.popMatrix();
    }
    displayNodeConstellation(s);
    s.endDraw();
  }
}

void initMood() {
  //initVid("scenes/cycles/movies/vid1.mp4");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length()/1000.0 -1, 'v', 0.0, 0);
}

void deconstructMood() {
  vid1 = null;
  vid2 = null;
}

void displayMood() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    break;
  case 1:
    drawSolidAll(color(0));
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}


void initEllon() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(songFile.length()/1000.0-4, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length()/1000.0-1, 'v', 0.0, 0);

  centerScreen = new Screen(screenW*2, screenH, -2);
}

void deconstructEllon() {
  centerScreen = null;
}

void displayEllon() {
  centerScreenFrontAll();
  switch(currentCue) {
  case 0:
    drawDave();
    fadeInAllScreens(cues[currentCue].startT, 4);
    break;
  case 1:
    drawDave();
    fadeOutAllScreens(cues[currentCue].startT, 3);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void drawDave() {
  PImage p =  currentImages.get(0);
  PGraphics s = centerScreen.s;
  s.beginDraw();
  s.background(0);
  float factor = 0.9;
  int imgw = p.width;
  int imgh = p.height;
  if (imgw > imgh) {
    int h = int(1.0*s.width/imgw*imgh);
    int y = (s.height - h)/2;
    s.image(p, 0, y, s.width*factor, h*factor);
  } else {
    int w = int(1.0* s.height/imgh*imgw);
    int x = (s.width - w)/2;
    s.image(p, x, 0, w*factor, s.height*factor);
  }

  s.endDraw();
}

void initEgrets() {
  cues = new Cue[20];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(2, 'v', 0.0, 0); // sax
  //cues[2] = new Cue(9.5, 'v', 0.0, 0);
  cues[2] = new Cue(25.7, 'v', 0.0, 0); // cowbell
  cues[3] = new Cue(41, 'v', 0.0, 0); // do deedle do do da da doo 
  cues[4] = new Cue(57, 'v', 0.0, 0);  // sax
  cues[5] = new Cue(73, 'v', 0.0, 0);  // high sax
  cues[6] = new Cue(88.5, 'v', 0.0, 0); // doodle
  cues[7] = new Cue(104, 'v', 0.0, 0); // do deedle do do da da doo 
  cues[8] = new Cue(120, 'v', 0.0, 0); // sax
  cues[9] = new Cue(136, 'v', 0.0, 0); // sax
  cues[10] = new Cue(151.6, 'v', 0.0, 0);  // do deedle do do da da doo 
  cues[11] = new Cue(167, 'v', 0.0, 0);  // doodle
  cues[12] = new Cue(183, 'v', 0.0, 0); // doodle
  cues[13] = new Cue(191, 'v', 0.0, 0); // doodle
  cues[14] = new Cue(206, 'v', 0.0, 0); // doodle
  cues[15] = new Cue(222.5, 'v', 0.0, 0); // doodle shrink
  cues[16] = new Cue(238, 'v', 0.0, 0); // doodle shrink
  cues[17] = new Cue(254, 'v', 0.0, 0);
  cues[18] = new Cue(261, 'v', 0.0, 0); // done
  cues[19] = new Cue(264, 'v', 0.0, 0); // done
}

void deconstructEgrets() {
}

void displayEgrets() {
  //cycleShapeFFTTop();
  //cycleShapeFFTCubes();
  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else drawEye();
  stroke(255);
  fill(255);

  switch(currentCue) {
  case 0:
    break;
  case 1:
    transit(white, red, yellow, blue, percentToNumBeats(4));
    break;
  case 2:
    linesGradientFaceCycle(red, black); 
    break;
  case 3:
    snakeFaceAll(blue, percentToNumBeats(8), 2);
    break;
  case 4:
    pulseLinesCenterBeat(white, percentToNumBeats(4));
    break;
  case 5:
    pulseVertHorizCenterBeatCycle(red, blue, percentToNumBeats(4));
    break;
  case 6: 
    snakeFaceAll(yellow, percentToNumBeats(8), 2);
    break;
  case 7:
    sineWaveVert(red, blue, percentToNumBeats(8), 0.8);
    break;
  case 8:
    pulsing(blue, percentToNumBeats(8));
    break;
  case 9:
    pulsingCubes(white, white, percentToNumBeats(8));
    break;
  case 10:
    transit(white, red, yellow, blue, percentToNumBeats(4));
    break;
  case 11:
    growShrinkBlockEntire(white, red, yellow, blue, percentToNumBeats(8));
    break;
  case 12:
    displayCycleSingleFaceLines(white, -1); 
    break;
  case 13:
    pulseHorizLinesCenterBeat(red, percentToNumBeats(8));
    break;
  case 14:
    sineWaveVert(yellow, blue, percentToNumBeats(8), 0.8);
    break;
  case 15: 
    pulseLinesCenterBeat(white, percentToNumBeats(8));
    break;
  case 16:
    pulseVertLongCenterBeat(red, percentToNumBeats(8));
    break;
  case 17:
    pulsing(white, percentToNumBeats(8));
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void initIntro() {
  cues = new Cue[3];
  cues[0] = new Cue(4, 'v', 0, 0);
  cues[1] = new Cue(60*4+20-4, 'v', 0.0, 0);
  cues[2] = new Cue(60*4+20, 'v', 0.0, 0);

  //initSquiggle(screens[0].s);
  initDrip(screens[0].s);
}

void deconstructIntro() {
  particles_a = null;
  particles_b = null;
  particles_c = null;
}

void displayIntro() {
  //if (!personOnPlatform) sphereScreen.blackOut();
  //else drawEye();

  //switch(currentCue) {
  //case 0:    
  //  //displaySquiggleParticlesAll();
  //  displayDripParticlesAll();
  //  pulsing( color(255), percentToNumBeats(16));
  //  break;
  //case 1:
  //  //displaySquiggleParticlesAll();
  //  displayDripParticlesAll();
  //  break;
  //default:
  displayLines(color(0));
  drawSolidAll(color(0));
  //  break;
  //}
}

//////////////////////////////////////////////////////////////////////////////////
// CUE CLASS
//////////////////////////////////////////////////////////////////////////////////
Cue [] cues;
int currentCue = -1;
ArrayList<Gif> currentGifs;
ArrayList<PImage> currentImages;
int currentGif = -1;

class Cue {
  char type;
  float startT;
  float movieStartT;
  int gifNum;

  Cue(float tim, char t, float mt, int g) {
    startT = tim;
    type = t;
    movieStartT = mt;
    gifNum = g;
  }

  void initCue() {
    if (type == 'm') {
      vidIsPlaying = true;
      skipVid();
    } else {
      vidIsPlaying = false;
      pauseVids();
    }
    if (type == 'g') {
      currentGif = gifNum;
      for (Gif g : currentGifs) {
        g.noLoop();
      }
      currentGifs.get(currentGif).loop();
    }
  }

  void pauseCue() {
    pauseVids();
  }

  void skipVid() {
    if (type == 'm') {
      playVids();
      if (vid1 != null) {
        vid1.jump(songFile.position()*1.0/1000.0 - startT + movieStartT);
      }
    }
  }
}

void setCurrentCue() {
  int c = -1;

  for (Cue cue : cues) {
    if (songFile.position() >= cue.startT*1000) {
      c++;
      if (c >= cues.length-1) {
        c = cues.length -1;
        if (c != currentCue) {
          currentCue = c;
          cues[currentCue].initCue();
        }
        return;
      }
    } else {
      if (c != currentCue) {
        currentCue = c;
        if (c >= 0) cues[currentCue].initCue();
      }
      return;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// MIDI CUES
/////////////////////////////////////////////////////////////////////////////////////
void initMidi() {
  //MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, 1, "Gervill"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  myBus.sendTimestamps(false);
}

void checkMidiStart() {
  if (midiPlayed) {
    midiPlayed = false;
    println("--------------");
    println("START");
    startScene();
  }
}

void noteOn(int channel, int pitch, int velocity) {
  //printMidi("Note ON", channel, pitch, velocity);
  //lastMidi = millis();
  if (betweenSongs) {
    midiPlayed = true;
    println("MIDI CUE");
  }
  //println(">>>>>>>>>>>>>>>>>>");
}

void noteOff(int channel, int pitch, int velocity) {
  // printMidi("Note OFF", channel, pitch, velocity);
  // lastMidi = millis();
}

void printMidi(String message, int channel, int pitch, int velocity) {
  println();
  println(message);
  println("--------");
  println("Channel:"+channel);
  println("Pitch/ Number:"+pitch);
  println("Velocity/ Value:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  printMidi("Controller change", channel, number, value);
}

void displayCues() {
  int j = 0;
  for (Cue c : cues) {
    strokeWeight(1);
    noFill();
    float position = map( c.startT, 0, songFile.length()/1000.0, xSpace, xSpace+vW );
    float hue = map( c.startT, 0, songFile.length()/1000.0, 0, 255 );
    colorMode(HSB, 255);
    stroke(hue, 255, 255);
    if (c.startT < songFile.length()/1000.0) {
      line( position, ySpace, position, ySpace+vH );
      text(j++, position, ySpace + vH/2);
    }
    colorMode(RGB, 255);
  }
}

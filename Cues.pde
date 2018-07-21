import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;
int midiStartTime = 0;
boolean clickTrackStarted = false;
int previousCue = -2;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
//////////////////////////////////////////////////////////////////////////////////
void initViolate() {
  cues = new Cue[20];
  cues[0] = new Cue(5.33, 'v', 0, 0);
  cues[1] = new Cue(16, 'v', 0, 0);
  cues[2] = new Cue(26.67, 'v', 0, 0);
  cues[3] = new Cue(37.33, 'v', 0, 0);

  cues[4] = new Cue(48, 'v', 0, 0);
  cues[5] = new Cue(58.67, 'v', 0, 0);
  cues[6] = new Cue(66.67, 'v', 0, 0);
  cues[7] = new Cue(69.33, 'v', 0, 0);
  cues[8] = new Cue(90.67, 'v', 0, 0);
  cues[9] = new Cue(96, 'v', 0, 0);
  cues[10] = new Cue(106.67, 'v', 0, 0);
  cues[11] = new Cue(117.33, 'v', 0, 0);
  cues[12] = new Cue(125.33, 'v', 0, 0); // fast
  cues[13] = new Cue(128, 'v', 0, 0);
  cues[14] = new Cue(138.67, 'v', 0, 0);
  cues[15] = new Cue(149.33, 'v', 0, 0);

  cues[16] = new Cue(160, 'v', 0, 0);
  cues[17] = new Cue(181.33, 'v', 0, 0);
  cues[18] = new Cue(202.67, 'v', 0, 0);
  cues[19] = new Cue(217.33, 'v', 0, 0);



  cave = new OEJCave(screens[1].s);
  sphereImg = loadImage("images/sphere/1.jpg");
  //songFile = new Song(234 , 90);
}

void deconstructViolate() {
  cave = null;
}

// black as a gradient color

void displayViolate() {
  if (!personOnPlatform) displaySpiralSphere(cave.getSphereColor()); // cave.drawSphereGrid();
  else drawEye();

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
    if (currentCue > previousCue) platformOn();
    //cave.displayCaveLeftRightBounce();
    cave.displayCaveLeftRightBounceHand();
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
    if (currentCue > previousCue) platformOff();
    cave.changeAllColorSettings(0);
    break;
  case 6:
    caveFast();
    //cave.changeMovementSetting(CRISSCROSS);
    //cave.changeAllColorSettings(0);
    break;
  case 7:
    if (currentCue > previousCue) platformOn();
    cave.changeAllColorSettings(CAST_LIGHT_SIDE);
    break;
  case 8:
    cave.changeAllColorSettings(0);
    break;
  case 9:
    if (currentCue > previousCue) platformOff();
    cave.changeAllColorSettings(2);
    break;
  case 10:
    cave.changeMovementSetting(CRISSCROSS);
    cave.changeAllColorSettings(3);
    break;
  case 11:
    //cave.changeAllColorSettings(0);
    cave.displayCaveAllBounce();
    break;
  case 12: // fast
    cave.changeMovementSetting(0);
    caveFast();
    break;
  case 13:
    if (currentCue > previousCue) platformOn();
    //cave.displayCaveLeftRightBounce();
    cave.displayCaveLeftRightBounceHand();
    break;
  case 14:
    cave.changeMovementSetting(0);
    //cave.displayCaveLeftRightBounce();
    cave.displayCaveLeftRightBounceHand();
    break;
  case 15:
    if (currentCue > previousCue) platformOff();
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
    cave.changeMovementSetting(0);
    fadeOutAllScreens(cues[currentCue+1].startT-3, 4);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void caveFast() {
  float[] caveBeats = {.5, .5, .5, .5, .25, .25, .25, .25, 1};
  currentBeatIndex = getMoveOnBeats(caveBeats, 4);
  if (currentCue > previousCue) cave.changeGradAll();
  else if (currentBeatIndex >= 0) {
    if (currentBeatIndex != previousBeatIndex) {
      previousBeatIndex = currentBeatIndex;
      cave.changeGradAll();
    }
  }
}


void deconstructCycles() {
  clearVids();
}




void initSong() {
  initVid("scenes/song/movies/vid1.mov");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(getClickTrackLenSeconds(), 'm', getClickTrackLenSeconds(), 0);
  cues[2] = new Cue(getTrackLenSeconds(), 'v', 0, 0);


  //cues[0] = new Cue(1.67, 'v', 0, 0);
  ////cues[1] = new Cue(12.17, 'v', 0, 0);
  //cues[1] = new Cue(20.17, 'v', 0, 0);
  //cues[2] = new Cue(36.17, 'v', 0, 0);
  //cues[3] = new Cue(52.17, 'g', 0, 0);
  //cues[4] = new Cue(68.17, 'g', 0, 0);
  //cues[5] = new Cue(76.17, 'v', 0, 0);
  //cues[6] = new Cue(84.07, 'g', 0, 1);
  //cues[7] = new Cue(92, 'g', 0, 1);
  //cues[8] = new Cue(100.07, 'g', 0, 1);
  //cues[9] = new Cue(116.07, 'g', 0, 2);
  //cues[10] = new Cue(132.07, 'g', 0, 2);
  //cues[11] = new Cue(148.17, 'v', 0, 0);
  //cues[12] = new Cue(164.17, 'v', 0, 0);
  //cues[13] = new Cue(180.17, 'v', 0, 0);
  //cues[14] = new Cue(188.27, 'v', 0, 0);
  //cues[15] = new Cue(193.67, 'v', 0, 0);

  //currentGifs.get(3).loop();
  //currentGifs.get(4).loop();
  //currentGifs.get(currentGifs.size()-1).loop();
  //sphereImg = loadImage("images/sphere/grass.png");
  //initTreeBranchesAll();


  currentGifs.get(0).loop();
}

void deconstructSong() {
  sphereImg = null;
  paths = null;
  clearVids();
}

void displaySong() {
  switch(currentCue) {
  case 0:
    break;
  case 1:
    maskGifSphere();
    movieSong();
    break;
  case 2:
    break;
  }

  //if (!personOnPlatform) sphereScreen.drawImage(sphereImg, 0, 0, sphereScreen.s.width, sphereScreen.s.height); //sphereScreen.drawGif(currentGifs.get(currentGifs.size()-1), 0, 0, sphereScreen.s.width, sphereScreen.s.height);
  //else drawEye();

  //switch(currentCue) {
  //case 0:
  //  branchAll();

  //  break;
  //case 1:
  //  branchAll();
  //  break;
  //case 2:
  //  branchAll();
  //  break;
  //case 3: 

  //  treeRun(-1);
  //  //updateTreeBranches();
  //  //displayTreeBranchesOuter();
  //  drawSolidOuter(color(0));
  //  drawSolidTop(color(0));
  //  break;
  //case 4: 
  //  resetBranchOnCue();
  //  //drawSolidOuter(color(0));
  //  //updateTreeBranches();
  //  //displayTreeBranchesOuter();
  //  treeRun(-1);
  //  drawSolidOuter(color(0));
  //  drawSolidTop(color(0));
  //  break;
  //case 5: 
  //  //drawSolidAllCubes(color(0));
  //  branchAll();
  //  //pulseLinesCenterBeat(white, percentToNumBeats(8));
  //  break;
  //case 6: 
  //  drawSolidOuter(color(0));
  //  treeRun(3);
  //  break;
  //case 7:
  //  resetBranchOnCue();
  //  branchTopOut();
  //  treeRun(3);
  //  break;
  //case 8: 
  //  branchTopOut();
  //  //drawSolidOuter(color(0));
  //  treeRun(3);
  //  break;
  //case 9: 
  //  resetBranchOnCue();
  //  //drawSolidOuter(color(0));
  //  branchTopOut();
  //  treeRun(-1);
  //  break;
  //case 10: 

  //  treeRun(-1);
  //  break;
  //case 11: 
  //  drawSolidAllCubes(color(0));
  //  displayFractalTreeSong();
  //  break;
  //case 12: 
  //  displayFractalTreeSong();
  //  break;
  //case 13: 
  //  displayFractalTreeSong();
  //  break;
  //case 14: 
  //  displayFractalTreeSong();
  //  fadeOutAllScreens(cues[currentCue].startT, 5);
  //  break;
  //default:
  //  displayLines(color(0));
  //  drawSolidAll(color(0));
  //  break;
  //}
}
void resetBranchOnCue() {
  if (currentCue > previousCue) {
    previousCue = currentCue;
    resetTreeBranchesAll();
  }
}
void branchTopOut() {
  updateTreeBranches();
  displayTreeBranchesOuter();
  displayTreeBranchesTop();
}
void branchAll() {
  resetBranchOnCue();
  updateTreeBranches();
  displayTreeBranchesOuter();
  displayTreeBranchesInner();
  displayTreeBranchesTop();
  displayLinesOutsideFaces(color(55), color(55));
  displayLinesInnerFaces(color(255));
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
  //initVid("scenes/crush/movies/crush.mp4", "scenes/crush/movies/crushpanels.mp4");
  initVid("scenes/crush/movies/vid1.mov");
  initSphereVid("scenes/crush/movies/crushpanels.mp4");
  sphereImg = loadImage("images/sphere/grass.png");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(getClickTrackLenSeconds(), 'm', getClickTrackLenSeconds(), 0);
  cues[2] = new Cue(getTrackLenSeconds(), 'm', 0, 0);
  //cues[0] = new Cue(0, 'v', 0, 0);
  //cues[1] = new Cue(10.7, 'v', 0.0, 0);  // X
  //cues[2] = new Cue(25.88, 'v', 0.0, 0);  // X
  //cues[3] = new Cue(27.2, 'v', 0.0, 0);
  //cues[4] = new Cue(28.4, 'g', 0.0, 0);
  //cues[5] = new Cue(37.6, 'g', 0.0, 0);    

  //cues[6] = new Cue(56.47, 'g', 0.0, 2);  // alternate cubes?
  //cues[7] = new Cue(61.2+4.7, 'g', 0.0, 2);    // alternate cubes?
  //cues[8] = new Cue(70.6+4.7, 'v', 20.0, 4);    // X
  ////cues[6] = new Cue('v', 0, 75);   // X
  //cues[9] = new Cue(80+4.7, 'g', 0.0, 3);   // xylophone
  //cues[10] = new Cue(98.8+4.7, 'g', 0.0, 5);
  //cues[11] = new Cue(105.9, 'g', 0.0, 6);
  //cues[12] = new Cue(124.7, 'g', 0.0, 2);
  //cues[13] = new Cue(143.6, 'g', 0.0, 4);
  //cues[14] = new Cue(157.6+4.7, 'v', 0.0, 0);
  //cues[15] = new Cue(2*60 + 56.6+4.7, 'g', 0.0, 1);
  //cues[16] = new Cue(3*60 + 15.3+4.7, 'v', 0.0, 0);
  //cues[17] = new Cue(3*60 + 24+4.7, 'v', 0.0, 0);

  //initSphereBoxRot();
  // initTerrainCenter();
  //resetAudioAmp();
  //sphereImg = loadImage("images/sphere/1.jpg");
  //centerScreen = new Screen(screenW*2, screenH, -2);
  //centerScreenFrontInner();
  //initTerrain();
  //initTesseract();

  currentGifs.get(1).loop();
}

void deconstructCrush() {
  clearVids();
}

void displayCrush() {
  //int zCrush = 0;
  //if (!personOnPlatform) {
  //  //displayRedPlanetSphere();
  //  //zCrush = 0;
  //} else {
  //  drawEye();
  //  //zCrush = getZCrushHand();
  //}

  //maskGifSphere();


  switch(currentCue) {
  case 0:
    break;
  case 1:
    //movieCrush();
    screens[0].drawImage(currentGifs.get(1), 0, 0);
    screens[3].drawImage(currentGifs.get(1), 0, 0);
    displaySphereMovie(0, 0, sphereW, sphereW);
    movieCrush();

    sphereScreen.drawImage(sphereImg, 0, 0, sphereW, sphereW);
    fadeOutAllScreens(cues[currentCue+1].startT-3, 3);
    break;
  case 2:
    break;
  }

  //switch(currentCue) {
  //case 0:
  //  drawSolidAllCubes(0);
  //  break;
  //case 1: // spherebox
  //  displayLinesInnerFaces(white);
  //  displaySphereBoxCrush(zCrush);
  //  fadeInCubes(cues[currentCue].startT, 2);
  //  renderCubes = true;
  //  break;
  //case 2: // cube right
  //  renderCubes = false;
  //  drawSphereCrush(maskPoints[keystoneNum][3].x+150, 750, zCrush);

  //  drawSolidAllCubes(black);
  //  displayAllFaceLinesColor(0, 0, white, color(150));
  //  break;
  //case 3: // cube left
  //  renderCubes = false;
  //  drawSphereCrush(maskPoints[keystoneNum][1].x-150, 750, zCrush);
  //  drawSolidAllCubes(black);
  //  displayAllFaceLinesColor(white, color(150), 0, 0);
  //  break;
  //case 4: // oscillate outside, inside harom
  //  renderCubes = true;
  //  if (((currentCycle-1)/8)%2 == 0) {
  //    displayLinesOutsideFaces(color(255), color(255));
  //    drawSolidInner(0);
  //    for (int i = 0; i < screens.length; i+=3) {
  //      PGraphics s = screens[i].s;
  //      s.beginDraw();
  //      s.pushMatrix();
  //      s.translate(0, 0, zCrush);
  //      s.background(0);
  //      haromS(s, white, 3);
  //      s.popMatrix();
  //      s.endDraw();
  //    }
  //  } else {
  //    drawSolidOuter(0);
  //    displayLinesInnerFaces(white);
  //    for (int i = 1; i < 3; i++) {
  //      PGraphics s = screens[i].s;
  //      s.beginDraw();
  //      s.background(0);
  //      s.pushMatrix();
  //      s.translate(0, 0, zCrush);
  //      haromS(s, white, 3);
  //      s.popMatrix();
  //      s.endDraw();
  //    }
  //  }
  //  //haromTop(white, 3); 

  //  break;

  //case 5: // all chill
  //  //drawSolidTop(0);
  //  drawGifAllCrush(zCrush);

  //  break;
  //case 6: // inner
  //  displayLinesInnerFaces(white);
  //  drawSolidOuter(0);

  //  displayDivisionOfIntensityInner(percentToNumBeats(8), 0, 0, zCrush);
  //  break;
  //case 7:// puter
  //  //displayDivisionOfIntensityTop(percentToNumBeats(8), 0, 0);

  //  displayLinesOutsideFaces(color(255), color(255));
  //  drawSolidInner(0);
  //  displayDivisionOfIntensityOuter(percentToNumBeats(8), 0, 0, zCrush);
  //  break;
  //case 8:
  //  drawSolidAllCubes(color(0));

  //  //displayDivisionOfIntensityTop(percentToNumBeats(8), 0, 0);

  //  if ((currentCycle -1)/8%2 == 0) {
  //    displayAllFaceLinesColor(white, color(150), 0, 0);
  //    displayDivisionOfIntensity(screens[0].s, percentToNumBeats(8), 0, 0, zCrush);
  //    displayDivisionOfIntensity(screens[1].s, percentToNumBeats(8), 0, 0, zCrush);
  //  } else {
  //    displayAllFaceLinesColor(0, 0, white, color(150));
  //    displayDivisionOfIntensity(screens[2].s, percentToNumBeats(8), 0, 0, zCrush);
  //    displayDivisionOfIntensity(screens[3].s, percentToNumBeats(8), 0, 0, zCrush);
  //  }
  //  break;
  //case 9:
  //  drawSolidTop(0);
  //  drawGifAllCrush(zCrush);
  //  break;
  //case 10: 
  //  drawGifAllCrush(zCrush);
  //  break;
  //case 11: // spiral in groups of 2

  //  drawSolidAllCubes(color(0));
  //  int index = ((currentCycle -1)/4)%2;
  //  if (index == 0) displayAllFaceLinesColor(white, 0, white, 0);
  //  else displayAllFaceLinesColor(0, color(250), 0, color(150));
  //  for (int i = 0; i < 2; i++) {
  //    PGraphics s = screens[i*2 + index].s;
  //    s.beginDraw();
  //    s.blendMode(BLEND);
  //    s.pushMatrix();
  //    s.translate(0, 0, zCrush);
  //    s.background(0);
  //    s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
  //    s.popMatrix();
  //    s.endDraw();
  //  }
  //  break;
  //case 12: // 
  //  drawGifAllCrush(zCrush);
  //  break;
  //case 13: // 
  //  display4FaceLines(white, 1);
  //  display4FaceLines(white, 2);
  //  drawSolidOuter(0);
  //  currentGifDrawInner(zCrush);
  //  break;
  //case 14:
  //  //cycleAudioAmp(percentToNumBeats(4));
  //  displayTerrainAllCrush();
  //  break;
  //case 15: // draw the threshold
  //  displayLinesInnerFaces(white);
  //  for (int i = 1; i < 3; i++) {
  //    PGraphics s = screens[i].s;
  //    s.beginDraw();
  //    s.background(0);
  //    s.pushMatrix();
  //    s.translate(0, 0, zCrush);
  //    s.blendMode(BLEND);
  //    //s.background(color(180, 0, 80));
  //    if (i == 1) {
  //      s.pushMatrix();
  //      s.scale(-1.0, 1.0);

  //      s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);//-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
  //      s.popMatrix();
  //    } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
  //    s.filter(THRESHOLD, .2);
  //    s.blendMode(BLEND);
  //    s.popMatrix();
  //    s.endDraw();
  //  }
  //  break;
  //case 16:
  //  displaySphereBoxCrush(zCrush);
  //  fadeOutAllScreens(cues[currentCue+1].startT-3, 3);
  //  break;
  //default:
  //  displayLines(color(0));
  //  drawSolidAll(color(0));
  //  break;
  //}
}

boolean blackOutPlanet = false;
void resetRedPlanet() {
  if (!blackOutPlanet) {
    sphereScreen.blackOut();
    blackOutPlanet = true;
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

  //sphereImg = loadImage("images/sphere/spiralblue.jpg");
  initSphereBallDelta();
}

void deconstructDelta() {
  hands = null;
  theremin = null;
  symbols = null;
  nodes = null;
  sphereBall = null;
}

int previousBeatIndex = 0;
int currentBeatIndex = 0;
int numBeatsIndex = 0;

void displayDelta() {
  color spiralColor = color(#4D27FF);
  float rotHands = 0;

  if (!personOnPlatform) {
    rotHands = 0;
    //displaySpiralSphere();
    rotateSphereBall();
  } else {
    drawEye();
    drawWaveHands();
    rotHands = getRotHandsDelta();
  }


  innerScreensOut();

  switch(currentCue) {
  case 0:
    openCloseOutside(spiralColor, rotHands);

    break;
  case 1:
    alternateDelta(spiralColor, rotHands);
    break;
  case 2:
    chillSymbols(spiralColor);
    break;
  case 3:
    cycleHandsFFT(rotHands);
    displayLines(spiralColor);
    break;
  case 4:
    datDeltaBass(spiralColor, rotHands);
    break;
  case 5:
    crazyDelta(spiralColor, rotHands);
    break;
  case 6:
    chillSymbols(spiralColor);
    break;
  case 7:
    chillSymbols(spiralColor);
    break;
  case 8:
    crazySymbols(spiralColor);
    break;
  case 9:
    crazierDelta(spiralColor);
    break;
  case 10:
    crazyDelta(spiralColor, rotHands);
    break;
  case 11:
    crazyDelta(spiralColor, rotHands);
    break;
  case 12:
    datDeltaBass(spiralColor, rotHands);
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

void openCloseOutside(color c, float rotH) {
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
  for (int i = 0; i < 4; i+= 3) {
    drawRotateImageDelta(screens[i].s, p, rotH);
  }
  display4FaceLines(c, 0);
  display4FaceLines(c, 3);
}
void alternateDelta(color c, float rotH) {
  if ((currentCycle-1)/2%2 == 0) {
    drawRotateImageDelta(screens[0].s, hands[0], rotH);
    drawRotateImageDelta(screens[3].s, hands[4], rotH);
  } else {
    drawRotateImageDelta(screens[0].s, hands[4], rotH);
    drawRotateImageDelta(screens[3].s, hands[0], rotH);
  }
  display4FaceLines(c, 0);
  display4FaceLines(c, 3);
}

void drawRotateImageDelta(PGraphics s, PImage p, float rot) {
  s.beginDraw();
  s.background(0);
  s.pushMatrix();
  s.translate(s.width/2, s.height);
  s.rotateZ(rot);
  int w = int(1.0* s.height/p.height*p.width);
  s.image(p, -w/2, -screenH+50, w, screenH);
  s.popMatrix();
  s.endDraw();
}

void datDeltaBass(color c, float rotH) {
  drawSolidAllCubes(0);
  float[] deltaBeats2 = {1, 1, 1, -1, 1, .5, .5, -1, -1};
  currentBeatIndex = getMoveOnBeats(deltaBeats2, 8);


  if (currentBeatIndex >= 0) {
    if (currentBeatIndex != previousBeatIndex) {
      previousBeatIndex = currentBeatIndex;
      numBeatsIndex++;
    }
  }
  display4FaceLines(c, numBeatsIndex%4);
  drawRotateImageDelta(screens[numBeatsIndex%4].s, theremin[numBeatsIndex%theremin.length], rotH);
}

void crazySymbols(color c) {
  int num = millis()/100%theremin.length;
  PImage p = theremin[num];

  drawImageCenteredMaxFitSole(screens[0].s, p);
  drawImageCenteredMaxFitSole(screens[3].s, p);

  num = millis()/100%symbols.length;
  p = symbols[num];
  drawImageCenteredMaxFitSole(screens[1].s, p);
  drawImageCenteredMaxFitSole(screens[2].s, p);

  displayLines(c);
}

void chillSymbols(color c) {
  PImage p = theremin[((currentCycle-1)/4)%theremin.length];

  drawImageCenteredMaxFitSole(screens[0].s, p);
  drawImageCenteredMaxFitSole(screens[3].s, p);

  p = symbols[((currentCycle-1)/4) % symbols.length];
  drawImageCenteredMaxFitSole(screens[1].s, p);
  drawImageCenteredMaxFitSole(screens[2].s, p);

  displayLines(c);
}

void crazyDelta(color c, float rotH) {
  if ((currentCycle-1)%2 == 0) {
    drawRotateImageDelta(screens[0].s, hands[0], rotH);
    drawRotateImageDelta(screens[3].s, hands[4], rotH);
  } else {
    drawRotateImageDelta(screens[0].s, hands[4], rotH);
    drawRotateImageDelta(screens[3].s, hands[0], rotH);
  }
  //PImage p = theremin[currentCycle % theremin.length];
  //drawImageCenteredMaxFitSole(screens[0].s, p);
  //drawImageCenteredMaxFitSole(screens[3].s, p);
  displayLinesCenterFocus(c);
  displaySymbolParticlesCenter();
}

void crazierDelta(color c) {

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
  displayLinesCenterFocus(c);
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
  cues = new Cue[10];
  cues[0] = new Cue(3.85, 'v', 0, 0); // stars and constellations
  cues[1] = new Cue(12.25, 'v', 0, 0);// Y whale
  //cues[2] = new Cue(20.25, 'v', 0, 0); // Y whale
  //cues[3] = new Cue(27.25, 'v', 0, 0);// X whale
  //cues[4] = new Cue(36.15, 'v', 0, 0);// X whale
  //cues[5] = new Cue(40, 'v', 0.0, 0); // Woooo - sarah pum
  cues[2] = new Cue(43.85, 'v', 0, 0); // Z - sarah pumping wings
  //cues[6] = new Cue(51.98, 'v', 0, 0); // Z
  //cues[7] = new Cue(59.94, 'v', 0, 0); 
  //cues[8] = new Cue(67.85, 'v', 0, 0); // Z
  //cues[9] = new Cue(75.75, 'v', 0, 0); // Z
  cues[3] = new Cue(83.45, 'v', 0, 0);// A
  //cues[11] = new Cue(91.55, 'v', 0, 0);// A
  cues[4] = new Cue(99.35, 'v', 0, 0);
  //cues[13] = new Cue(107.45, 'v', 0, 0);/// BALLAD
  //cues[14] = new Cue(115.35, 'v', 0, 0);/// BALLAD
  //cues[15] = new Cue(123.35, 'v', 0, 0); /// BALLAD
  cues[5] = new Cue(131.2, 'v', 0, 0); // wooo
  //cues[17] = new Cue(139.25, 'v', 0, 0); // wooo
  //cues[18] = new Cue(147.15, 'v', 0, 0); // Z
  //cues[19] = new Cue(154.85, 'v', 0, 0); // Z
  cues[6] = new Cue(162.85, 'v', 0, 0); /// sax
  //cues[21] = new Cue(170.85, 'v', 0, 0);// sax
  //cues[22] = new Cue(178.35, 'v', 0, 0); 
  cues[7] = new Cue(183.85, 'v', 0, 0);
  cues[8] = new Cue(193.85, 'v', 0, 0); // fade
  cues[9] = new Cue(200.85, 'v', 0, 0);

  initConst();
  initMoth();
  initNodes(screens[0].s);
  //initNodesMain();
  initConstellationLines();

  cubesFront();
  initSphereBallRite();
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
  sphereBall = null;
}

void displayRite() {

  displayNodeConstellationsTop();
  if (!personOnPlatform) {
    updateNodeConstellation(screens[0].s, screenH);
    rotateSphereBall();
  } else {
    drawEye();
    updateNodeConstellationHand();
    //updateNodeConstellationMainHand();
    //displayNodeConstellationMain();
  }

  switch(currentCue) {
  case 0:
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
    displaySarahMothFlap();
    break;

  case 3:
    cycleConst();
    break;

  case 4:
    displayHandEyeAcrossAll(percentToNumBeats(95.5, 64));
    break;

  case 5: // push const
    drawConstellationLinesHand();
    break;
  case 6:
    cycleConst();
    break;

  case 7:
    displaySarahMothFlap();
    break;
  case 8:
    displaySarahMothFlap();
    fadeOutAllScreens(cues[currentCue].startT, 5);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void cycleConst() {
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
  for (int i = 0; i < 4; i++) {
    PGraphics s = screens[i].s;
    s.beginDraw();
    s.background(0);
    //s.image(constellations[currentCycle/2%constellations.length], 0, 0);
    //drawImageCenteredMaxFit(screens[currentCycle/4%4].s, constellations[currentCycle/4%constellations.length]);
    displayNodeConstellation(s);
    displaySwimWhale(s, i, percentToNumBeats(4, 64));

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
    cues[18] =  new Cue(getTrackLenSeconds(), 'v', 0.0, 0);// end
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
  clearVids();
}

void displayMoon() {
  color moonC = color(255);
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

    pulsing(moonC, percentToNumBeats(8));
    break;
  case 1: 
    displayMoveSpaceAll(STATIC_STARS, 0.86);

    pulsing(moonC, percentToNumBeats(8));
    break;
  case 2:
    displayMoveSpaceAll(DIVERGE_HORIZ_LINE, 0.86);

    pulsing(moonC, percentToNumBeats(8));
    break;
  case 3: 
    displayMoveSpaceAll(DIAG_EXIT_VERT, 0.66);

    displayLines(moonC);
    break;
  case 4: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(moonC);
    break;
  case 5: 
    displayMoveSpaceAll(DIVERGE_VERT_LINE, 0.66);

    displayLines(moonC);
    break;
  case 6: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(moonC);
    break;
  case 7: 
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(moonC);
    break;
  case 8: 
    displayMoveSpaceAll(LIGHT_SPEED, 0.86);

    displayLines(moonC);
    break;
  case 9:
    displayMoveSpaceAll(LIGHT_SPEED, 1);

    displayRandomLines(moonC);
    setLightning();

    break;
  case 10:
    displayMoveSpaceAll(DIVERGE_VERT_LINE, 0.66);

    displayLines(moonC);


    break;
  case 11:
    displayMoveSpaceAll(CONVERGE_VERT_LINE, 0.66);

    displayLines(moonC);
    break;
  case 12:
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, 0.66);

    displayLines(moonC);
    break;
  case 13:
    displayMoveSpaceAll(LIGHT_SPEED, 0.86);

    displayLines(moonC);
    resetFade(); 
    break;
  case 14:

    displayMoveSpaceAll(LIGHT_SPEED, 1);

    displayRandomLines(moonC);
    setLightning();
    break;
  case 15:
    displayMoveSpaceAll(DIAG_EXIT_HORIZ, .9);
    displayLines(moonC);
    break;

  case 16: // fade out lines
    displayMoveSpaceAll(DIVERGE_VERT_LINE, .9);
    displayLines(moonC);
    startFadeLine = false;
    resetFade(); 
    break;
  case 17:
    displayMoveSpaceAll(CONVERGE_CENTER, 0.66);
    fadeOutAllScreens(cues[currentCue].startT, 8);

    displayLines(moonC);
    fadeOutAllLines(3, moonC);
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
  cues[0] = new Cue(3.6, 'v', 0, 0);
  cues[1] = new Cue(10.67, 'v', 0, 0);
  cues[2] = new Cue(24.89, 'v', 0, 0);
  cues[3] = new Cue(39.11, 'v', 0, 0);
  cues[4] = new Cue(53.33, 'v', 0, 0);
  cues[5] = new Cue(67.56, 'v', 0, 0);
  cues[6] = new Cue(81.78, 'v', 0, 0);
  cues[7] = new Cue(96, 'v', 0, 0);
  cues[8] = new Cue(110.22, 'v', 0, 0);
  cues[9] = new Cue(124.44, 'v', 0, 0);
  cues[10] = new Cue(138.67, 'v', 0, 0);
  cues[11] = new Cue(152.89, 'v', 0, 0);
  cues[12] = new Cue(167.11, 'v', 0, 0);
  cues[13] = new Cue(181.33, 'v', 0, 0);
  cues[14] = new Cue(195.56, 'v', 0, 0);
  cues[15] = new Cue(209.78, 'v', 0, 0);
  cues[16] = new Cue(216, 'v', 0, 0);
  cues[17] = new Cue(218, 'v', 0, 0);
  //addClickTimes();

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
  initializeTriangulation(currentCue);

  //if (!personOnPlatform) displayLolliesSphere();
  //else drawEye();



  if (currentCue == 0)  cycleCubeDelaunay(pink, pink);
  else if (currentCue >= 0 && currentCue < 16) {
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


void initCycles() {
  initVid("scenes/cycles/movies/vid1.mov");  // "scenes/cycles/movies/vid2.mov");

  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(getClickTrackLenSeconds(), 'm', getClickTrackLenSeconds(), 0);
  cues[2] = new Cue(getTrackLenSeconds()-1, 'v', 0.0, 0);

  currentGifs.get(0).loop();
  currentGifs.get(1).loop();

  //sphereImg = loadImage("images/sphere/grass.png");
  initMaskGif();
}


void displayCycles() {
  //if (!personOnPlatform) sphereScreen.drawSolid(0);
  //else drawEye();


  sphereScreen.drawImage(currentGifs.get(0), 0, 0, sphereScreen.s.width, sphereScreen.s.height);
  //sphereScreen.drawImage(sphereImg, 0, 0, sphereW, sphereW);


  switch(currentCue) {
  case 1:
    centerVidCycles();
    displayLinesCenterFocus(color(#021A00));
    fadeOutAllScreens(cues[currentCue+1].startT-3, 3);
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

PShader galaxyShader;
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
  cues[16] = new Cue(getTrackLenSeconds(), 'v', 0, 0);

  centerScreen = new Screen(screenW*2, screenH, -2);
  temp = createGraphics(screenW, screenH, P3D);
  temp2 = createGraphics(screenW*2, screenH, P3D);
  initSpaceRects();
  initGalaxyShader();
}

void deconstructDirty() {
  terrain = null;
  sphereImg = null;
  centerScreen = null;
  temp = null;
  temp2 = null;
  spaceRects = null;
  galaxyShader = null;
}

void displayDirty() {

  if (!personOnPlatform) {
    galaxyMoveContinuous();
    if (currentCue > 0) paradiseSphere(50, pink, blue, cyan); //displayStripedMoon(20);
  } else {
    drawEye();
    galaxyMove();
  }
  println("dirty");
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
    if (currentCue > previousCue) platformOn(); 
    fullGlory(-1);
    fadeInOutsideScreens(cues[currentCue].startT, 1.5);
    break;
  case 3:
    accordian();
    break;
  case 4:

    quietTime();
    break;
  case 5: 
    if (currentCue > previousCue) platformOff(); 
    fullGlory(-1);
    //fadeInTopScreens(cues[currentCue].startT, 1.5);
    break;
  case 6:
    fullGlory(0);
    break;
  case 7:
    if (currentCue > previousCue) platformOn(); 
    accordian();
    //fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 8:
    quietTime();

    break;
  case 9:
    if (currentCue > previousCue) platformOff(); 
    fullGlory(-1);
    //fadeInOutsideScreens(cues[currentCue].startT, 1.5);
    break;
  case 10:
    fullGlory(-1);
    break;
  case 11:
    if (currentCue > previousCue) platformOn(); 
    centerGlory();
    break;
  case 12:
    centerGlory();
    break;
  case 13:
    accordian();
    break;
  case 14:
    if (currentCue > previousCue) platformOff(); 
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

void initGalaxyShader() {
  galaxyShader = loadShader("shaders/galaxy.glsl");
  galaxyShader.set("resolution", float(screenW*4), float(screenH));
}

void centerGlory() {
  innerFocusPlatformLines();

  centerScreenFrontInner();
  displayCenterSpaceRects(5, -1, blue, cyan, pink);
  //cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));

  platformSides();
}

void platformSides() {
  if (!personOnPlatform) drawVertDirtyOutside(percentToNumBeats(16));
  else drawVertDirtyOutsideHand();
}

void innerFocusPlatformLines() {
  if (!personOnPlatform) displayLinesCenterFocus(pink);
  else {
    displayLinesInnerOutline(pink);
    highlightLRFace();
  }
}

void allLinesPlatform() {
  if (!personOnPlatform) displayLines(pink);
  else {
    displayLinesInnerFaces(pink);
    highlightLRFace();
  }
}

void highlightLRFace() {
  if (mouseX < width/2) display4FaceLines(pink, 0);
  else display4FaceLines(pink, 3);
}



void glory() {
  resetSpaceRects();
  allLinesPlatform();
  cubesFront();
  cyclingRects = true;
  displaySpaceRects(5, -1, pink, blue, cyan, false);
}

void accordian() {
  resetSpaceRects();
  innerFocusPlatformLines();

  //cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));
  centerScreenFrontInner();
  displayTwoWayTunnels(percentToNumBeats(16));

  platformSides();
}

void fullGlory(int mode) {
  resetSpaceRects();

  allLinesPlatform();

  cubesFront();
  //cycleShapeFFTTop(getColorOnBeat(pink, blue, cyan));
  displaySpaceRects(5, mode, pink, blue, cyan, false); 

  platformSides();
}

void quietTime() {
  innerFocusPlatformLines();

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

FlockingClass fc;

void initWiz() {
  //initVid("scenes/wizrock/movies/1.mp4");
  cues = new Cue[10];
  //cues[0] = new Cue(0, 'v', 0, 0); // intro
  //cues[1] = new Cue(3.54, 'v', 0, 0); // // start
  //cues[2] = new Cue(16.6, 'v', 0, 0);  // voice comes in, change color
  //cues[3] = new Cue(42.55, 'v', 0, 0); // change color
  //cues[4] = new Cue(55.5, 'v', 0, 0); 
  //cues[5] = new Cue(68.4, 'v', 0, 0); // big paper cuts
  //cues[6] = new Cue(94.4, 'v', 0, 0); 
  //cues[7] = new Cue(107.4, 'v', 0, 0); // back to orig
  //cues[8] = new Cue(133.3, 'v', 0, 0); // big
  //cues[9] = new Cue(172.2, 'v', 0, 0); // something diff?
  //cues[10] = new Cue(185.2, 'v', 0, 0); // back
  //cues[11] = new Cue(213, 'v', 0, 0);  // fading outs

  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(3.2, 'v', 0, 0);
  cues[2] = new Cue(28.6, 'v', 0, 0);
  cues[3] = new Cue(69.16, 'v', 0, 0);

  cues[4] = new Cue(107.31, 'v', 0, 0);
  cues[5] = new Cue(132.74, 'v', 0, 0);
  cues[6] = new Cue(172.48, 'v', 0, 0);
  cues[7] = new Cue(185.19, 'v', 0, 0);
  cues[8] = new Cue(198.7, 'v', 0, 0);
  cues[9] = new Cue(getTrackLenSeconds(), 'v', 0, 0);
  //initDots(100);
  //initAllFlowyWaves();
  //initNodesMain();
  //initSymbols();

  //initSquiggle(screens[0].s);
  //initDrip(screens[0].s);



  fc = new FlockingClass(this);
}

void deconstructWiz() {
  //dotArray = null;
  //tempImg = null;
  //symbols = null;
  //particles_a = null;
  //particles_b = null;
  //particles_c = null;
  fc = null;
}

boolean resetSquiggleLines = false;

void displayWiz() {
  if (!personOnPlatform) {
    //gradientSphere(red, cyan, blue);
    if (currentCue > 0) fc.flockingSphere();
  } else {
    drawEye();
    //handsHorizFaceLines(cyan);
    //displayDots();
  }

  cubesFront();

  //updateNodeConstellationMain();
  //displayNodeConstellationMain();

  switch(currentCue) {
  case 0:
    //drawSolidAllCubes(color(255));
    break;
  case 1:
    blackBoids();
    break;
  case 2:
    bounceCircleFlocking(fc.NOISE_MODE);
    //displaySquiggleParticlesAll();
    //displayDripParticlesAll();
    break;
  case 3:
    bounceCircleFlocking(fc.NOISE_MODE);
    break;
  case 4:
    bounceCircleFlocking(fc.NOISE_MODE);
    break;
  case 5:
    bleed();
    break;
  case 6:
    lineBoids();
    break;
  case 7:
    bleed();
    break;
  case 8:
    blackBoids();
    break;
  case 9:
    lineBoids();
    break;
  case 10:
    bounceCircleFlocking(fc.NOISE_MODE);
    fadeOutAllScreens(cues[currentCue+1].startT-3, 3);
    break;

  default:
    drawSolidAll(color(0));
    break;
  }
}

void lineBoids() {
  bounceFlocking(fc.NOISE_MODE, 1);
}

void blackBoids() {
  fc.shapeMode = 0;
  if (currentCue != previousCue) {
    fc.currentBackgroundC = 0;
    fc.newNoiseWht();
    fc.shapeMode = 0;
  }
  fc.displayFlockAll(fc.NOISE_MODE);
  fc.updatePhysics(fc.NOISE_MODE);
}

void bleed() {
  fc.shapeMode = 0;
  if (getSongPositionSeconds() < 72) attractMode = false;
  else if (getSongPositionSeconds() < 81.3) attractMode = true;
  else if (getSongPositionSeconds() < 86) attractMode = false;
  else if (getSongPositionSeconds() < 88) attractMode = true;
  else if (getSongPositionSeconds() < 94) attractMode = false;
  else if (getSongPositionSeconds() < 100.3) attractMode = true;
  else if (getSongPositionSeconds() < 140) attractMode = false;
  else if (getSongPositionSeconds() < 146) attractMode = true;
  else if (getSongPositionSeconds() < 150) attractMode = false;
  else if (getSongPositionSeconds() < 153) attractMode = true;
  else attractMode = false;
  //else if (songFile.position()/1000.0 < 162) attractMode = false;
  //else if (songFile.position()/1000.0 < 140) attractMode = true;


  if (currentCue != previousCue) {
    fc.currentBackgroundC = color(255);
    colorMode(RGB);
    fc.agentC1 = color(255, 0, 0);
    fc.agentC2 = color(230, 60, 0);
    drawSolidAllCubes(fc.currentBackgroundC);
  }
  fc.displayFlockAll(fc.FLOCKING_MODE);
  fc.updatePhysics(fc.FLOCKING_MODE);
}

void bounceCircleFlocking(int moveMode) {
  bounceFlocking(moveMode, 0);
}

void bounceFlocking(int moveMode, int lineMode) {
  fc.shapeMode = lineMode;
  //if (currentCue < 6) {
  //  if (currentCue != previousCue || (currentCycle != previousCycle && percentToNumBeats(0.77, 8) < 0.1)) fc.newNoise();
  //} else {
  //  if (currentCue != previousCue || (currentCycle != previousCycle && percentToNumBeats(0.77 + getBarLenSeconds(), 8) < 0.1)) fc.newNoise();
  //}
  if (currentCue != previousCue || (currentCycle != previousCycle && ((currentCycle-1)%8==0))) fc.newNoise();
  fc.displayFlockAll(moveMode);
  fc.updatePhysics(moveMode);
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
  initSphereVid("scenes/mood/movies/sphere.mp4");
  initVid("scenes/mood/movies/vid1orig.mov");
  currentGifs.get(0).loop();

  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(getClickTrackLenSeconds(), 'm', getClickTrackLenSeconds(), 0);
  cues[2] = new Cue(getTrackLenSeconds(), 'v', 0.0, 0);
}

void deconstructMood() {
  vid1 = null;
  vid2 = null;
}

void displayMood() {
  //displaySphereMovieCentered(.6);
  displaySphereMovie(0, 0, sphereW, sphereW);

  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    break;
  case 1:
    moodMovie();
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
  cues[1] = new Cue(getTrackLenSeconds()-3, 'v', 0.0, 0);
  cues[2] = new Cue(getTrackLenSeconds(), 'v', 0.0, 0);

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
  cues[19] = new Cue(263.5, 'v', 0.0, 0); // done

  //initDots(100);
}

void deconstructEgrets() {
}

void displayEgrets() {
  //cycleShapeFFTCubes();
  //if (!personOnPlatform) {
  //displayDots();
  //handEgrets();
  //}
  //sphereScreen.drawSolid(0);
  //else drawEye();
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
}

void deconstructIntro() {
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
      pauseVids();
      if (vid1 != null) {
        vid1.jump(getSongPositionSeconds() - startT + movieStartT);
      }
      if (vid2 != null) {
        vid2.jump(getSongPositionSeconds() - startT + movieStartT);
      }
      if (sphereMovie != null) {
        sphereMovie.jump(getSongPositionSeconds() - startT + movieStartT);
      }
      playVids();
    }
  }
}

void setCurrentCue() {
  int c = -1;

  for (Cue cue : cues) {
    if (getSongPositionSeconds() >= cue.startT*1000) {
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
    float position = map( c.startT, 0, getTrackLenSeconds(), xSpace, xSpace+vW );
    float hue = map( c.startT, 0, getTrackLenSeconds(), 0, 255 );
    colorMode(HSB, 255);
    stroke(hue, 255, 255);
    if (c.startT < getTrackLenSeconds()) {
      line( position, ySpace, position, ySpace+vH );
      text(j++, position, ySpace + vH/2);
    }
    colorMode(RGB, 255);
  }
}

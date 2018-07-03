import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
//////////////////////////////////////////////////////////////////////////////////
void initViolate() {
  cues = new Cue[22];
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
  cues[21] = new Cue(235, 'v', 0.0, 0);
  tempo = 90;
  initCaveOEJ(screens[1].s);

  //songFile = new Song(234 , 90);
}

// black as a gradient color

void displayViolate() {
  displayLines(0);
  drawCaveScreens();
  switch(currentCue) {
  case 0:
    changeAllColorSettings(0);
    break;
  case 1: // something some come in bouncing on the beat
    displayCaveAllBounce();
    println(colorSettings[0]);
    break;
  case 2: // left, right, left, right
    displayCaveLeftRightBounce();
    break;
  case 3:
    changeAllColorSettings(0);
    break;
  case 4:
    //changeAllColorSettings(RAINBOW_PULSE);
    changeAllColorSettings(CAST_LIGHT);
    break;
  case 5:
    //changeMovementSetting(CRISSCROSS);
    changeAllColorSettings(0);
    break;
  case 6:
    changeMovementSetting(CRISSCROSS);
    displayCaveLeftRightBounce();
    break;
    //case 7:
    //  changeAllColorSettings(6);
    //  break;
    //case 8:
    //  changeAllColorSettings(0);
    //  break;
    //case 9:
    //  changeAllColorSettings(1);
    //  break;
    //case 10:
    //  changeAllColorSettings(2);
    //  break;
    //case 11:
    //  break;
    //case 12:
    //  break;

    ///////////////////////////////// DONE
  case 16:
    displayCaveAllBounce();
    changeMovementSetting(BOUNCE);
    break;
  case 17: 
    changeAllColorSettings(RANDOM);
    changeMovementSetting(BOUNCE);
    break;
  case 18: 
    changeAllColorSettings(ICE);
    changeMovementSetting(BOUNCE);
    break;
  case 19:
    changeAllColorSettings(GRAD_ALL);
    break;
  case 20:
    fadeOutAllScreens(cues[currentCue].startT, 1);
    break;
  default:
    displayCaveAllBounce();
    break;
  }
}


void initRite() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}

void initLollies() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}

void initCycles() {
  initVid("scenes/cycles/movies/vid1.mp4");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}





void initMood() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}
void initSong() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}
void initEllon() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}
void initEgrets() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
}

//////////////////////////////////////////////////////////////////////////////////
// DISPLAY CUES
//////////////////////////////////////////////////////////////////////////////////
void initCrush() {
  initVid("scenes/crush/movies/crush.mp4");
  cues = new Cue[11];
  cues[0] = new Cue(0, 'm', 0, 0);
  //cues[1] = 5;
  //cues[2] = 9.7;   // X
  //cues[3] = 14.4;  // X
  //cues[4] = 17.0;  // Break happens
  //cues[5] = 19;    // X
  cues[1] = new Cue(28.8, 'v', 0.0, 0);   // chords slow
  cues[2] = new Cue(38, 'g', 0.0, 0);    // chords slow
  cues[3] = new Cue(47.5, 'g', 0.0, 1);  // guitar
  cues[4] = new Cue(56, 'g', 0.0, 2);    // guitar
  cues[5] = new Cue(66, 'm', 20.0, 0);    // X
  //cues[6] = new Cue('v', 0, 75);   // X
  cues[6] = new Cue(85, 'g', 0.0, 3);   // xylophone
  cues[7] = new Cue(94, 'v', 0.0, 0);
  cues[8] = new Cue(103.8, 'v', 0.0, 0);
  cues[9] = new Cue(135, 'v', 0.0, 0);
  cues[10] = new Cue(songFile.length(), 'v', 0.0, 0);
}

void displayCrush() {
  switch(currentCue) {
  case 0:
    movieAcrossAll(vid1, -350);
    haromCenter(color(255), 3, 180);
    //displayNervous();
    //displayWavyCircle();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  case 2:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 3:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 4:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 5:
    movieAcrossAll(vid1, -370);
    break;
  case 6:
    drawSolidAll(color(0));
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void initDelta() {
  tempo = 133;
  cues = new Cue[10];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(36, 'g', 0.0, 0); // derrr neener derrr
  cues[2] = new Cue(50.6, 'v', 0.0, 0); // "help meee coffee"
  cues[3] = new Cue(72.2, 'v', 0.0, 0);  // wooo
  cues[4] = new Cue(101, 'v', 0.0, 0);  // "delta waves"
  cues[5] = new Cue(115, 'v', 0.0, 0);
  cues[6] = new Cue(137, 'v', 0.0, 0);// woo
  cues[7] = new Cue(166, 'v', 0.0, 0);
  cues[8] = new Cue(199, 'v', 0.0, 0);
  cues[9] = new Cue(203, 'v', 0.0, 0);
  initAllFlowyWaves();
  cubesFront();
}

void deconstructDelta() {
}

void displayDelta() {
  stroke(255, 0, 255);


  switch(currentCue) {
  case 0:
    displayFlowyWavesAll();
    //displayCycleFaceLines(0, color(255, 0, 255));
    break;
  case 1:
    //drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    cycleHandsFFT();
    displayFlowyWavesAll();
    break;
  case 2:
    cycleHandsFFT();
    displayFlowyWavesAll();
    break;
  case 3:
    //drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 4:
    displayFlowyWavesAll();
    break;
  case 5:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 6:
    displayFlowyWavesAll();
    break;
  case 7:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 8:
    displayFlowyWavesAll();
    break;
  case 9:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 10:
    displayFlowyWavesAll();
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void displayRite() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawImageAll(currentImages.get(0), 0, 0);
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}


void initMoon() {
  Cue[] cuesT = {
    new Cue(0, 'v', 0, 0), 
    new Cue(5, 'v', 0.0, 0), 
    new Cue(58.7, 'v', 0.0, 0), 
    new Cue(82, 'v', 0.0, 0), 
    new Cue(89, 'v', 0.0, 0), 
    new Cue(94, 'v', 0.0, 0), 
    new Cue(108, 'v', 0.0, 0), 
    new Cue(114, 'v', 0.0, 0), 
    new Cue(118, 'v', 0.0, 0), 
    new Cue(142, 'v', 0.0, 0), // big boom
    new Cue(166.5, 'v', 0.0, 0), // calm
    new Cue(230, 'v', 0.0, 0), 
    new Cue(238, 'v', 0.0, 0), 
    new Cue(243.0, 'v', 0.0, 0) // end
  };
  cues = cuesT;
  drawSolidAll(color(0));
  //loadKeystone(LARGE_CENTER);
  currentImages.get(0).resize(sphereScreen.s.width, sphereScreen.s.height);
  startFade = false;
  centerScreenFrontAll();
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
  drawMoonSphere(currentImages.get(0));
  switch(currentCue) {
  case 0:    
    displayMoveSpaceCenterCycle(0.75);

    pulsing(0, 1);
    break;
  case 1: 
    displayMoveSpaceCenter(STATIC_STARS, 0.86);

    pulsing(0, 1);
    break;
  case 2:
    displayMoveSpaceCenter(DIVERGE_HORIZ_LINE, 0.86);

    pulsing(0, 1);
    break;
  case 3: 
    displayMoveSpaceCenter(DIAG_EXIT_VERT, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 4: 
    displayMoveSpaceCenter(DIAG_EXIT_HORIZ, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 5: 
    displayMoveSpaceCenter( DIVERGE_VERT_LINE, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 6: 
    displayMoveSpaceCenter(8, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 7: 
    displayMoveSpaceCenter(9, 0.66);

    displayLines(color(255, 0, 0));
    break;
  case 8: 
    displayMoveSpaceCenter(LIGHT_SPEED, 0.86);

    displayLines(color(255, 0, 0));
    break;
  case 9:
    displayMoveSpaceCenter(LIGHT_SPEED, 1);

    displayRandomLines(color(255, 0, 0));

    break;
  case 10:
    displayMoveSpaceCenter(LIGHT_SPEED, 1);

    displayRandomLines(color(255, 0, 0));

    resetFade();  
    break;
  case 11: // fade out end
    displayMoveSpaceCenter(CONVERGE_CENTER, 0.75); 
    fadeOutAllScreens(cues[currentCue].startT, 8);

    displayLines(color(255, 0, 0));
    startFadeLine = false;
    break;
  case 12: // fade out lines
    drawSolidAll(color(0));
    fadeOutAllLines(3, color(255, 0, 0));
    break;
  default:
    displayLines(color(0));
    drawSolidAll(color(0));
    break;
  }
}

void displayLollies() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    //drawFFTBarsCubes();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}


void displayCycles() {
  switch(currentCue) {
  case 0:
    mirrorVidCenter(vid1, -100, 0);
    break;
  case 1:
    drawSolidAll(color(0));
    drawImageAll(currentImages.get(0), 0, 0);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void initDirty() {
  cues = new Cue[11];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(11, 'v', 0.0, 0); // tic toc begins
  cues[2] = new Cue(33.4, 'v', 0.0, 0); // tic toc repeat
  cues[3] = new Cue(55, 'v', 0.0, 0); // down chords
  cues[4] = new Cue(77, 'v', 0.0, 0);  // tic toc
  cues[5] = new Cue(99, 'v', 0.0, 0);  // down chords
  cues[6] = new Cue(121, 'v', 0.0, 0);  // guitar
  cues[7] = new Cue(143.5, 'v', 0.0, 0);  // tic toc
  cues[8] = new Cue(165.5, 'v', 0.0, 0);  // down chords
  cues[9] = new Cue(178, 'v', 0.0, 0);  // fade out
  cues[10] = new Cue(184, 'v', 0.0, 0);  // end

  drawSolidAll(color(0));
  loadKeystone(MID_CENTER);
  initSpaceRects();

  resetFade();
  initTerrainCenter();
  initTesseract();
  centerScreenFrontInner();

  initZZoom();
  resetAudioAmp();
  tempo = 87;
}

void displayDirty() {
  displayStripedMoon(20);
  switch(currentCue) {
  case 0:
    centerScreenFrontInner();

    zoomTerrain(cues[currentCue].startT, cues[currentCue + 1].startT);
    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    //displayCycleSingleFaceLines(white, -1);
    fadeInAllScreens(cues[currentCue].startT, 4);
    break;
  case 1: // tic toc
    zZoom = endingTerrain;
    centerScreenFrontInner();
    startAudioAmp();
    displayCycle4FaceLines(white);
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[1].startT, cues[2].startT, 1, 1);
    cycleAudioAmp(percentToNumBeats(4));

    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    cycleShapeFFTTop();
    break;
  case 2: // tic toc repeat
    zZoom = endingTerrain;
    centerScreenFrontInner();
    fadeAudioLev(cues[currentCue].startT, cues[currentCue+1].startT, 1, 1);
    setGridTerrain(1, 1); // sin
    displayTerrainCenter();
    cycleShapeFFTTop();
    break;
  case 3: // dooo, doo, do
    cubesFront();
    drawSolidTop(color(0));
    displayDivisionOfIntensity2Screens(percentToNumBeats(8), 0, 0);
    fadeOutCubes(cues[currentCue + 1].startT - 2, 2);
    //display3DDots2Screens(100, 0, 0.005);
    //displayTesseract2Screens();
    break;
  case 4: // tic toc
    zZoom = endingTerrain;
    centerScreenFrontInner();
    startAudioAmp();
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1, 1);
    cycleAudioAmp(percentToNumBeats(4));

    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    cycleShapeFFTTop();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 5:
    cubesFront();
    drawSolidTop(color(0));
    displayDivisionOfIntensity2Screens(percentToNumBeats(8), 0, 0);
    fadeOutCubes(cues[currentCue + 1].startT - 2, 2);
    break;
  case 6: 
    // something up top?
    cubesFront();
    displayNervous2Screens();
    fadeInCubes(cues[currentCue].startT, 2);
    fadeOutCubes(cues[currentCue + 1].startT - 2, 2);
    break;
  case 7: // tic toc
    zZoom = endingTerrain;
    centerScreenFrontInner();
    startAudioAmp();
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1, 1);
    cycleAudioAmp(percentToNumBeats(4));

    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    cycleShapeFFTTop();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 8:
    resetFade();
    break;
  case 9:
    fadeOutAllScreens(cues[currentCue].startT, 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void initFifty() {
  cues = new Cue[11];
  cues[0] = new Cue(0, 'v', 0, 0); 
  cues[1] = new Cue(6.5, 'v', 0.0, 0); // stop cycling rects
  cues[2] = new Cue(19.5, 'v', 0.0, 0); // vocals come in; maybe single central slow rects w/ solid rects on top

  cues[3] = new Cue(52, 'v', 0.0, 0); // "we're all coins"
  cues[4] = new Cue(85, 'v', 0.0, 0); // teee tahhh tee tahh
  cues[5] = new Cue(104, 'v', 0.0, 0); // same as 2; maybe this could be just a few solid shapes flying in
  cues[6] = new Cue(120, 'v', 0.0, 0); 
  cues[7] =  new Cue(136, 'v', 0.0, 0); // "we're all coins"
  cues[8] =  new Cue(151, 'v', 0.0, 0);
  cues[9] =  new Cue(172, 'v', 0.0, 0);  // teee tahhh tee tahh
  cues[10] = new Cue(190, 'v', 0.0, 0);

  drawSolidAll(color(0));
  loadKeystone(LARGE_CENTER);
  initSpaceRects();

  resetFade();

  tempo = 120;
}

void displayFifty() {
  drawSolidOuter(color(0));

  //colorMode(RGB, 255);
  switch(currentCue) {   
  case 0:

    paradiseSphere(50, pink, blue, cyan);
    cubesFront();

    displaySpaceRects(5, -1, pink, blue, cyan); 
    fadeInAllScreens(cues[0].startT, 3);
    break;  
  case 1:

    paradiseSphere(50, pink, blue, cyan);
    cubesFront();


    displaySpaceRects(5, -1, pink, blue, cyan); 
    cyclingRects = false;
    hasResetRects = false;
    break;
  case 2:

    paradiseSphere(50, pink, blue, cyan);
    cyclingRects = false;
    centerScreenFrontInner();
    displayTwoWayTunnels();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 3:
    paradiseSphere(50, pink, blue, cyan);
    centerScreenFrontInner();

    displayLineBounceCenter(0.01, 50, cyan, pink, 5);
    hasResetRects = false;
    resetSpaceRects(false);
    break;
  case 4: 
    cubesFront();
    cyclingRects = true;
    displaySpaceRects(5, 1, pink, blue, cyan);

    break;
  case 5:
    cyclingRects = true;
    resetSpaceRects(false);
    paradiseSphere(50, 0, blue, cyan);


    centerScreenFrontInner();

    displayCenterSpaceRects(5, -1, blue, cyan, pink);
    break;
  case 6:
    paradiseSphere(50, pink, blue, cyan);
    cubesFront();
    displaySpaceRects(5, -1, pink, blue, cyan); 
    cyclingRects = true;
    hasResetRects = false;
    break;
  case 7:
    paradiseSphere(50, pink, blue, cyan);
    centerScreenFrontInner();

    displayLineBounceCenter(0.01, 50, cyan, pink, 5);
    hasResetRects = false;
    resetSpaceRects(false);

    fadeOutCenter(cues[currentCue+1].startT - .5, .5);
    break;
  case 8:

    paradiseSphere(50, pink, blue, cyan);
    cyclingRects = false;
    centerScreenFrontInner();
    displayTwoWayTunnels();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 9: // tee tahh
    cubesFront();
    cyclingRects = true;
    displaySpaceRects(5, 1, pink, blue, cyan);

    fadeOutAllScreens(cues[currentCue + 1].startT - 4, 4);
    break;

  default:     
    drawSolidAll(color(0));
    break;
  }

  //drawNeonRect(screens[1].s, 0, 0, 50, 50, 5, color(255));
  //displayLines(color(255, 0, 255));
}

void initWiz() {
  cues = new Cue[11];
  cues[0] = new Cue(0, 'm', 0, 0); // intro
  cues[1] = new Cue(13, 'v', 0.0, 0);  // same as 1
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

  tempo = 148;
}

void displayWiz() {

  switch(currentCue) {
  case 0:
    //drawSolidAll(color(0));
    //drawFFTBarsCubes();
    //pulseHorizLinesCenterBeat(percentToNumBeats(16));
    //snakeFaceAll(percentToNextMeasure(0, 4), 2);
    displayGradientVertLines(black, white, percentToNumBeats(4));
    break;
  case 1:
    transit(white, red, yellow, blue, percentToNumBeats(4));
    break;
  case 2:
    sineWaveVert(red, blue, percentToNumBeats(8), 0.8);
    break;
  case 3:
    growShrinkBlockEntire(white, red, yellow, blue, percentToNumBeats(8));
    break;
  case 4:
    pulseVertLongCenterBeat(red, percentToNumBeats(8));


    break;
  case 5:
    linesGradientFaceCycle(red, black); 
    break;
  case 6: 
    displayCycleSingleFaceLines(white, -1); 
    break;
  case 7:
    snakeFaceAll(red, percentToNumBeats(8), 2);
    break;
  case 8:
    pulsing(blue, percentToNumBeats(8));
    break;
  case 9:
    transit(white, red, yellow, blue, percentToNumBeats(4));
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}


void displayMood() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsCubes();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
void displaySong() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsCubes();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
void displayEllon() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsCubes();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
void displayEgrets() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsCubes();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
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
        cues[currentCue].initCue();
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
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
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
    playScene();
  }
}

void noteOn(int channel, int pitch, int velocity) {
  printMidi("Note ON", channel, pitch, velocity);
  //lastMidi = millis();
  if (betweenSongs) midiPlayed = true;
  println(">>>>>>>>>>>>>>>>>>");
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

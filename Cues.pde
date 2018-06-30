import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
//////////////////////////////////////////////////////////////////////////////////



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




void initViolate() {
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

void displayDelta() {
  stroke(255, 0, 255);


  switch(currentCue) {
  case 0:
    displayFlowyWavesAll();
    //displayCycleFaceLines(0, color(255, 0, 255));
    break;
  case 1:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);

    break;
  case 2:
    displayFlowyWavesAll();
    break;
  case 3:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
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
  loadKeystone(0);
  currentImages.get(0).resize(sphereScreen.s.width, sphereScreen.s.height);
  startFade = false;
  centerScreenFront();
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
    fadeOutAllScreens(cues[11].startT, 8);

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
  loadKeystone(1);
  initSpaceRects();

  resetFade();
  initTerrainCenter();
  initTesseract();
  centerScreenFront();

  initZZoom();
  resetAudioAmp();
}

void displayDirty() {
  displayStripedMoon(20);
  switch(currentCue) {
  case 0:
    centerScreenFront();
    zoomTerrain();
    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    fadeInAllScreens(cues[0].startT, 4);
    break;
  case 1: // tic toc
    zZoom = endingTerrain;
    centerScreenFront();
    startAudioAmp();
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[1].startT, cues[2].startT, 1, 1);
    cycleAudioAmp(cues[1].startT, cues[2].startT, 4.5);

    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    cycleShapeFFTTop();
    break;
  case 2: // tic toc repeat
    zZoom = endingTerrain;
    centerScreenFront();
    fadeAudioLev(cues[2].startT, cues[3].startT, 1, 1);
    setGridTerrain(1, 1); // sin
    displayTerrainCenter();
    cycleShapeFFTTop();
    break;
  case 3: // dooo, doo, do
    cubesFront();
    drawSolidTop(color(0));
    displayDivisionOfIntensity2Screens(sin(millis()/1000.0)*20 + 30, 0, 0);
    fadeOutCubes(cues[currentCue + 1].startT - 2, 2);
    //display3DDots2Screens(100, 0, 0.005);
    //displayTesseract2Screens();
    break;
  case 4: // tic toc
    zZoom = endingTerrain;
    centerScreenFront();
    startAudioAmp();
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1, 1);
    cycleAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1.5);

    setGridTerrain(0, 0.01);
    displayTerrainCenter();
    cycleShapeFFTTop();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 5:
    cubesFront();
    drawSolidTop(color(0));
    displayDivisionOfIntensity2Screens(sin(millis()/1000.0)*20 + 30, 0, 0);
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
    centerScreenFront();
    startAudioAmp();
    // tempo is bpm; bpm * 60 = bps = 1000 * bpms
    // 8 beats per clause, 4 clauses, 1 sine wave per 8 beats = 4 clauses
    fadeAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1, 1);
    cycleAudioAmp(cues[currentCue].startT, cues[currentCue+1].startT, 1.5);

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
  loadKeystone(1);
  initSpaceRects();

  resetFade();
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
    centerScreenFront();
    displayTwoWayTunnels();
    fadeInCenter(cues[currentCue].startT, 2);
    break;
  case 3:
    paradiseSphere(50, pink, blue, cyan);
    centerScreenFront();

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


    centerScreenFront();

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
    centerScreenFront();

    displayLineBounceCenter(0.01, 50, cyan, pink, 5);
    hasResetRects = false;
    resetSpaceRects(false);

    fadeOutCenter(cues[currentCue+1].startT - .5, .5);
    break;
  case 8:

    paradiseSphere(50, pink, blue, cyan);
    cyclingRects = false;
    centerScreenFront();
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
  cues = new Cue[9];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(13, 'v', 0.0, 0);
  cues[2] = new Cue(25.5, 'v', 0.0, 0);
  cues[3] = new Cue(39, 'v', 0.0, 0);
  cues[4] = new Cue(52, 'v', 0.0, 0);
  cues[5] = new Cue(78, 'v', 0.0, 0);
  cues[6] = new Cue(90.8, 'v', 0.0, 0);
  cues[7] = new Cue(104, 'v', 0.0, 0);
  cues[8] = new Cue(110, 'v', 0.0, 0);
  
  tempo = 148;
}

void displayWiz() {
  
  switch(currentCue) {
  case 0:
    //drawSolidAll(color(0));
    //drawFFTBarsCubes();
    stroke(255);
    fill(255);
    pulseHorizLinesCenterBeat(percentToNumBeats(16));
    //snakeFaceAll(percentToNextMeasure(0, 4), 2);
    break;
  case 1:
    transit(0);
    break;
  case 2:
    sineWaveVert(percentToNextMeasure(0, 4)*2, 0.8);
    break;
  case 3:
    
    break;
  case 4:
    pulsing(color(255, 0, 255), percentToNextMeasure(0, 4));
    break;
  case 5:
    growBlockEntire(percentToNextMeasure(0, 4));
    break;
  case 6: 
    displayCycleSingleFaceLines(color(0, 255, 255), -1); 
    break;
  case 7:
    pulseVertLongCenterBeat(percentToNextMeasure(0, 4)*2);
    break;
  case 8:
    displayCubesAlternateColorCycle(cyan, pink);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
void displayViolate() {
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

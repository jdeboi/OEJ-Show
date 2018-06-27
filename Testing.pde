

void testLineMode() {
  stroke(255);
  pulseLineRight(90, 80);
}
//if (visualMode == V_ROTATE_ANGLE_COUNT) rotateAngleCounter(100, 20);
//  else if (visualMode == V_PULSE_LINE_BACK) pulseLineBack(500);
//  else if (visualMode == V_PULSE_LINE_RIGHT) pulseLineRight(90, 80);
//  else if (visualMode == V_PULSE_LINE_LEFT)  pulseLineLeft(90, 80);
//  else if (visualMode == V_PULSE_LINE_UP) pulseLineUp(90, 80);
//  else if (visualMode == V_PULSE_LINE_DOWN) pulseLineDown(90, 80);
//  else if (visualMode == V_CYCLE_CONST) cycleConstellation(150);
//  else if (visualMode == V_PULSING) pulsing(90);
//  else if (visualMode == V_SHOW_ONE) showOne(100);
//  else if (visualMode == V_PULSING_ON_LINE) pulseLinesCenter(1);
//  else if (visualMode == V_SEGMENT_SHIFT) segmentShift(10);
//  else if (visualMode == V_TRANSIT) transit(30);
//  else if (visualMode == V_DISPLAY) displayLines(255);


void testShow() {

  // do we want to see the stage?
  //image(stage, 0, 0, width, stage.height * width/stage.width);

  /////////////////////////////
  // CUSTOM SCRIPTS
  //drawCNAll();
  //drawSolidAll(color(0));
  //displayShadowLines(50, 30, 5);

  //mirrorVidCenter(vid1, 0, 0);
  //displayShadowRainbow();
  //drawSolidAll(color(0));
  //haromAll(color(255), 3);
  //displayMoonsAcross();
  //displayFlowyWaves(centerScreen.s);


  //displayTreeBranchesAll();
  //displayFractalTreeAll(1);

  //displayShadowRainbow();
  //centerScreen.drawSolid(color(0));
  //displayTerrainCenter();  // no mesh
  //displayTerrainSplit();
  //drawStream();
  //drawSolidAll(color(0));
  //displayWavesCenter();
  //centerScreen.drawSolid(color(0));
  //displayLineBounceAll();

  //displayMoveSpaceCenter();
  //displayMoveSpaceAll();
  //displayRedPlanetAll();
  //displayRedPlanet(centerScreen.s);

  /////////////////////////////
  // GIF
  if (mode == GIF_ALL) drawGifAll(currentTestGif, 0, 0, screenW, screenH);
  else if (mode == GIF_ACROSS) {
    int y = int(map(mouseY, 0, height, -550, 0));
    drawGifAcross(currentTestGif, y);
  }

  /////////////////////////////
  // CUBES
  else if (mode == CUBE_MODE) {
    display3D();
    updateCubes();
  }

  /////////////////////////////
  // IMAGE
  else if (mode == IMG_ALL) drawImageAll(currentTestImg, 0, 0, screenW, screenH);
  else if (mode == IMG_ACROSS) {
    int y = int(map(mouseY, 0, height, -550, 0));
    drawImageAcross(currentTestImg, y);
  }

  /////////////////////////////
  // FFT
  else if (mode == FFT) {
    //drawFFT();
    //drawSolidAll(color(0));
    //drawFFTBarsAll();
    //displayAmplitudeHoriz();


    //drawSpectrum(30);
    //cycleShapeFFT();
    //cycleConstFFT();
    //cycleHandsFFT();
    //drawSpectrumAcross();
    //drawSpectrumMirror();
    //drawTriangleSpectrum();
    //displayTesseract();
    //beatTile();
    //displayParticles();
    //drawWaveForm();
  }

  /////////////////////////////
  // VIDEO
  else if (mode == TILE_VID) tileVid(vid1, 0, 0);
  else if (mode == VID_ACROSS) movieAcrossAll(vid1, -100);
  else if (mode == VID_MIRROR) mirrorVidCenter(vid1, 0, 0);



  //if (useCenterScreen) {
  //centerScreen.drawSolid(color(0));
  //centerScreen.drawImage(currentTestImg,0, 0);
  //}
  //snakeOutlineAll(color(0, 255, 255), 30, 150, 5);

  ///////////////////////////
  // lines
  strokeWeight(10);
  if (!editingLines) testLineMode(); //displayLineMode();
}

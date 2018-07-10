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

  tempo = 60;
  currentGifs.get(3).loop();
  currentGifs.get(4).loop();
  currentGifs.get(currentGifs.size()-1).loop();
  initTreeBranchesAll();
}

void displaySong() {
  if (!personOnPlatform) sphereScreen.drawGif(currentGifs.get(currentGifs.size()-1), 0, 0, sphereScreen.s.width, sphereScreen.s.height);
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

//////////////////////////////////////////////////////////////////////////////////
// DISPLAY CUES
//////////////////////////////////////////////////////////////////////////////////

void initCrush() {
  //initVid("scenes/crush/movies/crush.mp4");
  cues = new Cue[13];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(17, 'v', 0.0, 0);  // X
  cues[2] = new Cue(18.3, 'v', 0.0, 0);
  cues[3] = new Cue(19.6, 'v', 0.0, 0);    // X
  cues[4] = new Cue(28.2, 'g', 0.0, 0);   // chords slow
  //cues[4] = new Cue(38, 'g', 0.0, 0);    // chords slow
  cues[5] = new Cue(47.5, 'g', 0.0, 2);  // guitar
  cues[6] = new Cue(56.7, 'g', 0.0, 2);    // guitar
  cues[7] = new Cue(66, 'g', 20.0, 4);    // X
  //cues[6] = new Cue('v', 0, 75);   // X
  cues[8] = new Cue(85, 'g', 0.0, 3);   // xylophone
  cues[9] = new Cue(94, 'g', 0.0, 5);
  cues[10] = new Cue(103.8, 'g', 0.0, 6);
  cues[11] = new Cue(113.2, 'v', 0.0, 0);
  cues[12] = new Cue(115, 'v', 0.0, 0);

  initSphereBoxRot();
  tempo = 102;
}

boolean blackOutPlanet = false;
void resetRedPlanet() {
  if (!blackOutPlanet) {
    sphereScreen.blackOut();
    blackOutPlanet = true;
  }
}

void displayCrush() {
  if (!personOnPlatform) displayRedPlanetSphere();
  else {
    drawEye();
    drawWaveHands();
  }

  switch(currentCue) {
  case 0:

    displayLinesInnerFaces(white);
    drawSolidOuter(0);
    displaySphereBoxCrush();


    fadeInCubes(cues[currentCue].startT, 4);
    break;
  case 1:
    drawSolidAll(black);
    displayAllFaceLinesColor(0, 0, white, color(150));
    break;
  case 2:
    displayAllFaceLinesColor(white, color(150), 0, 0);
    drawSolidAll(black);
    break;
  case 3: // oscillate
    if (((currentCycle-1)/8)%2 == 0) {
      displayLinesOutsideFaces(color(255), color(255));
      drawSolidInner(0);
      for (int i = 0; i < screens.length; i+=3) {
        PGraphics s = screens[i].s;
        s.beginDraw();
        s.background(0);
        haromS(s, white, 3);
        s.endDraw();
      }
    } else {
      drawSolidOuter(0);
      displayLinesInnerFaces(white);
      for (int i = 1; i < 3; i++) {
        PGraphics s = screens[i].s;
        s.beginDraw();
        s.background(0);
        haromS(s, white, 3);
        s.endDraw();
      }
    }
    break;

  case 4: // all chill

    for (int i = 0; i < 4; i++) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.blendMode(BLEND);
      //s.background(color(180, 0, 80));
      s.image(currentGifs.get(currentGif), 0, 0, screenW, screenW);
      //s.filter(THRESHOLD, .01);
      s.filter(GRAY);
      //s.blendMode(BLEND);
      s.endDraw();
    }
    //drawGifAll(currentGifs.get(0), 0, 0, screenW, screenH);
    break;
  case 5: // inner
    displayLinesInnerFaces(white);
    drawSolidOuter(0);

    for (int i = 1; i < 3; i++) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.blendMode(BLEND);
      //s.background(color(180, 0, 80));
      //int hg = (currentGifs.get(7).height - screenH)/2;
      s.background(0);
      if (i == 1) {
        s.pushMatrix();
        s.scale(-1.0, 1.0);

        s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);//-hg, screenW, currentGifs.get(7).height * currentGifs.get(7).width/screenW);
        s.popMatrix();
      } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-hg, screenW, currentGifs.get(7).height * currentGifs.get(7).width/screenW);
      //s.filter(THRESHOLD, .2);
      //s.filter(GRAY);
      //s.blendMode(BLEND);
      s.endDraw();
    }
    break;
  case 6:// puter
    displayLinesOutsideFaces(color(255), color(255));
    drawSolidInner(0);
    for (int i = 0; i < screens.length; i+=3) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.background(0);
      if (i == 3) {
        s.pushMatrix();
        s.scale(-1.0, 1.0);
        s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);
        s.popMatrix();
      } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH);
      //s.filter(THRESHOLD, .2);
      s.endDraw();
    }
    break;
  case 7:
    display4FaceLines(white, 1);
    display4FaceLines(white, 2);
    drawSolidOuter(0);


    for (int i = 1; i < 3; i++) {
      PGraphics s = screens[i].s;
      s.beginDraw();
      s.blendMode(BLEND);
      //s.background(color(180, 0, 80));
      if (i == 1) {
        s.pushMatrix();
        s.scale(-1.0, 1.0);

        s.image(currentGifs.get(currentGif), -screenW, 0, screenW, screenH);//-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
        s.popMatrix();
      } else s.image(currentGifs.get(currentGif), 0, 0, screenW, screenH); //-300, screenW, currentGifs.get(currentGif).height * currentGifs.get(currentGif).width/screenW);
      //s.filter(THRESHOLD);
      //s.blendMode(BLEND);
      s.endDraw();
    }
    break;
  case 8:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 9:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 10:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
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

  tempo = 133;
  cues = new Cue[13];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(7, 'v', 0.0, 0); // bass beat
  cues[2] = new Cue(14.95, 'v', 0.0, 0); //xylophone
  //cues[3] = new Cue(29, 'v', 0.0, 0); // kinda2
  cues[3] = new Cue(36, 'g', 0.0, 0); // derrr neener derrr
  cues[4] = new Cue(51, 'v', 0.0, 0); // "help meee coffee", big base beat
  cues[5] = new Cue(72.2, 'v', 0.0, 0);  // wooo
  cues[6] = new Cue(102, 'v', 0.0, 0);  // "delta waves"
  cues[7] = new Cue(115, 'v', 0.0, 0);
  cues[8] = new Cue(137, 'v', 0.0, 0);// woo
  cues[9] = new Cue(166, 'v', 0.0, 0);
  cues[10] = new Cue(181, 'v', 0.0, 0);
  cues[11] = new Cue(199, 'v', 0.0, 0);
  cues[12] = new Cue(203, 'v', 0.0, 0);


  cubesFront();

  initHands();
  initSymbols();
}

void deconstructDelta() {
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
  //float[] deltaBeats2 = {1, 1, 1, 1}; // -1, 1, .5, .5, -1, -1};
  // index = getMoveOnBeats(deltaBeats2, 4);


  // if (index > 0) {
  //   p = hands[index%4];
  //   println(index);
  //   h = p.height*screenW/p.width;
  //   screens[0].drawImage(p, 0, screenH/2 -h/2, screenW, h);
  // }

  displayLinesCenterFocus(color(255));
  innerScreensOut();

  int h = int(hands[0].height*1.0*screenW/hands[0].width);
  switch(currentCue) {
  case 0:
    if (!personOnPlatform) {
      PImage p = hands[(currentCycle) % hands.length];
      screens[0].drawImage(p, 0, screenH/2 -h/2, screenW, h);
      screens[3].drawImage(p, 0, screenH/2 -h/2, screenW, h);
    }
    break;
  case 1:
    // alternate left, right open
    if (!personOnPlatform) {
      if (currentCycle%2 == 0) {
        screens[0].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
        screens[3].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
      } else {
        screens[0].drawImage(hands[4], 0, screenH/2 -h/2, screenW, h);
        screens[3].drawImage(hands[0], 0, screenH/2 -h/2, screenW, h);
      }
    }
    break;
  case 2:
    if (!personOnPlatform) {
      PImage p = symbols[((currentCycle+2)/4) % symbols.length];
      int w = int(p.width * 1.0 * screens[0].s.height/p.height);
      screens[0].drawImage(p, screenW/2-w/2, 0, w, screenH);
      screens[3].drawImage(p, screenW/2-w/2, 0, w, screenH);
    }
    break;
  case 3:
    cycleHandsFFT();
    break;
  case 4:
    if (!personOnPlatform) {
      float[] deltaBeats2 = {1, 1, 1, -1, 1, .5, .5, -1, -1};
      currentBeatIndex = getMoveOnBeats(deltaBeats2, 8);


      if (currentBeatIndex >= 0) {
        if (currentBeatIndex != previousBeatIndex) {
          previousBeatIndex = currentBeatIndex;
          numBeatsIndex++;
        }
        float rot = PI/2 * numBeatsIndex;
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
    }
    break;
  case 6:

    break;
  case 7:

    break;
  case 8:

    break;
  case 9:

    break;
  case 10:

    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}


void initRite() {
  cues = new Cue[24];
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
  tempo = 120;
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

  if (!personOnPlatform) drawMoonSphere(currentImages.get(0));
  else drawEye();

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

void initLollies() {
  cues = new Cue[18];
  cues[0] = new Cue(0, 'g', 0, 0);
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
  cues[16] = new Cue(213.8, 'v', 0.0, 0);
  cues[17] = new Cue(216, 'v', 0.0, 0);

  initSymbols();
  tempo = 128;
  //currentGifs.get(4).loop();
  temp = createGraphics(screenW, screenH);
  initializeTriangulation(-1);
}

PGraphics temp;
int lastCueDelaunay = -2;

void displayLollies() {
  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else drawEye();


  switch(currentCue) {
  case 0:
    initializeTriangulation(0);
    drawDelaunayTriAll();
    //cycleCubeLight(black, white, pink, pink);

    break;
  case 1:
    initializeTriangulation(1);
    drawDelaunayTriAll();

    //if (songFile.position()/1000.0 < 10.8)  drawVertLinesAcrossAll(30, 30, percentToNumBeats(16), lime, 0);
    //else if (songFile.position()/1000.0 < 14.4) drawVertLinesAcrossAll(30, 30, percentToNumBeats(16), lime, 1);
    //else if (songFile.position()/1000.0 < 18) drawVertLinesAcrossAll(30, 30, percentToNumBeats(16), lime, 2);
    //else drawVertLinesAcrossAll(30, 30, percentToNumBeats(16), lime, 3);
    break;
  case 2:
    initializeTriangulation(2);
    drawDelaunayTriAll();
    //color [] colors = {lime, white, lime, white};
    //drawVertLinesAcrossAll(30, int(60 + 50*sin(percentToNumBeats(8)*2*PI)), percentToNumBeats(16), colors, 0); // int(30*15*percentToNumBeats(8))
    break;
  case 3:
    drawVertLinesGradientAcrossAll(30, int(60 + 40*sin(percentToNumBeats(8)*2*PI)), percentToNumBeats(16), lime, pink, cyan);
    break;
  case 4:

    drawDelaunayTriAll();
    break;
  case 5:
    drawDelaunayTriAll();
    break;
  case 6:
    drawSolidAll(color(255));
    break;
  case 7:
    drawSolidAll(color(0, 0, 0));
    break;
  case 8:
    drawSolidAll(color(0, 255, 255));
    break;
  case 9:
    drawSolidAll(color(0, 0, 255));
    break;
  case 10:
    drawSolidAll(color(255, 0, 255));
    break;
  case 11:
    drawSolidAll(color(255, 0, 0));
    break;
  case 12:
    drawSolidAll(color(255, 255, 0));
    break;
  case 13:
    drawSolidAll(color(0, 255, 0));
    break;
  case 14:
    drawSolidAll(color(255, 0, 255));
    break;
  case 15:
    drawSolidAll(color(255, 255, 0));
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void lineEllipse() {
}

void testthestuff() {
  //screens[0].s.beginDraw();
  //screens[0].s.background(0);
  //screens[0].s.blendMode(SCREEN);
  ////splitRect(screens[0].s, pink, lime);
  //drawVertLinesGradientScreen(screens[0].s, 30, int(60 + 50*sin(percentToNumBeats(8)*2*PI)), percentToNumBeats(16), lime, pink);
  //drawHorizLinesGradientScreen(screens[0].s, 30, int(60 + 50*sin((1-percentToNumBeats(8))*2*PI)), percentToNumBeats(16), lime, pink);
  ////ellipseRun(screens[0].s, 30, 10, percentToNumBeats(16), lime, pink);
  //screens[0].s.endDraw();
}

void ellipseRun(PGraphics s, float w, float sp, float per, color c1, color c2) {
  s.noStroke();
  for (int i = s.width*2; i > 0; i-= (sp+w)) {
    s.noFill();
    s.strokeWeight(w/2);


    float newW = map(per, 0, 1, 0, s.width*2);
    newW += i;
    newW %= s.width*2;
    s.stroke(lerpColor(c1, c2, newW/ s.width));
    s.ellipse(s.width/2, s.height/2, newW, newW);
  }
}
void splitRect(PGraphics s, color c1, color c2) {
  int mode = (currentCycle-1)/4%4;
  s.fill(c2);
  s.noStroke();
  if (mode > 0) {
    for (int x = 0; x <= pow(2, mode); x++) {
      s.pushMatrix();
      //s.translate(10*sin(percentToNumBeats(8)*2*PI), 0);
      for (int y = 0; y <= pow(2, mode); y++) {
        if (y%2 ==0) s.rect(x*s.width/pow(2, mode)*2, y*s.height/pow(2, mode), s.width/pow(2, mode), s.height/pow(2, mode));
        else s.rect(x*s.width/pow(2, mode)*2 + s.width/pow(2, mode), y*s.height/pow(2, mode), s.width/pow(2, mode), s.height/pow(2, mode));
      }
      s.popMatrix();
    }
  }
}

void cycleCubeMovingStripes(int lw, int lsp, float per, color c1, color c2, color l1, color l2) {
  if ((currentCycle-1)/4 % 2 == 0) {
    drawVertLinesScreen(screens[0].s, lw, lsp, per, c1, 0);
    colorMode(HSB);
    color c = color(hue(c1), saturation(c1), brightness(c2) - 70);
    drawVertLinesScreen(screens[1].s, lw, lsp, per, c, 0);
    colorMode(RGB);
    screens[2].blackOut();
    screens[3].blackOut();
    displayCubeLines(l1, 0);
  } else {
    drawVertLinesScreen(screens[2].s, lw, lsp, per, c2, 0);
    colorMode(HSB);
    color c = color(hue(c2), saturation(c2), brightness(c2) - 70);
    drawVertLinesScreen(screens[3].s, lw, lsp, per, c, 0);
    colorMode(RGB);
    screens[0].blackOut();
    screens[1].blackOut();
    displayCubeLines(0, l2);
  }
}

void cycleCubeLight(color c1, color c2, color l1, color l2) {
  if ((currentCycle-1)/4 % 2 == 0) {
    PGraphics s = screens[0].s;
    s.beginDraw();
    s.background(c1);
    s.noStroke();
    s.fill(c2);
    s.rect(0, 0, s.width, s.height/2);
    s.fill(c1);
    s.ellipse(s.width/2, s.height/2, s.width/2, s.width/2);
    s.fill(c2);
    s.arc(s.width/2, s.height/2, s.width/2, s.width/2, 0, PI);
    s.endDraw();
    colorMode(HSB);
    color c = color(hue(c1), saturation(c1), brightness(c2) - 70);
    screens[1].drawSolid(c);
    colorMode(RGB);
    screens[2].blackOut();
    screens[3].blackOut();
    displayCubeLines(l1, 0);
  } else {
    screens[2].drawSolid(c2);
    colorMode(HSB);
    color c = color(hue(c2), saturation(c2), brightness(c2) - 70);
    screens[3].drawSolid(c);
    colorMode(RGB);
    screens[0].blackOut();
    screens[1].blackOut();
    displayCubeLines(0, l2);
  }
}

void drawHorizLinesGradientScreen(PGraphics s, int lh, int lsp, float per, color c1, color c2) {
  s.noStroke();
  int extra = (lh + 2*lsp);
  for (int i = 0; i < s.height + extra; i += (lh + lsp)) {

    float y = map(per, 0, 1, -extra, s.height);

    y += i;
    if (y >= s.height) y -= (extra + s.height);
    s.fill(lerpColor(c1, c2, y/s.height));
    s.rect(0, y, s.width, lh);
  }
}

void drawVertLinesGradientScreenAcross(PGraphics s, int lw, int lsp, int screenNum, float per, color c1, color c2, color c3) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {

    float x = map(per, 0, 1, -extra, s.width);

    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.fill(getCycleColor(c1, c2, c3, (x+screenNum * screenW)/(screenW*4)));
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesGradientScreen(PGraphics s, int lw, int lsp, float per, color c1, color c2) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {

    float x = map(per, 0, 1, -extra, s.width);

    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.fill(lerpColor(c1, c2, x/s.width));
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesScreen(PGraphics s, int lw, int lsp, float per, color c, int direction) {
  s.noStroke();
  int extra = (lw + 2*lsp);
  for (int i = 0; i < s.width + extra; i += (lw + lsp)) {
    s.fill(c);
    //s.fill(255);
    float x = 0;
    if (direction > 0) x = map(per, 0, 1, -extra, s.width);
    else if (direction < 0) x = map(1-per, 0, 1, -extra, s.width);
    x += i;
    if (x >= s.width) x -= (extra + s.width);
    s.rect(x, 0, lw, s.height);
  }
}

void drawVertLinesGradientAll(int lw, int lsp, float per, color c1, color c2) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    drawVertLinesGradientScreen(screens[j].s, lw, lsp, per, c1, c2);
    screens[j].s.endDraw();
  }
}

void drawVertLinesGradientAcrossAll(int lw, int lsp, float per, color c1, color c2, color c3) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    drawVertLinesGradientScreenAcross(screens[j].s, lw, lsp, j, per, c1, c2, c3);
    screens[j].s.endDraw();
  }
}

void drawVertLinesAcrossAll(int lw, int lsp, float per, color c, int mode) {
  color [] colors = {c, c, c, c};
  drawVertLinesAcrossAll(lw, lsp, per, colors, mode);
}

void drawVertLinesAcrossAll(int lw, int lsp, float per, color[] colors, int mode) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.background(0);
    screens[j].s.blendMode(SCREEN);
    int direction = 0;
    if (mode == 0) direction = 1;
    else if (mode == 1) direction = -1;
    else if (mode == 2) {
      if (j == 0 || j == 1) direction = 1;
      else direction = -1;
    } else if (mode == 3) {
      if (j == 0 || j == 1) direction = -1;
      else direction = 1;
    }
    //temp.beginDraw();
    //temp.background(0);
    drawVertLinesScreen(screens[j].s, lw, lsp, per, colors[j], direction);
    //temp.endDraw();
    //screens[j].s.image(currentImages.get(0), -screenW * j, 0);
    //screens[j].s.mask(temp);
    screens[j].s.endDraw();
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
  displayLinesCenterFocus(color(255));
  if (!personOnPlatform) displayStripedMoon(20);
  else drawEye();

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
  displayLinesCenterFocus(pink);

  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else drawEye();

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
  initVid("scenes/wizrock/movies/1.mp4");
  cues = new Cue[11];
  cues[0] = new Cue(0, 'm', 0, 0); // intro
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

  tempo = 148;

  loadKeystone(0);
  //initNodes(screens[0].s);
  //initTesseract();
  //initSquiggle(centerScreen.s);
  //initDrip(centerScreen.s);
  initDots(100);
  initAllFlowyWaves();
  currentGifs.get(4).loop();

  initNodesMain();
  initSymbols();
}

boolean resetSquiggleLines = false;

void displayWiz() {
  if (!personOnPlatform) sphereScreen.drawSolid(0);
  else {
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

  displayFlowyWavesWiz();


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


void initEllon() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(songFile.length()/1000.0-4, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length()/1000.0-1, 'v', 0.0, 0);

  loadKeystone(MID_CENTER);
}

void displayEllon() {
  centerScreenFrontAll();
  switch(currentCue) {
  case 0:
    centerScreen.drawImage(currentImages.get(0), 0, 0);
    fadeInAllScreens(cues[currentCue].startT, 4);
    break;
  case 1:
    centerScreen.drawImage(currentImages.get(0), 0, 0);
    fadeOutAllScreens(cues[currentCue].startT, 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
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

  tempo = 122;
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
    drawSolidAll(color(0));
    break;
  }
}

void initELO() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(2, 'v', 0.0, 0);
  cues[2] = new Cue(240, 'v', 0.0, 0); 

  centerScreenFrontAll();
  tempo = 141;
}

void displayELO() {
  if (!personOnPlatform) sphereScreen.blackOut();
  else drawEye();

  switch(currentCue) {
  case 0:    
    pulsing(0, 1);
    break;
  default:
    displayLines(color(0));
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

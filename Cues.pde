import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
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

void initDelta() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(135, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
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

void initDirty() {
  cues = new Cue[11];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(6, 'v', 0.0, 0);
  cues[2] = new Cue(12, 'v', 0.0, 0); // tic toc begins
  cues[3] = new Cue(55, 'v', 0.0, 0); // down chords
  cues[4] = new Cue(77, 'v', 0.0, 0);  // tic toc
  cues[5] = new Cue(99, 'v', 0.0, 0);  // down chords
  cues[6] = new Cue(121, 'v', 0.0, 0);  // down chords
  cues[7] = new Cue(143, 'v', 0.0, 0);  // down chords
  cues[8] = new Cue(99, 'v', 0.0, 0);  // down chords
  cues[9] = new Cue(175, 'v', 0.0, 0);  // down chords
  cues[10] = new Cue(songFile.length(), 'v', 0.0, 0);
}

void initWiz() {
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
    displayNervous();
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

void displayDelta() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    haromCenter(color(255), 3, 180);
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
  loadKeystone(1);
  currentImages.get(0).resize(sphereScreen.s.width, sphereScreen.s.height);
  startFade = false;
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

    startFade = false;  
    break;
  case 11: // fade out end
    displayMoveSpaceCenter(CONVERGE_CENTER, 0.75); 
    fadeOutAllScreens(8);

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

void displayDirty() {
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

void initFifty() {
  Cue[] cuesT = {
    new Cue(0, 'v', 0, 0), 
    new Cue(19.5, 'v', 0.0, 0), 
    new Cue(190, 'v', 0.0, 0)
  };
  cues = cuesT;
  drawSolidAll(color(0));
  loadKeystone(1);
  initSpaceRects();
}

void displayFifty() {
  switch(currentCue) {   
  case 0:
    cubesFront();
    drawFFTBarsCubes();  
    drawSolidOuter(color(0));
    displaySpaceRects();
    break;           
  case 1:
    drawSolidOuter(color(0));
    centerScreenFront();
    displayCenterSpaceRects();    
    break;
  default:     
    drawSolidAll(color(0));
    break;
  }
}
void displayWiz() {
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

/*
 * To add a cue to a song, first add a Cue object to the "cues" array inside 
 * of the init() functions below. A Cue is initialized with 
 * -> a timestamp (when the cue starts in the song)
 * -> a type ('v' for visual, 'm' for movie, 'g' for gif, ...)
 * -> for movies, the time in the movie that should start playing (or a 0 if it's a gif, etc.)
 * -> for gifs, which number of the file in the "data/scenes/[name]/[number].gif" that should play
 *
 * For example, the following movie will start playing when the song is at 28.2 seconds, and will
 * start skip to 2.0 seconds into the video:
 * cues[1] = new Cue(28.2, 'v', 2.0, 0);  
 *
 * The following cue will play at 38 seconds. It will be gif "data/scenes/[name]/0.gif"
 * cues[2] = new Cue(38, 'g', 0.0, 0);
 
 * If you want to play a video at any point during the song, it will have to be loaded with 
 * initVid("scenes/crush/movies/[name].mp4"). I currently only have this working for one vid 
 * at a time, but can change this. See initCrush() for an example.
 * 
 * Once you've edited the cues in the init() functions, skip down to the display() functions.
 * For a given cue (e.g. case 0 or the first cue), specify what you want to happen - check out
 * displayCrush() for an example.
 */


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
void initMoon() {
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
void initFifty() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0); 
  cues[1] = new Cue(5, 'v', 0.0, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0, 0);
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

void displayMoon() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
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

void displayLollies() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
void displayFifty() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
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
void displayWiz() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
    drawFFTBarsAll();
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
    if (songFile.position() > cue.startT*1000) {
      c++;
      if (c >= cues.length) {
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

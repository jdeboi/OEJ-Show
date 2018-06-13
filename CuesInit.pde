Cue [] cues;
int currentCue = -1;
ArrayList<Gif> currentGifs;
int currentGif = -1;

void initCrush() {
  currentGifs = loadGifs("scenes/crush/gifs/");
  int c = 0;
  cues = new Cue[10];
  cues[c] = new Cue(c++, 'm', 0, 0, 0); 
  //cues[c++] = 5;
  //cues[c++] = 9.7;   // X  
  //cues[c++] = 14.4;  // X
  //cues[c++] = 17.0;  // Break happens
  //cues[c++] = 19;    // X
  cues[c] = new Cue(c++, 'v', 0.0, 0, 28.8);   // chords slow
  cues[c] = new Cue(c++, 'g', 0.0, 0, 38);    // chords slow
  cues[c] = new Cue(c++, 'g', 0.0, 1, 47.5);    // guitar
  cues[c] = new Cue(c++, 'g', 0.0, 2, 56);    // guitar
  cues[c] = new Cue(c++, 'm', 20.0, 0, 66);    // X
  //cues[c] = new Cue(c++, 'v', 0, 75);   // X
  cues[c] = new Cue(c++, 'g', 0.0, 3, 85);   // xylophone
  cues[c] = new Cue(c++, 'v', 0.0, 0, 94);
  cues[c] = new Cue(c++, 'v', 0.0, 0, 103.8);
  cues[c] = new Cue(c++, 'v', 0.0, 0, 135);
  currentCue = 0;
  initStripedSquares(10);

  initVid("scenes/crush/movies/crush.mp4");
  songFile = minim.loadFile("music/crush.mp3", 1024);
}

void initDelta() {
  songFile = minim.loadFile("music/delta.mp3", 1024);
}
void initRite() {
  songFile = minim.loadFile("music/rite.mp3", 1024);
}
void initMoon() {
  songFile = minim.loadFile("music/moon.mp3", 1024);
}
void initLollies() {
  songFile = minim.loadFile("music/lollies.mp3", 1024);
}

void initCycles() {

  songFile = minim.loadFile("music/cycles.mp3", 1024);
  initVid("scenes/cycles/movies/vid1.mp4"); 
  images = loadImages("scenes/cycles/images/");
}
void initDirty() {
  // TODO
  songFile = minim.loadFile("music/fifty.mp3", 1024);
}
void initFifty() {
  songFile = minim.loadFile("music/fifty.mp3", 1024);
}
void initWiz() {
  songFile = minim.loadFile("music/wizrock.mp3", 1024);
}
void initViolate() {
  songFile = minim.loadFile("music/violate.mp3", 1024);
}
void initMood() {
  songFile = minim.loadFile("music/mood.mp3", 1024);
}
void initSong() {
  songFile = minim.loadFile("music/song.mp3", 1024);
}
void initEllon() {
  // TODO
  songFile = minim.loadFile("music/egrets.mp3", 1024);
}
void initEgrets() {
  songFile = minim.loadFile("music/egrets.mp3", 1024);
}

//////////////////////////////////////////////////////////////////////////////////
class Cue {
  int order;
  char type;
  float startT;
  float movieStartT;
  int gifNum;

  Cue(int o, char t, float mt, int g, float tim) {
    order = o;
    type = t;
    movieStartT = mt;
    gifNum = g;
    startT = tim;
  }

  void initCue() {
    if (type == 'm') {
      vidIsPlaying = true;
      skipVid();
    }
    else {
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

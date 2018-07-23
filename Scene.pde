Scene[] scenes = new Scene[14];
Scene currentScene;
int currentSceneIndex = 0;
boolean isPlaying = false;
boolean mac = false;

void initScenes() {

  //  When The Moon Comes = 80 4/4
  //Subatomic = 87 4/4
  //Crush Proof = 102 4/4
  //Cycles = 81 3/4
  //Papercuts = 151 4/4
  //Cave Dwellers = 90 4/4
  //Mood = 80 4/4
  //Ellon = 112 4/4
  //Deltawaves = 66.5 4/4
  //Song For M = 60 4/4
  //Rite Of Spring = 61 4/4
  //Hypercube = 135 4/4
  //Egrets = 122 4/4

  scenes[0] = new Scene("Intro", "intro", 0, 60, 4, 0);
  scenes[1] = new Scene("When the Moon Comes", "moon", 1, 80, 4, 2);
  scenes[2] = new Scene("Dirty", "dirty", 2, 87, 4, 2);
  //scenes[2] = new Scene("Fifty Fifty", "fifty", 3, 120, 4);
  scenes[3] = new Scene("Crush Proof", "crush", 3, 102, 4, 2);
  scenes[4] = new Scene("Cycles", "cycles", 4, 81, 3, 2);  //6/8
  scenes[5] = new Scene("WizRock", "wizrock", 5, 151, 4, 2);
  scenes[6] = new Scene("Violate Expectations", "violate", 6, 90, 4, 2);
  scenes[7] = new Scene("Mood #2", "mood", 7, 80, 4, 2);
  scenes[8] = new Scene("Delta Waves", "delta", 8, 132.8, 4, 1);
  scenes[9] = new Scene("Song for M", "song", 9, 60, 4, 2);
  scenes[10] = new Scene("Ellon", "ellon", 10, 112.12, 4, 1);
  scenes[11] = new Scene("Rite of Spring", "rite", 11, 61, 4, 2);
  scenes[12] = new Scene("Lollies", "lollies", 12, 135, 4, 2);
  scenes[13] = new Scene("Egrets", "egrets", 13, 122, 4, 2);
  currentScene = scenes[0];
}

void changeScene(int n) {
  if (n >=0 && n < scenes.length) {
    currentScene.resetScene();
    currentSceneIndex = n;
    currentScene = scenes[n];
    currentScene.init();
    isPlaying = false;
    betweenSongs = true;
    println("Current scene: " + currentScene.song);
  }
}

void nextSong() {
  currentSceneIndex++;
  if (currentSceneIndex >= scenes.length) currentSceneIndex = 0;
  changeScene(currentSceneIndex);
}


class Scene {

  String song;
  String shortName;
  int order;
  float tempo;
  int signature;
  int numClickBars;

  Scene(String s, String sn, int o, float t, int sig, int bars) {
    song = s;
    shortName = sn;
    order = o;
    tempo = t;
    signature = sig;
    numClickBars = bars;
  }

  void playScene() {
    betweenSongs = false;
    isPlaying = true;
    //timeStarted = millis();
    songFile.play();
    println(song + " is playing");

    if (currentCue != -1) cues[currentCue].initCue();
  }

  void pauseScene() {
    isPlaying = false;
    songFile.pause();
    println(song + " paused");

    if (currentCue != -1) cues[currentCue].pauseCue();
  }

  void update() {
  }

  void init() {
    if (mac) currentGifs = loadGifs("scenes/" + shortName + "/gifs/");
    else currentGifs = loadGifs("scenes\\" + shortName + "\\gifs\\");
    if (mac) currentImages = loadImages("scenes/" + shortName + "/images/");
    else currentImages = loadImages("scenes\\" + shortName + "\\images\\");
    currentCue = 0;

    if (!backingTracks) songFile = minim.loadFile("musicold/fullsong/" + shortName + ".mp3");

    else {
      //if (shortName.equals("ellon") || shortName.equals("intro")) songFile = minim.loadFile("music/backing/" + shortName + ".mp3");
      //else if (shortName.equals("wizrock")) songFile = minim.loadFile("music/fullsong/wizrock.mp3");
      //else 
      //println(shortName);
      //if (shortName.equals("rite") || shortName.equals("lollies") || shortName.equals("dirty")) songFile = minim.loadFile("music/" + shortName + ".mp3");
      //else songFile = minim.loadFile("music/" + shortName + ".wav");
      songFile = minim.loadFile("music/" + shortName + ".mp3");
    }

    //printMeasureBeatsCurrentScene();

    songFile.cue(0);
    songFile.pause();
    //initBeat();

    resetFade();
    startFadeLine = false;
    currentCycle = 0;

    if (song.equals("Intro")) initIntro();
    else if (song.equals("Delta Waves")) initDelta();
    else if (song.equals("Rite of Spring")) initRite();
    else if (song.equals("When the Moon Comes")) initMoon();
    else if (song.equals("Lollies")) initLollies();
    else if (song.equals("Dirty")) initDirty();
    //else if (song.equals("Fifty Fifty")) initFifty();
    else if (song.equals("Crush Proof")) initCrush();
    else if (song.equals("Cycles")) initCycles();
    else if (song.equals("WizRock")) initWiz();
    else if (song.equals("Violate Expectations")) initViolate();
    else if (song.equals("Mood #2")) initMood();
    else if (song.equals("Song for M")) initSong();
    else if (song.equals("Ellon")) initEllon();
    else if (song.equals("Egrets")) initEgrets();

    platformOff();
  }


  void display() {
    if (isPlaying) {

      //updateSpectrum();
      checkBeatReady(0);

      setCurrentCue();
      if (song.equals("Delta Waves")) displayDelta();
      else if (song.equals("Rite of Spring")) displayRite();
      else if (song.equals("When the Moon Comes")) displayMoon();
      else if (song.equals("Lollies")) displayLollies();
      else if (song.equals("Dirty")) displayDirty();
      //else if (song.equals("Fifty Fifty")) displayFifty();
      else if (song.equals("Crush Proof")) displayCrush();
      else if (song.equals("Cycles")) displayCycles();
      else if (song.equals("WizRock")) displayWiz();
      else if (song.equals("Violate Expectations")) displayViolate();
      else if (song.equals("Mood #2")) displayMood();
      else if (song.equals("Song for M")) displaySong();
      else if (song.equals("Ellon")) displayEllon();
      else if (song.equals("Egrets")) displayEgrets();
      else if (song.equals("Intro")) displayIntro();
      previousCycle = currentCycle;

      //songFile.update();

      if (currentCue == cues.length-1) {
        println("next");
        nextSong();
      }

      previousCue = currentCue;
    }
  }

  void deconstruct() {
    if (song.equals("Delta Waves")) deconstructDelta();
    else if (song.equals("Rite of Spring")) deconstructRite();
    else if (song.equals("When the Moon Comes")) deconstructMoon();
    else if (song.equals("Lollies")) deconstructLollies();
    else if (song.equals("Dirty")) deconstructDirty();
    //else if (song.equals("Fifty Fifty")) deconstructFifty();
    else if (song.equals("Crush Proof")) deconstructCrush();
    else if (song.equals("Cycles")) deconstructCycles();
    else if (song.equals("WizRock")) deconstructWiz();
    else if (song.equals("Violate Expectations")) deconstructViolate();
    else if (song.equals("Mood #2")) deconstructMood();
    else if (song.equals("Song for M")) deconstructSong();
    else if (song.equals("Ellon")) deconstructEllon();
    else if (song.equals("Egrets")) deconstructEgrets();
    else if (song.equals("Intro")) deconstructIntro();
  }

  void resetScene() {
    isPlaying = false;
    songFile.pause();
    songFile.cue(0);
    deconstruct();
    println(song + " has ended");
  }
}



ArrayList<PImage> loadImages(String dir) {
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  if (mac) {
    java.io.File folder = new java.io.File(dataPath(dir));
    String[] filenames = folder.list();
    PImage p;
    //if (filenames != null) {
    for (int i = 0; i < filenames.length && i < MAX_IMG; i++) {
      if (!filenames[i].equals(".DS_Store")) {
        p = loadImage(dir + filenames[i]);
        imgs.add(p);
      }
    }
    //}
  } else {
    String dir2 = "C:\\Users\\User\\Desktop\\OneEyedJacks\\data\\scenes\\" + currentScene.shortName + "\\images";
    java.io.File folder = new java.io.File(dir2); 
    String[] filenames = folder.list();
    PImage p;
    if (filenames != null) {
      for (int i = 0; i < filenames.length; i++) {

        if (filenames[i].charAt(0) != '.') {
          println(dir2 + "\\" + filenames[i]);
          p = loadImage(dir + "\\" + filenames[i]);
          imgs.add(p);
        }
      }
    }
  }
  //println(imgs.size());
  return imgs;
}

String[] getFileNames(String dir) {
  java.io.File folder = new java.io.File(dataPath(dir));
  return folder.list();
}

ArrayList<Gif> loadGifs(String dir) {
  ArrayList<Gif> gifs = new ArrayList<Gif>();
  if (mac) {
    java.io.File folder = new java.io.File(dataPath(dir));
    String[] filenames = folder.list();
    Gif g;
    if (filenames != null) {
      for (int i = 0; i < filenames.length && i < MAX_GIF; i++) {
        if (!filenames[i].equals(".DS_Store")) {
          g = new Gif(this, dir + filenames[i]);
          gifs.add(g);
        }
      }
    }
  } else {
    String dir2 = "C:\\Users\\User\\Desktop\\OneEyedJacks\\data\\scenes\\" + currentScene.shortName + "\\gifs";
    java.io.File folder = new java.io.File(dir2); 
    String[] filenames = folder.list();
    Gif g;
    if (filenames != null) {
      for (int i = 0; i < filenames.length; i++) {

        if (filenames[i].charAt(0) != '.') {
          println(dir + "\\" + filenames[i]);
          g = new Gif(this, dir + "\\" + filenames[i]);
          gifs.add(g);
        }
      }
    }
  }
  return gifs;
}

ArrayList<Movie> loadMovies(String dir) {
  ArrayList<Movie> movies = new ArrayList<Movie>();
  java.io.File folder = new java.io.File(dataPath(dir));
  String[] filenames = folder.list();
  Movie m;
  for (int i = 0; i < filenames.length && i < MAX_MOV; i++) {
    if (!filenames[i].equals(".DS_Store")) {
      m = new Movie(this, dir + filenames[i]);
      movies.add(m);
    }
  }
  return movies;
}

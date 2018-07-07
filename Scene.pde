Scene[] scenes = new Scene[15];
Scene currentScene;
int currentSceneIndex = 0;
boolean isPlaying = false;
float tempo;

void initScenes() {
  scenes[0] = new Scene("When the Moon Comes", "moon", 1);
  scenes[1] = new Scene("Dirty", "dirty", 2);
  scenes[2] = new Scene("Fifty Fifty", "fifty", 3);
  scenes[3] = new Scene("Crush Proof", "crush", 4);
  scenes[4] = new Scene("Cycles", "cycles", 5);
  scenes[5] = new Scene("WizRock", "wizrock", 6);
  scenes[6] = new Scene("Violate Expectations", "violate", 7);
  scenes[7] = new Scene("Mood #2", "mood", 8);
  scenes[8] = new Scene("Delta Waves", "delta", 9);
  scenes[9] = new Scene("Song for M", "song", 10);
  scenes[10] = new Scene("Ellon", "ellon", 11);
  scenes[11] = new Scene("Rite of Spring", "rite", 12);
  scenes[12] = new Scene("Lollies", "lollies", 13);
  scenes[13] = new Scene("Egrets", "egrets", 14);
  scenes[14] = new Scene("Turn To Stone", "elo", 15);
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

  Scene(String s, String sn, int o) {
    song = s;
    shortName = sn;
    order = o;
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
    currentGifs = loadGifs("scenes/" + shortName + "/gifs/");
    currentImages = loadImages("scenes/" + shortName + "/images/");
    currentCue = 0;

    songFile = minim.loadFile("music/" + shortName + ".mp3", 1024);
    
    
    songFile.cue(0);
    songFile.pause();
    initBeat();

    startFade = false;
    currentCycle = 0;

    if (song.equals("Delta Waves")) initDelta();
    else if (song.equals("Rite of Spring")) initRite();
    else if (song.equals("When the Moon Comes")) initMoon();
    else if (song.equals("Lollies")) initLollies();
    else if (song.equals("Dirty")) initDirty();
    else if (song.equals("Fifty Fifty")) initFifty();
    else if (song.equals("Crush Proof")) initCrush();
    else if (song.equals("Cycles")) initCycles();
    else if (song.equals("WizRock")) initWiz();
    else if (song.equals("Violate Expectations")) initViolate();
    else if (song.equals("Mood #2")) initMood();
    else if (song.equals("Song for M")) initSong();
    else if (song.equals("Ellon")) initEllon();
    else if (song.equals("Egrets")) initEgrets();
  }


  void display() {
    if (isPlaying) {
      
      updateSpectrum();
      checkBeatReady(0);
      
      setCurrentCue();
      if (song.equals("Delta Waves")) displayDelta();
      else if (song.equals("Rite of Spring")) displayRite();
      else if (song.equals("When the Moon Comes")) displayMoon();
      else if (song.equals("Lollies")) displayLollies();
      else if (song.equals("Dirty")) displayDirty();
      else if (song.equals("Fifty Fifty")) displayFifty();
      else if (song.equals("Crush Proof")) displayCrush();
      else if (song.equals("Cycles")) displayCycles();
      else if (song.equals("WizRock")) displayWiz();
      else if (song.equals("Violate Expectations")) displayViolate();
      else if (song.equals("Mood #2")) displayMood();
      else if (song.equals("Song for M")) displaySong();
      else if (song.equals("Ellon")) displayEllon();
      else if (song.equals("Egrets")) displayEgrets();

      previousCycle = currentCycle;
      
      //songFile.update();
  
      if (currentCue == cues.length-1) {
        println("next");
        nextSong();
      }
      
      
      
    }
  }

  void resetScene() {
    isPlaying = false;
    songFile.pause();
    songFile.cue(0);
    println(song + " has ended");
  }
}



ArrayList<PImage> loadImages(String dir) {
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  java.io.File folder = new java.io.File(dataPath(dir));
  String[] filenames = folder.list();
  PImage p;
  for (int i = 0; i < filenames.length && i < MAX_IMG; i++) {
    if (!filenames[i].equals(".DS_Store")) {
      p = loadImage(dir + filenames[i]);
      imgs.add(p);
    }
  }
  return imgs;
}

String[] getFileNames(String dir) {
  java.io.File folder = new java.io.File(dataPath(dir));
  return folder.list();
}

ArrayList<Gif> loadGifs(String dir) {
  ArrayList<Gif> gifs = new ArrayList<Gif>();
  java.io.File folder = new java.io.File(dataPath(dir));
  String[] filenames = folder.list();
  Gif g;
  for (int i = 0; i < filenames.length && i < MAX_GIF; i++) {
    if (!filenames[i].equals(".DS_Store")) {
      g = new Gif(this, dir + filenames[i]);
      gifs.add(g);
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

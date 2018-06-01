Scene[] scenes = new Scene[14];
Scene currentScene;
int currentSceneIndex = 0;
boolean isPlaying = false;

void initScenes() {
  scenes[0] = new Scene("When the Moon Comes", 1);
  scenes[1] = new Scene("Dirty", 2);
  scenes[2] = new Scene("Fifty Fifty", 3);
  scenes[3] = new Scene("Crush Proof", 4);
  scenes[4] = new Scene("Cycles", 5);
  scenes[5] = new Scene("WizRock", 6);
  scenes[6] = new Scene("Violate Expectations", 7);
  scenes[7] = new Scene("Mood #2", 8);
  scenes[8] = new Scene("Delta Waves", 9);
  scenes[9] = new Scene("Song for M", 10);
  scenes[10] = new Scene("Ellon", 11);
  scenes[11] = new Scene("Rite of Spring", 12);
  scenes[12] = new Scene("Lollies", 13);
  scenes[13] = new Scene("Egrets", 14);
  currentScene = scenes[0];
}

void changeScene(int n) {
  if (n >=0 && n < scenes.length) {
    currentScene.resetScene();
    currentSceneIndex = n;
    currentScene = scenes[n];
    currentScene.init();
    isPlaying = false;
    println("Current scene: " + currentScene.song);
  }
}

void nextSong() {
  currentSceneIndex++;
  if (currentSceneIndex >= scenes.length) currentSceneIndex = 0;
  changeScene(currentSceneIndex);
}


void drawSongLabel() {
  textSize(30);
  fill(255);
  text(currentScene.order + ". " + currentScene.song, 50, 50);
}

class Scene {

  String song;
  int order;

  Scene(String s, int o) {
    song = s;
    order = o;
  }

  void playScene() {
    isPlaying = true;
    //timeStarted = millis();
    songFile.play();
    println(song + " is playing");
  }

  void pauseScene() {
    isPlaying = false;
    songFile.pause();
    println(song + " paused");
  }

  void update() {
    if (isPlaying) {
      if (songFile.position() >= songFile.length()-100) {
        resetScene();
        nextSong();
      }
    }
  }

  void init() {
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

    songFile.cue(0);
    songFile.pause();
    initBeat();
  }


  void display() {
    if (isPlaying) {
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
    }
  }

  void resetScene() {
    isPlaying = false;
    songFile.pause();
    songFile.cue(0);
    println(song + " has ended");
  }
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
void initCrush() {
  songFile = minim.loadFile("music/crush.mp3", 1024);
}
void initCycles() {
  songFile = minim.loadFile("music/cycles.mp3", 1024);
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

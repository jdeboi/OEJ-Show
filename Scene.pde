Scene[] scenes = new Scene[14];
Scene currentScene;
int currentSceneIndex = 0;
boolean isPlaying = false;

void initScenes() {
  scenes[0] = new Scene("When the Moon Comes", 1, 4000);
  scenes[1] = new Scene("Dirty", 2, 4000);
  scenes[2] = new Scene("Fifty Fifty", 3, 5000);
  scenes[3] = new Scene("Crush Proof", 4, 5000);
  scenes[4] = new Scene("Cycles", 5, 5000);
  scenes[5] = new Scene("WizRock", 6, 3000);
  scenes[6] = new Scene("Violate Expectations", 7, 3000);
  scenes[7] = new Scene("Mood #2", 8, 3001);
  scenes[8] = new Scene("Delta Waves", 9, 5000);
  scenes[9] = new Scene("Song for M", 10, 2000);
  scenes[10] = new Scene("Ellon", 11, 2300);
  scenes[11] = new Scene("Rite of Spring", 12, 3000);
  scenes[12] = new Scene("Lollies", 13, 5000);
  scenes[13] = new Scene("Egrets", 14, 2000);
  currentScene = scenes[0];
}

void changeScene(int n) {
  if (n >=0 && n < scenes.length) {
    currentScene.resetScene();
    currentSceneIndex = n;
    currentScene = scenes[n];
    println("changed to scene " + currentScene.song);
  }
}

void nextSong() {
  isPlaying = false;
  currentSceneIndex++;
  if (currentSceneIndex >= scenes.length) currentSceneIndex = 0;
  currentScene = scenes[currentSceneIndex];
}


void drawSongLabel() {
  textSize(30);
  fill(255);
  text(currentScene.song, 50, 50);
}

class Scene {

  String song;
  int order;
  long timeStarted, duration, timeRemaining;
  boolean songIsPlaying = false;

  Scene(String s, int o, int d) {
    song = s;
    order = o;
    duration = d;
    timeRemaining = duration;
  }

  void playScene() {
    songIsPlaying = true;
    timeStarted = millis();
    println(song + " is playing");
  }

  void pauseScene() {
    songIsPlaying = false;
    timeRemaining = timeRemaining - (millis() - timeStarted);
    println(song + " paused");
  }

  void update() {
    if (songIsPlaying) {
      if (getTimeRemaining() < 0) {
        resetScene();
        nextSong();
      }
    }
  }


  void display() {
    if (songIsPlaying) {
      //if (song.equals("Delta Waves")) displayDelta();
      //else if (song.equals("Rite of Spring")) displayRite();
      //else if (song.equals("When the Moon Comes")) displayMoon();
      //else if (song.equals("Lollies")) displayLollies();
      //else if (song.equals("Dirty")) displayDirty();
      //else if (song.equals("Fifty Fifty")) displayFifty();
      //else if (song.equals("Crush Proof")) displayCrush();
      //else if (song.equals("Cycles")) displayCycles();
      //else if (song.equals("WizRock")) displayWiz();
      //else if (song.equals("Violate Expectations")) displayViolate();
      //else if (song.equals("Mood #2")) displayMood();
      //else if (song.equals("Song for M")) displaySong();
      //else if (song.equals("Ellon")) displayEllon();
      //else if (song.equals("Egrets")) displayEgrets();
    }
  }
  
  

  long getTimeRemaining() {
    return timeRemaining - (millis() - timeStarted);
  }

  void resetScene() {
    songIsPlaying = false;
    timeRemaining = duration;
    println(song + " has ended");
  }
}

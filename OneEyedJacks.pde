boolean showTime = false;
boolean mappingON = false;
boolean useMusic = true;
boolean useTestKeystone = true;

int MOON = 1;
int DELTA = 8;
int WIZ = 5;
int VIOLATE = 6;
int ELLON =10;
int EGRETS = 13;
int LOLLIES = 12;
int CRUSH = 3;
int RITE = 11;
int ELO = 14;
int SONG = 9;
int LARGE_CENTER = 0;
//////////

import gifAnimation.*;
import processing.video.*;
boolean startShow = false;
Movie myMovie;

boolean bracketDown = false;
boolean slashDown = false;
PImage stage;

int MAX_GIF = 50;
int MAX_IMG = 50;
int MAX_MOV = 20;


PImage currentTestImg;
Gif currentTestGif;
String[] testingImages;
String[] testingGifs;
String[] testingMovies;

int mode = 5;
int GIF_ALL = 1;
int GIF_ACROSS = 2;
int IMG_ALL = 3;
int IMG_ACROSS = 4;
int FFT = 5;
int TILE_VID = 6;
int VID_ACROSS = 7;
int VID_MIRROR = 8;
int CUBE_MODE = 9;
int DIRTY = 2;


void setup() {
  fullScreen(P3D);
  initScenes();
  initScreens();

  //songFile = new Song(0, 0);
  //initFFT();
  initMidi();
  initMusic();
  initMask();
  initLines();

  if (!showTime) initControls();

  initColors();
  initEye();
  sphereEdgeInit();
  
  changeScene(DIRTY);
}

void draw() {
  blendMode(BLEND);
  background(0);

  if (mappingON) {
    //drawSolidAll(color(205, 0, 0));
    drawSolidAllCubes(color(205, 0, 0));
    renderScreens();
    checkEditing();
    if (showMask) maskScreens(color(50));
  } else {
    playShow();
    renderScreens();
    if (showMask) maskScreens(0);
  }
  checkClickTrack();

  drawControls();
}

void playShow() {
  if (isPlaying) {
    currentScene.update();
    currentScene.display();
  } else {
    blackoutScreens();
    if (betweenSongs) checkMidiStart();
  }
}

void keyPressed() {

  if (key == 'c') controlsON = !controlsON;
  else if (key == 'p') personOnPlatform = !personOnPlatform;

  if (bracketDown) {
    if (key == '0') changeScene(9);
    else if (key >= '1' && key <='9') changeScene(parseInt(key) - '0' - 1);
    else if (key == '-') changeScene(10);
    else if (key == '=') changeScene(11);
    else if (key == 'q') changeScene(12);
    else if (key == 'w') changeScene(13);
  } else if (slashDown) {
    if (isPlaying) {
      if (keyCode == RIGHT) songFile.skip(500);
      else if (keyCode == LEFT) songFile.skip(-500);
    }
  } else if (key == ' ') {
    if (!startShow) startShow = true;
    if (betweenSongs && backingTracks) startScene();
    else togglePlay();
  } else if (key == ']') {
    bracketDown = true;
  } else if (key == '/') {
    slashDown = true;
  }
}

void keyReleased() {
  if (key == ']') {
    bracketDown = false;
  } else if (key == '/') {
    slashDown = false;
  }
}

void mousePressed() {
  if (editingMask) checkMaskClick();
  //else if (editing3D) check3DClick();
  else if (editingLines) checkLineClick();
  mousePlayer();
}

void mouseReleased() {
  //cubesReleaseMouse();
  linesReleaseMouse();
}

void drawControls() {
  if (controlsON && mouseY < 300) {
    textSize(18);
    stroke(255);
    noFill();
    text("cue: " + currentCue, 50, 200);
    pushMatrix();
    drawSongLabel();
    drawPlayer();
    cp5.show();
    popMatrix();
  } else hideControls();
}

void hideControls() {
  cp5.hide();
}

void playScene() {
  currentScene.playScene();
}

void startScene() {
  midiStartTime = millis();
  //currentScene.startScene();
  clickTrackStarted = true;
  betweenSongs = false;
}

void pauseScene() {

  isPlaying = false;
  currentScene.pauseScene();
}

void togglePlay() {
  isPlaying = !isPlaying;
  if (isPlaying == true) {
    currentScene.playScene();
  } else currentScene.pauseScene();
}

void checkEditing() {
  strokeWeight(1);
  if (editingMask) {
    drawMaskPoints();
    moveSelectedMask();
  }
  if (editingMapping) {
    numberScreens();
    circleSphere();
  }
  if (editingLines) displayEditingLines();
}

boolean showTime = true;
boolean mappingON = false;
boolean useMusic = true;
boolean useTestKeystone = true;

int MOON = 1;
int DELTA = 8;
int WIZ = 5;
int VIOLATE = 6;
int ELLON =10;
int MOOD = 7;
int EGRETS = 13;
int LOLLIES = 12;
int CRUSH = 3;
int RITE = 11;
int SONG = 9;
int LARGE_CENTER = 0;
int DIRTY = 2;
int CYCLES = 4;
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
  initSpotLights();
  initControls();

  initColors();
  initEye();
  sphereEdgeInit();
  initNodesSym(4);
  initSymbols();
  changeScene(ELLON);
  frameRate(30);
}

void draw() {
  blendMode(BLEND);
  background(0);

  if (mappingON) {
    checkEditing();
    //drawSolidAll(color(205, 0, 0)); 
    drawSolidAllCubes(color(205, 0, 0));
    renderScreens();

    if (showMask) maskScreens(color(50));
  } else {
    playShow();
    renderScreens();
    if (showMask) maskScreens(0);
  }
  checkClickTrack();
  //displaySpotLights();
  checkMidiStart();
  drawControls();

  //pushMatrix();
  //translate(0, 0, 3);
  //if (lightning) {
  //  fill(lightningColor);
  //  rect(0, 0, width, height);
  //}
  //popMatrix();
}

boolean inbetweenViz = false;
void playShow() {
  if (isPlaying) {
    inbetweenViz = false;
    currentScene.update();
    currentScene.display();
  } else if(inbetweenViz) {
    displaySymbolParticlesAll();
  } else {
    blackoutScreens();
    //if (betweenSongs) checkMidiStart();
  }
}

void keyPressed() {

  if (key == 'c') controlsON = !controlsON;
  else if (key == 'p') togglePlatform();
  else if (key == 'e') mappingON =!mappingON;
  else if (key == 'l') toggleSpotLights();
  else if (key == 'b') inbetweenViz = true;
  else if (key == 'f') if (fc!=null) fc.explodeFlocking();
  if (bracketDown) {
    if (key == '0') changeScene(9);
    else if (key >= '0' && key <='9') changeScene(parseInt(key) - '0');
    else if (key == '-') changeScene(10);
    else if (key == '=') changeScene(11);
    else if (key == 'q') changeScene(12);
    else if (key == 'w') changeScene(13);
  } else if (slashDown) {
    if (isPlaying) {
      if (keyCode == RIGHT) skipSong(150);
      else if (keyCode == LEFT) skipSong(-150);
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
    if (showTime) cursor(CROSS);
    textSize(18);
    stroke(255);
    noFill();
    if (!showTime) text("cue: " + currentCue, 50, 200);
    pushMatrix();
    drawPlayer();
   
    if (!showTime) drawSongLabel();
    if (!showTime) cp5.show();
    popMatrix();

    // draw framerate
    if (!showTime) {
      textSize(50);
      noStroke();
      fill(255);
      pushMatrix();
      translate(200, 0, 3);
      text(frameRate, 50, 50);
      popMatrix();
    }
  } else hideControls();
}

void hideControls() {
  if (showTime) noCursor();
  cp5.hide();
}

void playScene() {
  currentScene.playScene();
}

void startScene() {
  inbetweenViz = false;
  blackoutScreens();
  pauseScene();
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

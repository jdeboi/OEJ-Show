boolean showTime = false;
boolean isTesting = false;
boolean mappingON = false;
boolean useMusic = true;
//////////

import gifAnimation.*;
import processing.video.*;
boolean startShow = false;
Movie myMovie;

boolean bracketDown = false;
boolean slashDown = false;
PImage stage;
//ArrayList<PImage> images;

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

  initFFT();
  initMidi();

  //initTesting();
  changeScene(0);


  //testControls();
  if (!showTime) initControls();

  initMask();
  centerScreen.drawSolid(color(0));
  initLines();
}

void draw() {
  background(0);

  if (mappingON) {
    //drawSolidAll(color(205, 0, 0));
    drawSolidAllCubes(color(205, 0, 0));
    renderScreens();
    checkEditing();
    if (showMask) maskScreens(color(50));
  } else {
    if (isTesting) testShow();
    else playShow();
    renderScreens();
    if (showMask) maskScreens(0);
  }

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
  // cp5.get(Textfield.class, "input").isFocus() &&
  if (key == 'c') controlsON = !controlsON;
  if ( selected > -1 && editingBreaks) {
    //println(cp5.get(Textfield.class, "input").getText());
    //breaks.get(selected).text = cp5.get(Textfield.class, "input").getText();
  } else {
    if (bracketDown) {
      if (key == '0') changeScene(9);
      else if (key >= '1' && key <='9') changeScene(parseInt(key) - '0' - 1);
      else if (key == '-') changeScene(10);
      else if (key == '=') changeScene(11);
      else if (key == 'q') changeScene(12);
      else if (key == 'w') changeScene(13);
    } else if (slashDown) {
      if (isPlaying) {
        if (keyCode == RIGHT) songFile.skip(15000);
        else if (keyCode == LEFT) songFile.skip(-1000);
      }
    } // && !cp5.get(Textfield.class, "input").isFocus()
    else if (key == ' ') {
      if (!startShow) startShow = true;
      togglePlay();
    } else if (key == ']') {
      bracketDown = true;
    } else if (key == '/') {
      slashDown = true;
    } else if (editingBreaks) {
      if (selected > -1) {
        if (keyCode == LEFT) breaks.get(selected).move(50);
        else if (keyCode == RIGHT) breaks.get(selected).move(-50);
        else if (key == 'd') {
          breaks.remove(selected);
          resetHighlights();
          selected = -1;
        } else breaks.get(selected).breakType = key;
      }
      breaks.add(new Break(songFile.position(), key));
    }
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
  if (editingBreaks) {
    selected = -1;
    for (int i = 0; i < breaks.size(); i++) {
      if (breaks.get(i).mouseOver()) {
        resetHighlights();
        selected = i;
        breaks.get(i).highlight = true;
        return;
      }
    }
  } else if (editingMask) checkMaskClick();
  else if (editing3D) check3DClick();
  else if (editingLines) checkLineClick();
  mousePlayer();
}

void mouseReleased() {
  cubesReleaseMouse();
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
    drawBreakInfo();
    popMatrix();
  } else hideControls();
}

void hideControls() {
  cp5.hide();
}

void initTesting() {
  testingImages = getFileNames("_testing/images/");
  currentTestImg = loadImage("_testing/images/" + testingImages[0]);
  testingGifs = getFileNames("_testing/gifs/");
  currentTestGif = new Gif(this, "_testing/gifs/" + testingGifs[0]);

  testingMovies = getFileNames("_testing/movies/");

  initVid("_testing/movies/" + testingMovies[0]);

  if (MAX_GIF > testingGifs.length) MAX_GIF=testingGifs.length;
  if (MAX_IMG > testingImages.length) MAX_IMG=testingImages.length;
  if (MAX_MOV > testingMovies.length) MAX_MOV=testingMovies.length;

  //stage = loadImage("_testing/images/stage.png");

  initCurvyNetwork();
  //initConst();
  //initHands();
  initTesseract();
  //initParticles();
  initTerrainCenter();
  //initCubes();

  initTreeBranchesAll();
  initWaves();
  initDisplayFlowyWaves(centerScreen.s);
}

void playScene() {
  isPlaying = true;
  currentScene.playScene();
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
  strokeWeight(10);
  if (editingLines) displayEditingLines();
}

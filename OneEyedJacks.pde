boolean isTesting = true;
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

void setup() {
  //size(1200, 800, P3D);
  fullScreen(P3D);
  initScenes();
  initTesting();
  changeScene(3);

  initScreens();
  initControls();
  initMask();
  initConst();
  initHands();
  initTesseract();
  initParticles(); 
}

void draw() {
  background(0);


  // are we testing imagery or playing the show?
  if (isTesting) testShow();
  else playShow();

  renderScreens();

  //maskScreens();


  // control bar
  if (mouseY < 300) drawControls();
  else hideControls();
}

void testShow() {

  // do we want to see the stage?
  //image(stage, 0, 0, width, stage.height * width/stage.width);

  ///////////////////////////// 
  // CUSTOM SCRIPTS
  //drawCNAll();
  //drawSolidAll(color(255, 0, 0));
  //displayRainbow();
  drawSolidAll(color(0));
  displayShadowLines(30, 5);
  haromAll(color(255), 3);

  ///////////////////////////// 
  // GIF
  if (mode == GIF_ALL) drawGifAll(currentTestGif, 0, 0, screenW, screenH);
  else if (mode == GIF_ACROSS) {
    int y = int(map(mouseY, 0, height, -550, 0));
    drawGifAcross(currentTestGif, y);
  }

  ///////////////////////////// 
  // IMAGE
  else if (mode == IMG_ALL) drawImageAll(currentTestImg, 0, 0, screenW, screenH);
  else if (mode == IMG_ACROSS) {
    int y = int(map(mouseY, 0, height, -550, 0));
    drawImageAcross(currentTestImg, y);
  }

  ///////////////////////////// 
  // FFT
  else if (mode == FFT) {
    //drawFFT();
    //drawSolidAll(color(0));
    //drawFFTBarsAll();
    
    
    //drawSpectrum(30);
    //cycleShapeFFT();
    //cycleConstFFT();
    //cycleHandsFFT();
    //drawSpectrumAcross();
    //drawSpectrumMirror();
    //drawTriangleSpectrum();
    //displayTesseract();
    //beatTile();
    //displayParticles();
    //drawWaveForm();
  }

  ///////////////////////////// 
  // VIDEO
  else if (mode == TILE_VID) tileVid(vid1, 0, 0);
  else if (mode == VID_ACROSS) movieAcrossAll(vid1, -100);
  else if (mode == VID_MIRROR) mirrorVidCenter(vid1, 0, 0);

  
  
  if (useCenterScreen) {
    centerScreen.drawSolid(color(0));
  }
  //snakeOutlineAll(color(255), 30, 150, 5);
  //drawOutlineAll(color(255), 10);
}

void playShow() {
  if (isPlaying) {
    currentScene.update();
    currentScene.display();
  } else {
    blackoutScreens();
  }
  if (editingMask) {
    drawMaskPoints();
    moveSelectedMask();
  }
}

void keyPressed() {
  // cp5.get(Textfield.class, "input").isFocus() &&
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
  mousePlayer();
}



void drawControls() {
  drawSongLabel();
  drawPlayer();
  cp5.show();
  drawBreakInfo();
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

  stage = loadImage("_testing/images/stage.png");

  initCurvyNetwork();

  initFFT();
}

void togglePlay() {
  isPlaying = !isPlaying;
  if (isPlaying == true) {
    currentScene.playScene();
  } else currentScene.pauseScene();
}

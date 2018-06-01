
boolean bracketDown = false;
boolean slashDown = false;
PImage pattern;
PImage stage;

import gifAnimation.*;
Gif gifAcross;
Gif gifPanel;

import processing.video.*;
Movie myMovie;


void setup() {
  size(1200, 800, P3D);
  initScenes();
  initScreens();
  
  initTesting();
  currentScene.init();
}

void draw() {
  background(0);
  drawSongLabel();
  playShow();
  //testShow();
  renderScreens();
}

void testShow() {
  //image(stage, 0, 0, width, stage.height * width/stage.width);
  drawSolidAll(color(0));
  //snakeOutlineAll(color(255), 30, 150, 5);
  //drawCNAll();
  //drawGifAll(gifPanel, 0, 0, screenW, screenH);
  //drawGifAcross(gifAcross, 0);
  drawFFTBarsAll();
  //drawImageAll(pattern, 0, 0, screenW, screenH);
  //int y = int(map(mouseY, 0, height, -550, 0));
  //drawImageAcross(pattern, y);
  //drawOutlineAll(color(255), 30);; 
  //drawFFT();
}

void playShow() {
  if (isPlaying) {
    currentScene.update();
    currentScene.display();
  } else {
    blackoutScreens();
  }
}

void keyPressed() {
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
  } else if (key == ' ') {
    isPlaying = !isPlaying;
    if (isPlaying == true) currentScene.playScene();
    else currentScene.pauseScene();
  } else if (key == ']') {
    bracketDown = true;
  } else if (key == '/') {
    slashDown = true;
  } else {
    switch(key) {
    case 'c':
      // toggle moveable edges
      ks.toggleCalibration();
      break;
    case 's':
      // saves the layout
      ks.save();
      break;
    }
  }
}

void keyReleased() {
  if (key == ']') {
    bracketDown = false;
  }
  else if (key == '/') {
    slashDown = false;
  }
}

void mousePressed() {
  mousePlayer();
}

void initTesting() {
  stage = loadImage("stage.png");
  
  initCurvyNetwork();
  
  initFFT();
  
  gifAcross = new Gif(this, "patterns/spiral.gif");
  gifAcross.loop();
  
  gifPanel = new Gif(this, "patterns/star_tunnel.gif");
  gifPanel.loop();
  
  pattern = loadImage("dave.jpg");
}

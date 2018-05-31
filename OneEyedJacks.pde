
boolean bracketDown = false;
PImage pattern;

void setup() {
  size(1200, 800, P3D);
  initScenes();
  initScreens();

  // testing purposes
  pattern = loadImage("patterns/triangle_folds.jpg");
  initCurvyNetwork();
}

void draw() {
  background(0);
  //playShow();
  testShow();
  renderScreens();
}

void testShow() {
  //drawSolidAll(color(255, 0, 0));
  
  //snakeOutlineAll(color(255), 30, 150, 5);
  drawCNAll();
  drawOutlineAll(color(255), 30);; //drawImageAll(pattern, 0, raw
}

void playShow() {
  if (isPlaying) {
    currentScene.update();
    currentScene.display();
    drawSongLabel();
  } else {
    blackoutScreens();
  }
}

void keyPressed() {
  if (bracketDown) { 
    if (key >= '0' && key <='9') {
      changeScene(parseInt(key) - '0');
    }
  } else if (key == ' ') {
    isPlaying = !isPlaying;
    if (isPlaying == true) currentScene.playScene();
    else currentScene.pauseScene();
  } else if (key == ']') {
    bracketDown = true;
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
}

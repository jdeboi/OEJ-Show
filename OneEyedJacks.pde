
boolean bracketDown = false;
boolean slashDown = false;
PImage pattern;
PImage stage;
boolean isTesting = false;

ArrayList<PImage> images;

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
  initControls();
  changeScene(0);
}

void draw() {
  background(0);

  // are we testing imagery or playing the show?
  if (isTesting) testShow();
  else playShow();
  renderScreens();
  
  // control bar
  if (mouseY < 300) drawControls();
  else hideControls();
}

void testShow() {
  //image(stage, 0, 0, width, stage.height * width/stage.width);
  //drawSolidAll(color(0));
  //snakeOutlineAll(color(255), 30, 150, 5);
  //drawCNAll();
  //drawGifAll(gifPanel, 0, 0, screenW, screenH);
  //drawGifAcross(gifAcross, 0);
  //drawFFTBarsAll();
  //drawImageAll(pattern, 0, 0, screenW, screenH);
  //int y = int(map(mouseY, 0, height, -550, 0));
  //drawImageAcross(pattern, y);
  
  //drawFFT();
  //drawLines();
  //tileVid(vid2, 0, 0);
  //movieAcrossAll(vid2, -100);
  //mirrorVidCenter(vid1, 0, 0);
  //drawOutlineAll(color(255), 10);
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
  if (cp5.get(Textfield.class, "input").isFocus() && selected > -1 && editingBreaks) {
    println(cp5.get(Textfield.class, "input").getText());
    breaks.get(selected).text = cp5.get(Textfield.class, "input").getText();
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
    } else if (key == ' ' && !cp5.get(Textfield.class, "input").isFocus()) {
      isPlaying = !isPlaying;
      if (isPlaying == true) currentScene.playScene();
      else currentScene.pauseScene();
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
  } 
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
  stage = loadImage("_testing/images/stage.png");

  initCurvyNetwork();

  initFFT();

  gifAcross = new Gif(this, "_testing/gifs/spiral.gif");
  gifAcross.loop();

  gifPanel = new Gif(this, "_testing/gifs/star_tunnel.gif");
  gifPanel.loop();

  pattern = loadImage("_testing/images/dave.jpg");
  
  initVid("_testing/movies/vid1.mp4", "_testing/movies/explosion.mp4");
}

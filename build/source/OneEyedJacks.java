import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 
import processing.video.*; 
import java.util.*; 
import java.util.LinkedList; 
import java.util.List; 
import themidibus.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import controlP5.*; 
import java.util.*; 
import processing.video.*; 
import deadpixel.keystone.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OneEyedJacks extends PApplet {

boolean isTesting = false;
//////////



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

public void setup() {
  //size(1200, 800, P3D);
  
  initScenes();
  initScreens();
  initMidi();

  initTesting();
  changeScene(3);


  initControls();
  initMask();
   centerScreen.drawSolid(color(0));
}

public void draw() {
  background(0);

  // are we testing imagery or playing the show?
  if (isTesting) testShow();
  else playShow();

  renderScreens();

  if (showMask) maskScreens();


  //// control bar
  if (mouseY < 300) drawControls();
  else hideControls();

  if (editingMask) {
    drawMaskPoints();
    moveSelectedMask();
  }
}

public void testShow() {

  // do we want to see the stage?
  //image(stage, 0, 0, width, stage.height * width/stage.width);

  /////////////////////////////
  // CUSTOM SCRIPTS
  //drawCNAll();
  //drawSolidAll(color(0));
  //displayShadowLines(50, 30, 5);

  //mirrorVidCenter(vid1, 0, 0);
  //displayShadowRainbow();
  //drawSolidAll(color(0));
  //haromAll(color(255), 3);
  //displayMoonsAcross();
  //displayFlowyWaves(centerScreen.s);


  //displayTreeBranchesAll();
  //displayFractalTreeAll(1);

  //displayShadowRainbow();
  //centerScreen.drawSolid(color(0));
  //displayTerrainCenter();  // no mesh
  //displayTerrainSplit();
  //drawStream();
  //drawSolidAll(color(0));
  //displayWavesCenter();
  //centerScreen.drawSolid(color(0));
  //displayLineBounceAll();

  //displayMoveSpaceCenter();
  //displayMoveSpaceAll();
  //displayRedPlanetAll();
  //displayRedPlanet(centerScreen.s);

  /////////////////////////////
  // GIF
  if (mode == GIF_ALL) drawGifAll(currentTestGif, 0, 0, screenW, screenH);
  else if (mode == GIF_ACROSS) {
    int y = PApplet.parseInt(map(mouseY, 0, height, -550, 0));
    drawGifAcross(currentTestGif, y);
  }

  /////////////////////////////
  // CUBES
  else if (mode == CUBE_MODE) {
    display3D();
    updateCubes();
  }

  /////////////////////////////
  // IMAGE
  else if (mode == IMG_ALL) drawImageAll(currentTestImg, 0, 0, screenW, screenH);
  else if (mode == IMG_ACROSS) {
    int y = PApplet.parseInt(map(mouseY, 0, height, -550, 0));
    drawImageAcross(currentTestImg, y);
  }

  /////////////////////////////
  // FFT
  else if (mode == FFT) {
    //drawFFT();
    //drawSolidAll(color(0));
    //drawFFTBarsAll();
    //displayAmplitudeHoriz();


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



  //if (useCenterScreen) {
  //centerScreen.drawSolid(color(0));
  //centerScreen.drawImage(currentTestImg,0, 0);
  //}
  //snakeOutlineAll(color(0, 255, 255), 30, 150, 5);
  drawOutlineAll(color(255, 0, 0), 10);

  if (editingMapping) numberScreens();
}

public void playShow() {
  if (isPlaying) {
    currentScene.update();
    currentScene.display();
  } else if (betweenSongs){
    blackoutScreens();
    checkMidiStart();
  } else {
    blackoutScreens();
  }
}

public void keyPressed() {
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

public void keyReleased() {
  if (key == ']') {
    bracketDown = false;
  } else if (key == '/') {
    slashDown = false;
  }
}

public void mousePressed() {
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
  mousePlayer();
}

public void mouseReleased() {
  cubesReleaseMouse();
}

public void drawControls() {
  pushMatrix();
  translate(0, 100);
  drawSongLabel();
  drawPlayer();
  cp5.show();
  drawBreakInfo();
  popMatrix();
}

public void hideControls() {
  cp5.hide();
}

public void initTesting() {
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
  initFFT();
}

public void playScene() {
  isPlaying = true;
  currentScene.playScene();
}

public void pauseScene() {
  isPlaying = false;
  currentScene.pauseScene();
}

public void togglePlay() {
  isPlaying = !isPlaying;
  if (isPlaying == true) {
    currentScene.playScene();
  } else currentScene.pauseScene();
}

boolean ADD_ON = false;
int selected = -1;
boolean editingBreaks = false;




ArrayList<Break> breaks;
int currentBreak = 0;

int xSpace = 50;
int vW = 600;
int vH = 40;
int ySpace = 150;
int infoX = 400;
int infoY = 150;

class Break {

  int songT;
  char breakType;
  int x, y;
  boolean highlight = false;
  String text;

  Break(int t, char b, int x, int y) {
    songT = t;
    breakType = b;
    this.x = x;
    this.y = y;
  }
  Break(int t, char b) {
    songT = t;
    breakType = b;
    x = PApplet.parseInt(map(songT, 0, songFile.length(), xSpace, xSpace + vW));
    y = ySpace;
  }
  Break(int t, String b, int x, int y, String txt) {
    songT = t;
    breakType = b.charAt(0);
    this.x = x;
    this.y = y;
    text = txt;
  }

  public void display() {
    stroke((parseInt(breakType)*15)%255, 255, 255);
    strokeWeight(1);
    if (mouseOver() || highlight) strokeWeight(3);
    line(x, y+1, x, y + vH - 2);
    //if (highlight) {
    //  noFill();
    //  stroke(200);
    //  rect(x-1, y, 3, vH);
    //}
  }


  public void displayInfo() {
    if (mouseOver() || highlight) {
    strokeWeight(1);
    stroke(255);
    String t = "'" + breakType + "'" + ": " + timeString(songT) + "\n" + text;
    myTextarea.setText(t);
    }
  }


  public boolean mouseOver() {
    int sp = 5;

    return (mouseX > x - sp/2 && mouseX < x + sp/2 && mouseY > ySpace && mouseY < ySpace + vH);
  }

  public void move(int t) {
    songT -= t;
    if (songT < 0) songT = 0;
    else if (songT >= songFile.length()) songT = songFile.length() -1;
  }
}

public String timeString(int mil) {
  return nf(mil/1000.0f, 3, 2);
}

public void sortByTime() {
  bubbleSort();
}

public void bubbleSort() {
  int n = breaks.size();

  for (int i=0; i < n; i++) {
    for (int j=1; j < (n-i); j++) {

      if (breaks.get(j-1).songT > breaks.get(j).songT) {
        //swap the elements!
        Collections.swap(breaks, j, j-1);
      }
    }
  }
}

public void saveToFile() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("numBreaks", breaks.size());
  json.setInt("songLen", songFile.length());
  saveJSONObject(json, "data/breaks/" + currentScene.song + "_breaks.json");

  processing.data.JSONArray breakList = new processing.data.JSONArray();      

  for (int i = 0; i < breaks.size(); i++) {
    processing.data.JSONObject breakJSON = new processing.data.JSONObject();
    Break b = breaks.get(i);
    breakJSON.setInt("time", b.songT);
    breakJSON.setString("text", b.text);
    breakJSON.setString("breakType", str(b.breakType));

    breakList.setJSONObject(i, breakJSON);
  }

  json.setJSONArray("breakList", breakList);


  saveJSONObject(json, "data/breaks/" + currentScene.song + "_breaks.json");
}


public void loadBreaks() {
  processing.data.JSONObject breaksJson;
  breaksJson = loadJSONObject("data/breaks/" + currentScene.song + "_breaks.json");
  int numBreaks = breaksJson.getInt("numBreaks");
  int songLen = breaksJson.getInt("songLen");
  println(numBreaks);
  //resetBreaks();

  processing.data.JSONArray breaksArray = breaksJson.getJSONArray("breakList");
  for (int i = 0; i < numBreaks; i++) {
    processing.data.JSONObject b = breaksArray.getJSONObject(i);
    String breakType = b.getString("breakType");
    int t = b.getInt("time");
    String txt = b.getString("text");
    println(t);
    int x = PApplet.parseInt(map(t, 0, songLen, xSpace, xSpace + vW));
    int y = ySpace;
    breaks.add(new Break(t, breakType, x, y, txt));
  }
}

public void resetBreaks() {
  breaks = new ArrayList<Break>();
}

public void initBreaks() {
  breaks = new ArrayList<Break>();
  if (ADD_ON) loadBreaks();
}

public void drawPlayer() {
  stroke(255);
  strokeWeight(1);
  noFill();
  //if (editingBreaks) fill(255);
  rect(xSpace, ySpace, vW, vH);
  float position = map( songFile.position(), 0, songFile.length(), xSpace, xSpace+vW );
  stroke(255, 0, 0);
  line( position, ySpace, position, ySpace+vH );

  for (int i = 0; i < breaks.size(); i++) {
    breaks.get(i).display();
  }
  stroke(255);
  strokeWeight(1);
  textSize(12);
  timeText.setText((nf(songFile.position()/1000.0f, 3, 2)));
  //text(nf(songFile.position()/1000.0, 3,2), xSpace, ySpace + vH);
}

public void drawSongLabel() {
  textSize(20);
  fill(255);
  text(currentScene.order + ". " + currentScene.song, xSpace, ySpace - 10);
}

public void mousePlayer() {
  int x = xSpace;
  int y = ySpace;
  int w = vW;
  int h = vH;
  if (mouseY > y && mouseY < y + h && mouseX > x && mouseX < x + w) {
    int position = PApplet.parseInt( map( mouseX, x, x+w, 0, songFile.length() ) );
    songFile.cue( position );
    setCurrentCue();
    println("current cue: " + currentCue);
    if (currentCue != -1) cues[currentCue].initCue();
  } else {
    //if (!cp5.get(Textfield.class, "input").isMouseOver()) {
      resetHighlights();
      selected = -1;
    //}
  }
}

public void resetHighlights() {
  for (Break b : breaks) {
    b.highlight = false;
  }
}

public void drawBreakInfo() {
  strokeWeight(1);
  //if (editingBreaks && selected > -1) {
  //  breaks.get(selected).displayInfo();
  //} 
  if (editingBreaks) {
    for (Break b : breaks) {
      b.displayInfo();
    }
  }
}

public void drawLines() {
  for (int i = 0; i < songFile.bufferSize() - 1; i++) {
    line(i, 50  + songFile.left.get(i)*50, i+1, 50  + songFile.left.get(i+1)*50);
    line(i, 150 + songFile.right.get(i)*50, i+1, 150 + songFile.right.get(i+1)*50);
  }
}

//void drawModeLabel() {
//  if (editingBreaks) {
//    noStroke();
//    fill(150, 255, 255);
//    rect(0,height-50, width, 50);
//    fill(255);
//    stroke(255);
//    textSize(30);
//    text("EDITING BEATS", 35, height - 15);
//  }
//}
 //Import the library
MidiBus myBus; // The MidiBus
long lastMidi = 0;
boolean midiPlayed = false;
boolean betweenSongs = true;

//////////////////////////////////////////////////////////////////////////////////
// INITIALIZE CUES
//////////////////////////////////////////////////////////////////////////////////
public void initCrush() {
  initVid("scenes/crush/movies/crush.mp4");
  cues = new Cue[11];
  cues[0] = new Cue(0, 'm', 0, 0);
  //cues[1] = 5;
  //cues[2] = 9.7;   // X
  //cues[3] = 14.4;  // X
  //cues[4] = 17.0;  // Break happens
  //cues[5] = 19;    // X
  cues[1] = new Cue(28.8f, 'v', 0.0f, 0);   // chords slow
  cues[2] = new Cue(38, 'g', 0.0f, 0);    // chords slow
  cues[3] = new Cue(47.5f, 'g', 0.0f, 1);  // guitar
  cues[4] = new Cue(56, 'g', 0.0f, 2);    // guitar
  cues[5] = new Cue(66, 'm', 20.0f, 0);    // X
  //cues[6] = new Cue('v', 0, 75);   // X
  cues[6] = new Cue(85, 'g', 0.0f, 3);   // xylophone
  cues[7] = new Cue(94, 'v', 0.0f, 0);
  cues[8] = new Cue(103.8f, 'v', 0.0f, 0);
  cues[9] = new Cue(135, 'v', 0.0f, 0);
  cues[10] = new Cue(songFile.length(), 'v', 0.0f, 0);
}

public void initDelta() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(135, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initRite() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initMoon() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initLollies() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}

public void initCycles() {
  initVid("scenes/cycles/movies/vid1.mp4");
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}

public void initDirty() {
  cues = new Cue[11];
  cues[0] = new Cue(0, 'v', 0, 0);
  cues[1] = new Cue(6, 'v', 0.0f, 0);
  cues[2] = new Cue(12, 'v', 0.0f, 0); // tic toc begins
  cues[3] = new Cue(55, 'v', 0.0f, 0); // down chords
  cues[4] = new Cue(77, 'v', 0.0f, 0);  // tic toc
  cues[5] = new Cue(99, 'v', 0.0f, 0);  // down chords
  cues[6] = new Cue(121, 'v', 0.0f, 0);  // down chords
  cues[7] = new Cue(143, 'v', 0.0f, 0);  // down chords
  cues[8] = new Cue(99, 'v', 0.0f, 0);  // down chords
  cues[9] = new Cue(175, 'v', 0.0f, 0);  // down chords
  cues[10] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initFifty() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initWiz() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initViolate() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initMood() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initSong() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initEllon() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}
public void initEgrets() {
  cues = new Cue[3];
  cues[0] = new Cue(0, 'm', 0, 0);
  cues[1] = new Cue(5, 'v', 0.0f, 0);
  cues[2] = new Cue(songFile.length(), 'v', 0.0f, 0);
}

//////////////////////////////////////////////////////////////////////////////////
// DISPLAY CUES
//////////////////////////////////////////////////////////////////////////////////
public void displayCrush() {
  switch(currentCue) {
  case 0:
    movieAcrossAll(vid1, -350);
    haromCenter(color(255), 3, 180);
    //displayNervous();
     //displayWavyCircle();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  case 2:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 3:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 4:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    break;
  case 5:
    movieAcrossAll(vid1, -370);
    break;
  case 6:
    drawSolidAll(color(0));
    displayNervous();
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

public void displayDelta() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    haromCenter(color(255), 3, 180);
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

public void displayRite() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawImageAll(currentImages.get(0), 0, 0);
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

public void displayMoon() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

public void displayLollies() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}


public void displayCycles() {
  switch(currentCue) {
  case 0:
    mirrorVidCenter(vid1, -100, 0);
    break;
  case 1:
    drawSolidAll(color(0));
    drawImageAll(currentImages.get(0), 0, 0);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

public void displayDirty() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayFifty() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayWiz() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayViolate() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayMood() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displaySong() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayEllon() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}
public void displayEgrets() {
  switch(currentCue) {
  case 0:
    drawSolidAll(color(0));
    drawFFTBarsAll();
    break;
  case 1:
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
}

//////////////////////////////////////////////////////////////////////////////////
// CUE CLASS
//////////////////////////////////////////////////////////////////////////////////
Cue [] cues;
int currentCue = -1;
ArrayList<Gif> currentGifs;
ArrayList<PImage> currentImages;
int currentGif = -1;

class Cue {
  char type;
  float startT;
  float movieStartT;
  int gifNum;

  Cue(float tim, char t, float mt, int g) {
    startT = tim;
    type = t;
    movieStartT = mt;
    gifNum = g;
  }

  public void initCue() {
    if (type == 'm') {
      vidIsPlaying = true;
      skipVid();
    } else {
      vidIsPlaying = false;
      pauseVids();
    }
    if (type == 'g') {
      currentGif = gifNum;
      for (Gif g : currentGifs) {
        g.noLoop();
      }
      currentGifs.get(currentGif).loop();
    }
  }

  public void pauseCue() {
    pauseVids();
  }

  public void skipVid() {
    if (type == 'm') {
      playVids();
      if (vid1 != null) {
        vid1.jump(songFile.position()*1.0f/1000.0f - startT + movieStartT);
      }
    }
  }
}

public void setCurrentCue() {
  int c = -1;

  for (Cue cue : cues) {
    if (songFile.position() > cue.startT*1000) {
      c++;
      if (c >= cues.length) {
        c = cues.length -1;
        if (c != currentCue) {
          currentCue = c;
          cues[currentCue].initCue();
        }
        return;
      }
    } else {
      if (c != currentCue) {
        currentCue = c;
        cues[currentCue].initCue();
      }
      return;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// MIDI CUES
/////////////////////////////////////////////////////////////////////////////////////
public void initMidi() {
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, 1, "Gervill"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  myBus.sendTimestamps(false);
}

public boolean checkMidiStart() {
  if (midiPlayed) {
    midiPlayed = false;
    playScene();
    return true;
  }
  return false;
}

public void noteOn(int channel, int pitch, int velocity) {
  printNote(channel, pitch, velocity, true);
  lastMidi = millis();
  midiPlayed = true;
}

public void noteOff(int channel, int pitch, int velocity) {
  printNote(channel, pitch, velocity, false);
  // lastMidi = millis();
}

public void printNote(int channel, int pitch, int velocity, boolean isOn) {
  String o = isOn?"On":"Off";
  println();
  println("Note " + o + ":");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

public void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}



Minim minim;
AudioPlayer songFile;
BeatDetect beat;
BeatListener bl;
int previousCycle = 0;

FFT         myAudioFFT;

int         myAudioRange     = 256;
int         myNumBands       = 11;
int         myAudioMax       = 100;
int[]       bandBreaks       = {20, 50, 60, 80, 100, 150, 175, 200, 225, 255};
int[]       bands            = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float       myAudioAmp       = 170.0f;
float       myAudioIndex     = 0.2f;
float       myAudioIndexAmp  = myAudioIndex;
float       myAudioIndexStep = 0.55f;

float       myAudioAmp2       = 250.0f;
float       myAudioIndex2     = 2.0f;
float       myAudioIndexAmp2  = 0.8f;
float       myAudioIndexStep2 = 2;


class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source) {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  public void samples(float[] samps) {
    beat.detect(source.mix);
  }

  public void samples(float[] sampsL, float[] sampsR) {
    beat.detect(source.mix);
  }
}

public void initFFT() {
  minim = new Minim(this);
  songFile = minim.loadFile("music/moon.mp3", 1024);


  myAudioFFT = new FFT(songFile.bufferSize(), songFile.sampleRate());
  myAudioFFT.linAverages(myAudioRange);
  //myAudioFFT.window(FFT.GAUSS);
}

public void initBeat() {
  beat = new BeatDetect(songFile.bufferSize(), songFile.sampleRate());
  beat.setSensitivity(200);  
  bl = new BeatListener(beat, songFile);
}

public void drawSpectrum(int w) {
  updateSpectrum();
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.colorMode(HSB, bands.length);
    for (int i = 0; i < bands.length; i++) {
      s.s.fill(i, bands.length, bands.length);
      s.s.noStroke();
      s.s.rect(i*w, 40, w, bands[i]);
    }
    s.s.colorMode(RGB, 255);
    s.s.endDraw();
  }
}

int currentCycle = 0;
int lastCheckedShape = 0;
public void beatCycle(int delayT) {
  if (bands[3] > 225 && millis() - lastCheckedShape > delayT) {
    lastCheckedShape = millis();
    currentCycle++;
  }
}
public void cycleShapeFFT() {
  updateSpectrum();
  beatCycle(300);
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.noFill();
    sc.s.strokeWeight(3);
    sc.s.rectMode(CENTER);
    if (currentCycle%4 == 0) sc.s.ellipse(screenW/2, screenH/2, screenW/4, screenW/4);
    else if (currentCycle%4 == 1) sc.s.rect(screenW/2, screenH/2, screenW/4, screenW/4);
    else if (currentCycle%4 == 2) {
      int sz = screenW/4;
      int x = screenW/2;
      int y = screenH/2;
      float alt = sz*sqrt(3)/2.0f;
      sc.s.triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2);
    } else sc.s.line(screenW/2, screenH/2 - screenW/8, screenW/2, screenH/2 + screenW/8);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
  }
}

PImage[] constellations;
PImage[] hands;
public void initConst() {
  constellations = new PImage[5];
  constellations[0] = loadImage("images/constellations/0.png");
  constellations[1] = loadImage("images/constellations/1.png");
  constellations[2] = loadImage("images/constellations/2.png");
  constellations[3] = loadImage("images/constellations/3.png");
  constellations[4] = loadImage("images/constellations/4.png");
}
public void cycleConstFFT() {
  updateSpectrum();
  beatCycle(300);
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.noFill();
    sc.s.strokeWeight(3);
    sc.s.rectMode(CENTER);
    int imgSize = 100;
    sc.drawImage(constellations[currentCycle%constellations.length], screenW/2 -imgSize/2, screenH/2 - imgSize/2, imgSize, imgSize);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
  }
}
public void initHands() {
  hands = new PImage[5];
  hands[0] = loadImage("images/hand/hand0.jpg");
  hands[1] = loadImage("images/hand/hand1.jpg");
  hands[2] = loadImage("images/hand/hand2.jpg");
  hands[3] = loadImage("images/hand/hand3.jpg");
  hands[4] = loadImage("images/hand/hand4.jpg");
}
public void cycleHandsFFT() {
  updateSpectrum();
  beatCycle(300);
  int j = 0;
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.noFill();
    sc.s.strokeWeight(3);
    sc.s.rectMode(CENTER);

    int imgW = 400;
    int imgH = PApplet.parseInt(hands[(currentCycle+j)%hands.length].height *  imgW*1.0f/hands[(currentCycle+j)%hands.length].width);
    sc.drawImage(hands[(currentCycle+j)%hands.length], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //if (currentCycle%hands.length == j) sc.drawImage(hands[0], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //else  sc.drawImage(hands[4], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
    j++;
  }
}


public void beatTile() {
  updateSpectrum();
  beatCycle(300);
  int k = 0;
  for (Screen sc : screens) {
    sc.s.beginDraw();
    int numW = (currentCycle%4)+1;
    int w = screenW/numW;
    int h = hands[(currentCycle+k)%hands.length].height * w/hands[(currentCycle+k)%hands.length].width;
    int numH = screenH/h;
    for (int i = 0; i < numW; i++) {
      for (int j = 0; j < numH+1; j++) {
        sc.s.image(hands[(currentCycle+k)%hands.length], i * w, j * h, w, h);
      }
    }
    k++;
    sc.s.endDraw();
  }
}

public void drawTriangleSpectrum() {
  int numBands = 10;
  float rectW = screenW / numBands/2;
  float rectH = screenH / numBands/2;

  int j = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    for (int i = 0; i < numBands; ++i) {
      if ( beat.isOnset(i) ) {
        s.stroke(255);
        s.strokeWeight(3);
        if (j==0 ) {
          s.line( i*rectW, screenH, screenW*2, screenH-i*rectH);
          s.line( i*rectW, 0, screenW*2, i*rectH);
        } else if (j==1) {
          s.line( i*rectW - screenW, screenH, screenW, screenH-i*rectH);
          s.line( i*rectW - screenW, 0, screenW, i*rectH);
        } else if (j==2) {
          s.line( 0, screenH-i*rectH, i*rectW + screenW, screenH);
          s.line( 0, i*rectH, i*rectW + screenW, 0);
        } else {
          s.line( -screenW, screenH-i*rectH, i*rectW, screenH);
          s.line( -screenW, i*rectH, i*rectW, 0);
        }
      }
    }
    s.endDraw();
    j++;
  }
}

public void drawWaveForm() {
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.strokeWeight(5);
    int j = 0;
    for (int i = 0; i < screenW; i++) {
      sc.s.line(i, screenH/2-50  + songFile.left.get(i + j * screenW)*50, (i+1), screenH/2-50  + songFile.left.get(i+1 + j * screenW)*50);
      sc.s.line(i, screenH/2+50 + songFile.right.get(i + j * screenW)*50, (i+1), screenH/2+50 + songFile.right.get(i+1 + j * screenW)*50);
    }
    j++;
    sc.s.endDraw();
  }
}

public void drawSpectrumMirror() {
  int numBands = 20;
  int w = PApplet.parseInt(screenW * 2.0f / numBands);
  int j = 0;

  float temp = 0;
  Screen s1 = screens[1];
  Screen s2 = screens[2];

  float t = myAudioIndexAmp2;
  s1.s.beginDraw();
  for (int i = 0; i <= numBands/2; i++) {
    myAudioIndexAmp2 += myAudioIndexStep2;
    temp = myAudioFFT.getAvg(i + numBands/2 * j);
    temp *= myAudioIndexAmp2;

    s1.s.fill(255);
    s1.s.noStroke();
    s1.s.rect(screenW-i*w, screenH, w, -temp );
  }
  s1.s.endDraw();

  s2.s.beginDraw();
  myAudioIndexAmp2 = t;
  for (int i = 0; i <= numBands/2; i++) {
    myAudioIndexAmp2 += myAudioIndexStep2;
    temp = myAudioFFT.getAvg(i + numBands/2 * j);
    temp *= myAudioIndexAmp2;

    s2.s.fill(255);
    s2.s.noStroke();
    s2.s.rect(i*w, screenH, w, -temp );
  }
  s2.s.endDraw();


  j++;

  s1 = screens[0];
  s2 = screens[3];

  s1.s.beginDraw();
  t = myAudioIndexAmp2;
  for (int i = 0; i < numBands/2; i++) {
    myAudioIndexAmp2 += myAudioIndexStep2;
    temp = myAudioFFT.getAvg(i + numBands/2 * j);
    temp *= myAudioIndexAmp2;

    s1.s.fill(255);
    s1.s.noStroke();
    s1.s.rect(screenW-i*w, screenH, w, -temp );
  }
  myAudioIndexAmp2 = t;
  s1.s.endDraw();
  s2.s.beginDraw();
  for (int i = 0; i < numBands/2; i++) {
    myAudioIndexAmp2 += myAudioIndexStep2;
    temp = myAudioFFT.getAvg(i + numBands/2 * j);
    temp *= myAudioIndexAmp2;
    s2.s.fill(255);
    s2.s.noStroke();
    s2.s.rect(i*w, screenH, w, -temp );
  }
  s2.s.endDraw();
  myAudioIndexAmp = myAudioIndex;
  myAudioIndexAmp2 = myAudioIndex2;
}
public void drawSpectrumAcross() {
  int numBands = 80;
  int w = PApplet.parseInt(screenW * 4.0f / numBands);
  int j = 0;
  for (Screen s : screens) {
    float temp = 0;
    s.s.beginDraw();
    for (int i = 0; i < numBands/4; i++) {
      myAudioIndexAmp2 += myAudioIndexStep2;
      temp = myAudioFFT.getAvg(i + numBands/4 * j);
      temp *= myAudioIndexAmp2;
      s.s.fill(255);
      s.s.noStroke();
      s.s.rect(i*w, screenH, w, -temp );
    }
    s.s.endDraw();
    j++;
  }
  myAudioIndexAmp = myAudioIndex;
  myAudioIndexAmp2 = myAudioIndex2;
}

public void updateSpectrum() {
  myAudioFFT.forward(songFile.mix);

  int bandIndex = 0;
  while (bandIndex < bandBreaks.length) {
    float temp = 0;
    int startB = 0; 
    int endB = 0;
    if (bandIndex == 0) {
      startB = -1;
      endB = bandBreaks[bandIndex];
    } else if (bandIndex < bandBreaks.length) {
      startB = bandBreaks[bandIndex-1];
      endB = bandBreaks[bandIndex];
    }
    for (int j = startB+1; j <= endB; j++) {
      myAudioIndexAmp2 += myAudioIndexStep2;
      temp += myAudioFFT.getAvg(j);
    }
    temp /= endB - startB;
    temp *= myAudioAmp*myAudioIndexAmp;
    myAudioIndexAmp+=myAudioIndexStep;
    bands[bandIndex] = PApplet.parseInt(temp);
    bandIndex++;
  }
  myAudioIndexAmp = myAudioIndex;
  myAudioIndexAmp2 = myAudioIndex2;
}

public void displayAmplitudeHoriz() {
  int lev = PApplet.parseInt(map((songFile.left.level() + songFile.right.level())/2, 0, 0.5f, 0, screenW*4));

  for (int i = 0; i < screens.length; i++) {
    screens[i].s.beginDraw();
    //screens[i].s.background(color(0));
    screens[i].s.noStroke();
    screens[i].s.fill(0, 80);
    screens[i].s.rect(0, 0, screenW, screenH);
    
    screens[i].s.fill(255);
    screens[i].s.rect(0, 0, constrain(lev - screenW * i, 0, screenW*4), screenH);
    screens[i].s.endDraw();
  }
}

public void drawFFT() {
  // draw a green rectangle for every detect band
  // that had an onset this frame
  float rectW = width / beat.detectSize();
  for (int i = 0; i < beat.detectSize(); ++i)
  {
    // test one frequency band for an onset
    if ( beat.isOnset(i) )
    {
      fill(0, 200, 0);
      rect( i*rectW, 0, rectW, height);
    }
  }

  // draw an orange rectangle over the bands in 
  // the range we are querying
  int lowBand = 5;
  int highBand = 15;
  // at least this many bands must have an onset 
  // for isRange to return true
  int numberOfOnsetsThreshold = 4;
  if ( beat.isRange(lowBand, highBand, numberOfOnsetsThreshold) )
  {
    fill(232, 179, 2, 200);
    rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, height);
  }

  //if ( beat.isKick() ) kickSize = 32;
  //if ( beat.isSnare() ) snareSize = 32;
  //if ( beat.isHat() ) hatSize = 32;
}

MPoint [][] maskPoints;
boolean editingMask = false;
MPoint selectedP = null;
boolean showMask = true;

public void initMask() {
  maskPoints = new MPoint[numMappings][10];
  loadMasks();
}


public void saveMaskPoints() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  processing.data.JSONArray maskList = new processing.data.JSONArray();      

  for (int j = 0; j < numMappings; j++) {
    for (int i = 0; i < maskPoints[0].length; i++) {
      processing.data.JSONObject maskJSON = new processing.data.JSONObject();
      maskJSON.setInt("x", maskPoints[j][i].x);
      maskJSON.setInt("y", maskPoints[i][i].y);

      maskList.setJSONObject(i, maskJSON);
    }

    json.setJSONArray("maskList", maskList);
    saveJSONObject(json, "data/mask/maskPoints_" + j + ".json");
  }
}

public void loadMasks() {
  for (int i = 0; i < numMappings; i++) {
    loadMask(i);
  }
}

public void loadMask(int index) {
  processing.data.JSONObject maskJson;
  maskJson = loadJSONObject("data/mask/maskPoints_"+ index + ".json");

  processing.data.JSONArray maskArray = maskJson.getJSONArray("maskList");
  for (int i = 0; i < 10; i++) {
    processing.data.JSONObject m = maskArray.getJSONObject(i);
    int x = m.getInt("x");
    int y = m.getInt("y");
    maskPoints[index][i] = new MPoint(x, y);
  }
}

public void moveSelectedMask() {
  if (selectedP != null) {
    selectedP.move();
  }
}

public void drawMaskPoints() {
  for (MPoint mp : maskPoints[keystoneNum]) {
    mp.display();
  }
}

public void checkMaskClick() {
  if (selectedP == null) {
    for (MPoint mp : maskPoints[keystoneNum]) {
      if (mp.mouseOver()) {
        selectedP = mp;
        return;
      }
    }
  } else selectedP = null;
}


public void maskScreens() {
  fill(0);
  noStroke();
  beginShape();
  vertex(0, maskPoints[keystoneNum][0].y);
  for (MPoint mp : maskPoints[keystoneNum]) {
    vertex(mp.x, mp.y);
  }
  vertex(0, maskPoints[keystoneNum][9].y);
  vertex(0, height);
  vertex(width, height);
  vertex(width, 0);
  vertex(0, 0);
  endShape();
  quad(0, maskPoints[keystoneNum][0].y, maskPoints[keystoneNum][0].x, maskPoints[keystoneNum][0].y, maskPoints[keystoneNum][9].x, maskPoints[keystoneNum][9].y, 0, maskPoints[keystoneNum][9].y);
}

class MPoint {
  int x, y;

  MPoint(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public void display() {
    noFill();
    stroke(0, 255, 255);
    ellipse(x, y, 15, 15);
    fill(0, 255, 255);
    ellipse(x, y, 5, 5);
  }

  public boolean mouseOver() {
    float d = dist(x, y, mouseX, mouseY);
    return d < 5;
  }

  public void move() {
    x = mouseX;
    y = mouseY;
  }
}
 

ControlP5 cp5;

// start / stop music

Toggle togMap, togEdit, togShow, togP, togEditMask, togMask, togEdit3D;
Textlabel timeText;
Textarea myTextarea;
int ymen = 100;

public void initControls() {
  cp5 = new ControlP5(this);

  //togShow = cp5.addToggle("toggleShow")
  //  .setPosition(50, 150)
  //  .setSize(50, 20)
  //  .setValue(false)
  //  .setLabel("Testing OFF")
  //  .setMode(ControlP5.SWITCH)
  //  ;

  // create a toggle and change the default look to a (on/off) switch look
  togMap = cp5.addToggle("toggleMap")
    .setPosition(750, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Map OFF")
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addButton("saveMap")
    .setValue(0)
    .setPosition(750, 200)
    .setSize(80, 19)
    .setLabel("Save Mapping")
    ;

  //cp5.addButton("saveMapAs")
  //  .setValue(0)
  //  .setPosition(750, 250)
  //  .setSize(80, 19)
  //  .setLabel("Save New Map")
  //  ;

  togP = cp5.addToggle("toggleP")
    .setPosition(xSpace, ySpace + vH + 30)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("PLAY")
    ;

  togEdit = cp5.addToggle("toggleEditBreak")
    .setPosition(850, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Breaks Off")
    .setMode(ControlP5.SWITCH)
    ;

  togEditMask = cp5.addToggle("toggleEditMask")
    .setPosition(950, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Mask Off")
    .setMode(ControlP5.SWITCH)
    ;
    
  togMask = cp5.addToggle("toggleMask")
    .setPosition(950, 100)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Mask Off")
    .setMode(ControlP5.SWITCH)
    ;

  togEdit3D = cp5.addToggle("toggleEdit3D")
    .setPosition(1100, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit 3D Off")
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addButton("saveCubes")
    .setValue(0)
    .setPosition(1100, 200)
    .setSize(80, 19)
    .setLabel("Save Cubes")
    ;

  cp5.addButton("saveMask")
    .setValue(0)
    .setPosition(950, 200)
    .setSize(80, 19)
    .setLabel("Save Mask")
    ;

  cp5.addButton("saveBreaks")
    .setValue(0)
    .setPosition(850, 200)
    .setSize(80, 19)
    .setLabel("Save Breaks")
    ;

  timeText = cp5.addTextlabel("label")
    .setText(nf(0))
    .setPosition(xSpace, ySpace + 50)
    ;

  //cp5.addTextfield("input")
  //  .setPosition(500, 150)
  //  .setSize(200, 20)
  //  .setFocus(false)
  //  ;

  //myTextarea = cp5.addTextarea("txt")
  //  .setPosition(500, 200)
  //  .setSize(300, 50)
  //  .setColor(color(128))
  //  .setColorBackground(color(255, 100))
  //  .setColorForeground(color(255, 100));
  //;
  //myTextarea.setText("");



  String[] songNames = new String[scenes.length];
  for (int i = 0; i < scenes.length; i++) {
    songNames[i] = (i+1) + ". " + scenes[i].shortName;
  }
  List l = Arrays.asList(songNames);
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("songs")
    .setColorBackground(color(10, 155, 0))
    .setPosition(0, ymen)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("GIF_ALL", "GIF_ACROSS", "IMG_ALL", "IMG_ACROSS", "FFT", "TILE_VID", "VID_ACROSS", "VID_MIRROR");
  cp5.addScrollableList("modeList")
    .setPosition(150, ymen)
    .setColorBackground(color(105, 10, 0))
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList(subset(getFileNames("_testing/gifs/"), 0, MAX_GIF));
  cp5.addScrollableList("gifs")
    .setPosition(300, ymen)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList(subset(getFileNames("_testing/images/"), 0, MAX_IMG));
  cp5.addScrollableList("imageList")
    .setPosition(450, ymen)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList(subset(getFileNames("_testing/movies/"), 0, MAX_MOV));
  cp5.addScrollableList("movieList")
    .setPosition(600, ymen)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("0", "1");
  cp5.addScrollableList("keystoneList")
    .setPosition(750, ymen)
    .setColorBackground(color(105, 110, 0))
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("moveXY", "moveZ", "rotateX", "rotateY", "rotateZ", "scale");
  cp5.addScrollableList("cubeEdit")
    .setPosition(850, ymen)
    .setColorBackground(color(105, 170, 0))
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

}


public void modeList(int n) {
  mode = n + 1;
}

public void movieList(int n) {
  initVid("_testing/movies/" + testingMovies[n]);
}

public void imageList(int n) {
  currentTestImg = loadImage("_testing/images/" + testingImages[n]);
}

public void cubeEdit(int n) {
  cubeMode = n;
  println("cube mode : " + cubeMode);
}

public void keystoneList(int n) {
  keystoneNum = n;
  loadKeystone(n);
}

public void gifs(int n) {
  currentTestGif = new Gif(this, "_testing/gifs/" + testingGifs[n]);
  currentTestGif.loop();
}

public void songs(int n) {
  changeScene(n);
}

public void saveMap(int theValue) {
  println("map saved " + keystoneNum);
  if (useCenterScreen) ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
  else ks.save("data/keystone/keystone" + keystoneNum + ".xml");
}

//public void saveMapAs(int theValue) {
//  if (millis() > 10000) keystoneNum++;
//  println("map saved as " + keystoneNum);
//  if (useCenterScreen) ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
//  else ks.save("data/keystone/keystone" + keystoneNum + ".xml");
//}

public void saveMask(int theValue) {
  println("mask saved");
  saveMaskPoints();
}

public void saveCubes(int theValue) {
  println("cubes saved");
  saveCubes();
}

public void saveBreaks(int theValue) {
  println("breaks saved");
  bubbleSort();
  saveToFile();
}

public void input(String theText) {
  if (editingBreaks && selected > -1) {
    println(theText + " " + selected);
    breaks.get(selected).text = theText;
  }
}

public void toggleP(boolean theFlag) {
  if (startShow) {
    togglePlay();
    if (isPlaying) {
      togP.setLabel("PAUSE");
    } else {
      togP.setLabel("PLAY");
    }
  }
}

public void toggleEditMask(boolean theFlag) {
  editingMask = theFlag;
  String o = editingMask?"ON":"OFF";
  togEditMask.setLabel("Edit Mask " + o);
  println("toggling edit mask");
}

public void toggleMask(boolean theFlag) {
  showMask = theFlag;
  String o = showMask?"ON":"OFF";
  togMask.setLabel("Mask " + o);
  println("toggling show mask");
}

public void toggleEdit3D(boolean theFlag) {
  editing3D = theFlag;
  String o = editing3D?"ON":"OFF";
  togEdit3D.setLabel("Edit 3D " + o);
  println("toggling edit 3D");
}

public void toggleEditBreak(boolean theFlag) {
  editingBreaks = theFlag;
  String o = editingBreaks?"ON":"OFF";
  togEdit.setLabel("Edit Breaks " + o);
  println("toggling edit");
}

//void toggleShow(boolean theFlag) {
//  if (theFlag) {
//    isTesting = theFlag;
//    togShow.setLabel("TESTING");
//  }
//  else {
//    isTesting = false;
//    changeScene(0);
//    togShow.setLabel("SHOW TIME");
//  }
//}


public void toggleMap(boolean theFlag) {
  editingMapping = theFlag;
  if (theFlag) ks.startCalibration();
  else ks.stopCalibration();
  String o = theFlag?"ON":"OFF";
  togMap.setLabel("Map " + o);
}

Movie vid1;
Movie vid2;
boolean vidIsPlaying = false;
boolean vid1IsPlaying = false;

public void initVid(String path1) {
  vid1 = new Movie(this, path1);
  vid2 = null;
  vid1IsPlaying = true;
  vidIsPlaying = true;
  pauseVids();
}

public void initVid(String path1, String path2) {
  vid1 = new Movie(this, path1);
  vid2 = new Movie(this, path2);
  vid1IsPlaying = true;
  vidIsPlaying = true;
  pauseVids();
}

public void playVids() {
  if (vid1IsPlaying && vid1 != null) {
    vid1.play();
    vid1.volume(0);
  } else if (vid2 != null) {
    vid2.play();
    vid2.volume(0);
  }
}

public void stopVids() {
  pauseVids();
  vidIsPlaying = false;
}

public void pauseVids() {
  if (vid1 != null) vid1.stop();
  if (vid2 != null) vid2.stop();
}

public void mirrorVidCenter(Movie m, int x, int y) {
  screens[1].drawImage(m, x, y);
  screens[2].drawImageMirror(m, x, y);
}

public void displayVid(Movie m, int screen, int x, int y) {
  screens[screen].drawImage(m, x, y);
}

public void movieAcrossAll(Movie m, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(m, -i*screenW, y, screenW*4, g.height*screenW*4/g.width);
  }
}

public void tileVid(Movie m, int x, int y) {
  for (int i = 0; i < 4; i++) {
    screens[i].drawImage(m, x, y);
  }
}

// Called every time a new frame is available to read
public void movieEvent(Movie m) {
  m.read();
}
Scene[] scenes = new Scene[14];
Scene currentScene;
int currentSceneIndex = 0;
boolean isPlaying = false;

public void initScenes() {
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
  currentScene = scenes[0];
}

public void changeScene(int n) {
  if (n >=0 && n < scenes.length) {
    currentScene.resetScene();
    currentSceneIndex = n;
    currentScene = scenes[n];
    currentScene.init();
    isPlaying = false;
    betweenSongs = true;
    initBreaks();
    println("Current scene: " + currentScene.song);
  }
}

public void nextSong() {
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

  public void playScene() {
    betweenSongs = false;
    isPlaying = true;
    //timeStarted = millis();
    songFile.play();
    println(song + " is playing");

    if (currentCue != -1) cues[currentCue].initCue();
  }

  public void pauseScene() {
    isPlaying = false;
    songFile.pause();
    println(song + " paused");

    if (currentCue != -1) cues[currentCue].pauseCue();
  }

  public void update() {
  }

  public void init() {
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

    currentGifs = loadGifs("scenes/" + shortName + "/gifs/");
    currentImages = loadImages("scenes/" + shortName + "/images/");
    currentCue = 0;

    songFile = minim.loadFile("music/" + shortName + ".mp3", 1024);
    songFile.cue(0);
    songFile.pause();
    initBeat();
  }


  public void display() {
    if (isPlaying) {
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
    }
  }

  public void resetScene() {
    isPlaying = false;
    songFile.pause();
    songFile.cue(0);
    println(song + " has ended");
  }
}



public ArrayList<PImage> loadImages(String dir) {
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  java.io.File folder = new java.io.File(dataPath(dir));
  String[] filenames = folder.list();
  PImage p;
  for (int i = 0; i < filenames.length && i < MAX_IMG; i++) {
    p = loadImage(dir + filenames[i]);
    imgs.add(p);
  }
  return imgs;
}

public String[] getFileNames(String dir) {
  java.io.File folder = new java.io.File(dataPath(dir));
  return folder.list();
}

public ArrayList<Gif> loadGifs(String dir) {
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

public ArrayList<Movie> loadMovies(String dir) {
  ArrayList<Movie> movies = new ArrayList<Movie>();
  java.io.File folder = new java.io.File(dataPath(dir));
  String[] filenames = folder.list();
  Movie m;
  for (int i = 0; i < filenames.length && i < MAX_MOV; i++) {
    m = new Movie(this, dir + filenames[i]);
    movies.add(m);
  }
  return movies;
}
// to modify keystone lib and then make a jar file: jar cvf keystone.jar .

Keystone ks;
Keystone ksC;
int keystoneNum = 0;
CornerPinSurface [] surfaces;
CornerPinSurface centerSurface;
Screen [] screens;
Screen centerScreen;
boolean useCenterScreen = true;
int numScreens = 4;
int screenW = 400;
int screenH = 400;
int centerX, centerY;
boolean editingMapping = false;
int numMappings = 2;

class Screen {

  PGraphics s;
  int snakeLoc;
  Star[] stars;
  //Tesseract tesseract;

  Screen(int w, int h) {
    s = createGraphics(w, h, P3D);
    snakeLoc = PApplet.parseInt(random(0, w*2 + h*2));
    //stars = new Star[30];
    //for (int i = 0; i < stars.length; i++) {
    //  stars[i] = new Star();
  }

  public void blackOut() {
    s.beginDraw();
    s.background(0);
    s.endDraw();
  }

  public void drawSolid(int c) {
    s.beginDraw();
    s.background(c);
    s.endDraw();
  }

  public void drawCN() {
    s.beginDraw();
    s.strokeWeight(1);
    s.stroke(255);
    drawCurvyNetwork(s);
    s.endDraw();
  }

  public void drawGif(Gif g, int x, int y, int w, int h) {
    s.beginDraw();
    s.image(g, x, y, w, h);
    s.endDraw();
  }

  public void drawImage(PImage img, int x, int y) {
    s.beginDraw();
    s.image(img, x, y);
    s.endDraw();
  }

  public void drawBlend(PImage img1, PImage img2, int x, int y, int mode) {
    s.beginDraw();
    s.image(img1, x, y);
    s.blend(img2, x, y, screenW, screenH, x, y, screenW, screenH, mode);
    s.endDraw();
  }

  public void drawImageMirror(PImage img, int x, int y) {
    s.beginDraw();
    s.pushMatrix();
    s.scale(-1.0f, 1.0f);
    s.image(img, -screenW+x, y);
    s.popMatrix();
    s.endDraw();
  }

  public void drawFFTBars() {
    s.beginDraw();
    float rectW = screenW / beat.detectSize();
    for (int i = 0; i < beat.detectSize(); ++i) {    
      if ( beat.isOnset(i) ) {  // test one frequency band for an onset
        s.fill(200);
        s.rect( i*rectW, 0, rectW, screenH);
      }
    }
    int lowBand = 5;
    int highBand = 15;
    int numberOfOnsetsThreshold = 4; // at least this many bands must have an onset for isRange to return true 
    if ( beat.isRange(lowBand, highBand, numberOfOnsetsThreshold) ) {
      s.fill(232, 0, 2, 200);
      s.rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, screenH);
    }
    s.endDraw();
  }
  
  //void drawFFTHoriz(color c, int sw) {
  //  s.beginDraw();
    
  //  for (int i = 0; i < beat.detectSize(); ++i) {    
  //    if ( beat.isOnset(i) ) {  // test one frequency band for an onset
  //      s.stroke(c);
  //      s.noFill();
  //      s.rect( i*rectW, 0, rectW, screenH);
  //    }
  //  }
  //  int lowBand = 5;
  //  int highBand = 15;
  //  int numberOfOnsetsThreshold = 4; // at least this many bands must have an onset for isRange to return true 
  //  if ( beat.isRange(lowBand, highBand, numberOfOnsetsThreshold) ) {
  //    s.fill(232, 0, 2, 200);
  //    s.rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, screenH);
  //  }
  //  s.endDraw();
  //}

  public void drawImage(PImage img, int x, int y, int w, int h) {
    s.beginDraw();
    s.image(img, x, y, w, h);
    s.endDraw();
  }

  public void drawTriangle(int c, int sw, int x, int y, int sz) {
    s.beginDraw();
    s.strokeWeight(sw);
    s.stroke(c);
    s.noFill();
    float alt = sz*sqrt(3)/2.0f;
    s.triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2); //50, 50, 100, 10, 150, 50);
    s.endDraw();
  }

  public void outlineScreen(int c, int sw) {
    s.beginDraw();
    s.noFill();
    s.strokeWeight(sw);
    s.stroke(c);
    s.rect(0, 0, screenW, screenH);
    s.endDraw();
  }

  public void snakeOutline(int c, int sw, int sLen, int speed) {
    s.beginDraw();
    s.noFill();
    s.strokeWeight(sw);
    s.stroke(c);
    int maxSnake = screenW*2 + screenH*2;
    snakeLoc += speed;
    if (snakeLoc > maxSnake) snakeLoc = 0;

    // going clockwise starting from top left corner
    if (snakeLoc < screenW) {
      int sLoc = snakeLoc;
      if (sLoc > sLen) s.line(sLoc - sLen, 0, sLoc, 0);
      else {
        s.line(0, 0, sLoc, 0);
        s.line(0, sLen - sLoc, 0, 0);
      }
    } else if (snakeLoc < screenW + screenH) {
      int sLoc = snakeLoc - screenW;
      if (sLoc > sLen) s.line(screenW, sLoc - sLen, screenW, sLoc);
      else {
        s.line(screenW - (sLen-sLoc), 0, screenW, 0);
        s.line(screenW, 0, screenW, sLoc);
      }
    } else if (snakeLoc < screenW*2 + screenH) {
      int sLoc = snakeLoc - screenW - screenH;
      if (sLoc > sLen) s.line(screenW - sLoc, screenH, screenW - sLoc + sLen, screenH);
      else {
        s.line(screenW, screenH, screenW - sLoc, screenH);
        s.line(screenW, screenH - sLen + sLoc, screenW, screenH);
      }
    } else {
      int sLoc = snakeLoc - 2*screenW - screenH;
      if (sLoc > sLen) s.line(0, screenH - sLoc, 0, screenH - sLoc + sLen);
      else {
        s.line(0, screenH, 0, screenH - sLoc);
        s.line(sLen - sLoc, screenH, 0, screenH);
      }
    }
    s.endDraw();
  }
}

public void blackoutScreens() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].blackOut();
  }
}

public void drawSolidAll(int c) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawSolid(c);
  }
}

public void drawCNAll() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawCN();
  }
}

public void snakeOutlineAll(int c, int sw, int sLen, int speed) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].snakeOutline(c, sw, sLen, speed);
  }
}

public void drawOutlineAll(int c, int sw) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].outlineScreen(c, sw);
  }
}

public void drawImageAll(PImage img, int x, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, x, y);
  }
}

public void drawImageAll(PImage img, int x, int y, int w, int h) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, x, y, w, h);
  }
}

public void drawGifAll(Gif g, int x, int y, int w, int h) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawGif(g, x, y, w, h);
  }
}

public void drawImageAcross(PImage img, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(img, -i*screenW, y, screenW*4, img.height*screenW*4/img.width);
  }
}

public void drawGifAcross(Gif g, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawGif(g, -i*screenW, y, screenW*4, g.height*screenW*4/g.width);
  }
}

public void drawFFTBarsAll() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawFFTBars();
  }
}


public void initScreens() {
  ks = new Keystone(this);
  if (useCenterScreen) ksC = new Keystone(this);
  surfaces = new CornerPinSurface[numScreens];
  screens = new Screen[numScreens];
  for (int i = 0; i < numScreens; i++) {
    surfaces[i] = ks.createCornerPinSurface(screenW, screenH, 20);
    screens[i] = new Screen(screenW, screenH);
  }
  if (useCenterScreen) {
    centerSurface = ks.createCornerPinSurface(screenW*4, screenH, 20);
    centerScreen = new Screen(screenW*4, screenH);
  }
  loadKeystone(0);
}

public void loadKeystone(int i) {
  if (useCenterScreen) ks.load("data/keystone/keystoneCenter" +  i + ".xml");
  else ks.load("data/keystone/keystone" +  i + ".xml");
}

public void renderScreens() {
  pushMatrix();
  translate(0, 0, -1);
  for (int i = 0; i < numScreens; i++) {
    surfaces[i].render(screens[i].s);
  }
  if (useCenterScreen) centerSurface.render(centerScreen.s);
  popMatrix();
}

public void numberScreens() {
  for (int i = 0; i < numScreens; i++) {
    screens[i].s.beginDraw();
    screens[i].s.fill(255);
    screens[i].s.noStroke();
    screens[i].s.textSize(50);
    screens[i].s.text(i, 50, 50);
    screens[i].s.endDraw();
  }
}
boolean editing3D = false;
boolean isDragging = false;
int cubeMode = 0;
int moveMode = 0;
int moveModeZ = 1;
int rotateModeX = 2;
int rotateModeY = 3;
int rotateModeZ = 4;
int changeScaleMode = 5;
Cube selectedCube;

ArrayList<Cube> cubes;

public void initCubes() {
  //cubes = new ArrayList<Cube>();
  //cubes.add(new Cube(new PVector(100, 300, -50), new PVector(radians(-10), 0, 0), screenW/4, color(255)));
  //cubes.add(new Cube(new PVector(500, 300, -50), new PVector(radians(-10), 0, 0), screenW/4, color(255)));
  loadCubes();
}

public void display3D() {
  lights();
  noStroke();
  for (Cube c : cubes) {
    c.display();
  }
}

public void cubesReleaseMouse() {
  isDragging = false;
  selectedCube = null;
}

public void check3DClick() {
  for (Cube c : cubes) {
    if (c.mouseOver()) {
      selectedCube = c;
      isDragging = true;
      return;
    }
  }
  selectedCube = null;
  isDragging = false;
  return;
}

public void updateCubes() {
  if (isDragging) {
    if (cubeMode == moveMode) {
      selectedCube.move();
    } else if (cubeMode == moveModeZ) {
      selectedCube.moveZ();
    }else if (cubeMode == rotateModeX) {
      selectedCube.rotateCX();
    }else if (cubeMode == rotateModeY) {
      selectedCube.rotateCY();
    }else if (cubeMode == rotateModeZ) {
      selectedCube.rotateCZ();
    }
    else if (cubeMode == changeScaleMode) {
      selectedCube.changeScale();
    }
  }
}

public void saveCubes() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("numCubes", cubes.size());
  saveJSONObject(json, "data/cubes/cubes.json");

  processing.data.JSONArray cubesList = new processing.data.JSONArray();      

  for (int i = 0; i < cubes.size(); i++) {
    processing.data.JSONObject cubeJSON = new processing.data.JSONObject();
    Cube c = cubes.get(i);
    cubeJSON.setFloat("x", c.loc.x);
    cubeJSON.setFloat("y", c.loc.y);
    cubeJSON.setFloat("z", c.loc.z);
    
    cubeJSON.setFloat("rx", c.rot.x);
    cubeJSON.setFloat("ry", c.rot.y);
    cubeJSON.setFloat("rz", c.rot.z);
    
    cubeJSON.setFloat("w", c.w);

    cubesList.setJSONObject(i, cubeJSON);
  }
  json.setJSONArray("cubes", cubesList);
  saveJSONObject(json, "data/cubes/cubes.json");
}

public void loadCubes() {
  cubes = new ArrayList<Cube>();
  processing.data.JSONObject cubesJson;
  cubesJson = loadJSONObject("data/cubes/cubes.json");
  int numCubes = cubesJson.getInt("numCubes");
  println(numCubes);

  processing.data.JSONArray cubesArray = cubesJson.getJSONArray("cubes");
  for (int i = 0; i < numCubes; i++) {
    processing.data.JSONObject c = cubesArray.getJSONObject(i);
    float x = c.getFloat("x");
    float y = c.getFloat("y");
    float z = c.getFloat("z");
    
    float rx = c.getFloat("rz");
    float ry = c.getFloat("ry");
    float rz = c.getFloat("rz");
    
    float w = c.getFloat("w");
    
    cubes.add(new Cube(new PVector(x, y, z), new PVector(rx, ry, rz), w, color(255)));
  }
}

class Cube {

  PVector loc;
  float w;
  PVector rot;
  int c;

  Cube(PVector loc, PVector rot, float w, int c) {
    this.loc = loc;
    this.rot = rot;
    this.w = w;
    this.c = c;
  }

  public boolean mouseOver() {
    return (mouseX > loc.x && mouseX < loc.x + w && mouseY > loc.y && mouseY < loc.y + w);
  }

  public void move() {
    loc.set(mouseX, mouseY, 0);
  }
  
  public void moveZ() {
    float rate = 1;
    float dz = (pmouseY-mouseY) * rate;
    loc.add(0, 0, dz);
    println(loc.z);
  }

  //void display(PImage tex) {
  public void display() {
    if (mouseOver()) fill(255, 0, 0);
    else fill(c);
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    scale(w);
    beginShape(QUADS);
    //texture(tex);

    // Given one texture and six faces, we can easily set up the uv coordinates
    // such that four of the faces tile "perfectly" along either u or v, but the other
    // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
    // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
    // rotation along the X axis will put the "top" of either texture at the "top"
    // of the screen, but is not otherwised aligned with the X/Z faces. (This
    // just affects what type of symmetry is required if you need seamless
    // tiling all the way around the cube)

    // +Z "front" face
    vertex(-1, -1, 1, 0, 0);
    vertex( 1, -1, 1, 1, 0);
    vertex( 1, 1, 1, 1, 1);
    vertex(-1, 1, 1, 0, 1);

    // -Z "back" face
    vertex( 1, -1, -1, 0, 0);
    vertex(-1, -1, -1, 1, 0);
    vertex(-1, 1, -1, 1, 1);
    vertex( 1, 1, -1, 0, 1);

    // +Y "bottom" face
    vertex(-1, 1, 1, 0, 0);
    vertex( 1, 1, 1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex(-1, 1, -1, 0, 1);

    // -Y "top" face
    vertex(-1, -1, -1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, -1, 1, 1, 1);
    vertex(-1, -1, 1, 0, 1);

    // +X "right" face
    vertex( 1, -1, 1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex( 1, 1, 1, 0, 1);

    // -X "left" face
    vertex(-1, -1, -1, 0, 0);
    vertex(-1, -1, 1, 1, 0);
    vertex(-1, 1, 1, 1, 1);
    vertex(-1, 1, -1, 0, 1);

    endShape();

    popMatrix();
  }

  public void rotateCX() {
    float rate = 0.01f;
    float rotx = (pmouseY-mouseY) * rate;
    //float roty = (mouseX-pmouseX) * rate;
    rot.add(rotx, 0, 0);
  }
  public void rotateCY() {
    float rate = 0.01f;
    float roty = (mouseX-pmouseX) * rate;
    rot.add(0, roty, 0);
  }
  public void rotateCZ() {
    float rate = 0.01f;
    float rotz = (mouseX-pmouseX) * rate;
    rot.add(0, 0, rotz);
  }
  public void changeScale() {
    float rate = 1;
    float dw = (mouseX-pmouseX) * rate;
    w += dw;
  }
}
//////////////////////////////////////////////////////////////////////////////////
// STRIPES
//////////////////////////////////////////////////////////////////////////////////

float angleStriped = 0;
float[] stripedAngles;

public void initStripedSquares(int num) {
  stripedAngles = new float[num];
  for (int i = 0; i < num; i++) {
    stripedAngles[i] = random(2 * PI);
  }
}
public void displayStriped(int lineW) {
  for (int j = 0; j < stripedAngles.length; j++) { 
    pushMatrix();
    translate(width/2, height/2);
    rotateZ(stripedAngles[j]);
    stripedAngles[j] += .01f;

    fill(0);
    noStroke();
    rect(0, 0, width, width);
    fill(255);
    for (int i = 0; i < width; i+= lineW) {
      rect(0, 0 + i, width, lineW);
      i += lineW;
    }
    popMatrix();
  }
}


//////////////////////////////////////////////////////////////////////////////////
// CENTER TRIANGLE
//////////////////////////////////////////////////////////////////////////////////
public void triangleCenter(int c, int sw, int sz) {
  strokeWeight(sw);
  stroke(c);
  noFill();
  int x = (maskPoints[keystoneNum][2].x+maskPoints[keystoneNum][7].x)/2; 
  int y = (maskPoints[keystoneNum][2].y+maskPoints[keystoneNum][7].y)/2;
  float alt = sz*sqrt(3)/2.0f;
  triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2);
}


//////////////////////////////////////////////////////////////////////////////////
// HAROM
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/434617
// Gábor Damásdi
public void haromCenter(int c, int sw, int sz) {
  strokeWeight(sw);
  stroke(c);
  noFill();
  harom(centerX+sz/2, centerY+sz/2, centerX-sz/2, centerY+sz/2, 6, (sin(0.0005f*millis()%(2*PI))+1)/2);
}

float t=0.001f;
public void harom(float ax, float ay, float bx, float by, int level, float ratio) {
  if (level!=0) {
    float vx, vy, nx, ny, cx, cy;
    vx=bx-ax;
    vy=by-ay;
    nx=cos(PI/3)*vx-sin(PI/3)*vy; 
    ny=sin(PI/3)*vx+cos(PI/3)*vy; 
    cx=ax+nx;
    cy=ay+ny;
    line(ax, ay, bx, by);
    line(ax, ay, cx, cy);
    line(cx, cy, bx, by);
    harom(ax*ratio+cx*(1-ratio), ay*ratio+cy*(1-ratio), ax*(1-ratio)+bx*ratio, ay*(1-ratio)+by*ratio, level-1, ratio);
  }
}

public void haromAll(int c, int sw) {
  float ax = screenW-30;
  float bx = 30;
  float ay = screenH-50;
  float by = ay;
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.strokeWeight(sw);
    s.s.stroke(255);
    haromScreen(s, ax, ay, bx, by, 6, (sin(0.0005f*millis()%(2*PI))+1)/2);
    s.s.endDraw();
  }
}

public void haromScreen(Screen s, float ax, float ay, float bx, float by, int level, float ratio) {
  if (level!=0) {
    float vx, vy, nx, ny, cx, cy;
    vx=bx-ax;
    vy=by-ay;
    nx=cos(PI/3)*vx-sin(PI/3)*vy; 
    ny=sin(PI/3)*vx+cos(PI/3)*vy; 
    cx=ax+nx;
    cy=ay+ny;
    s.s.line(ax, ay, bx, by);
    s.s.line(ax, ay, cx, cy);
    s.s.line(cx, cy, bx, by);
    haromScreen(s, ax*ratio+cx*(1-ratio), ay*ratio+cy*(1-ratio), ax*(1-ratio)+bx*ratio, ay*(1-ratio)+by*ratio, level-1, ratio);
  }
}

public void triangleCenterScreen(int c, int sw, int sz) {
  screens[1].drawTriangle(c, sw, screenW, screenH/2, sz);
  screens[2].drawTriangle(c, sw, 0, screenH/2, sz);
}


//////////////////////////////////////////////////////////////////////////////////
// NETWORK CIRCLE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/434620
// Koï Koï
ArrayList<Star> constellation;
int n;
float dd;

public void initCurvyNetwork() {
  n = 50;
  constellation = new ArrayList<Star>();
  for (int i = 0; i <= n; i++) {
    constellation.add(new Star());
  }
  strokeWeight(.75f);
  stroke(255);
}

public void drawCurvyNetwork(PGraphics s) {
  s.background(0);
  for (int i = 0; i < constellation.size(); i++) {
    constellation.get(i).update();
    for (int j = 0; j < constellation.size(); j++) {
      if (i > j) { // "if (i > j)" => to check one time distance between two stars
        dd = constellation.get(i).loc.dist(constellation.get(j).loc); // Distance between two stars
        if (dd <= width / 10) { // if d is less than width/10 px, we draw a line between the two stars
          s.line(constellation.get(i).loc.x, constellation.get(i).loc.y, constellation.get(j).loc.x, constellation.get(j).loc.y);
        }
      }
    }
  }
}

class Star {
  float a, r, m;
  PVector loc, speed, bam;
  Star() {

    this.a = random(5 * TAU); // "5*TAU" => render will be more homogeneous
    this.r = random(screenW * .2f, screenW * .25f); // first position will looks like a donut
    this.loc = new PVector(screenW / 2 + sin(this.a) * this.r, screenH / 2 + cos(this.a) * this.r);
    this.speed = new PVector();
    this.speed = PVector.random2D();
    this.bam = new PVector();
    this.m = 0;
  }


  public void update() {
    bam =  PVector.random2D();// movement of star will be a bit erractic
    //this.bam.random2D();
    bam.mult(0.45f);
    speed.add(bam);
    // speed is done according distance between loc and the mouse :
    m = constrain(map(dist(this.loc.x, this.loc.y, mouseX, mouseY), 0, screenW, 8, .05f), .05f, 3); // constrain => avoid returning "not a number"
    speed.normalize().mult(this.m);

    // No colision detection, instead loc is out of bound
    // it reappears on the opposite side :
    if (dist(loc.x, this.loc.y, screenW / 2, screenH / 2) > (screenW / 2) * 0.98f) {
      if (loc.x < screenW / 2) {
        loc.x = screenW - loc.x - 4; // "-4" => avoid blinking stuff
      } else if (loc.x > screenW / 2) {
        loc.x = screenW - loc.x + 4; // "+4"  => avoid blinking stuff
      }
      if (loc.y < screenH / 2) {
        loc.y = screenW - loc.y - 4;
      } else if (loc.x > screenH / 2) {
        loc.y = screenW - loc.y + 4;
      }
    }
    loc = loc.add(speed);
  } // End of update()
} // End of class


//////////////////////////////////////////////////////////////////////////////////
// NERVOUS WAVES 2
//////////////////////////////////////////////////////////////////////////////////
// Levente Sandor, 2014
// https://www.openprocessing.org/sketch/153224
public void displayNervous() {
  noiseDetail(2, 0.9f);
  rectMode(CENTER);
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.fill(255);
    s.s.noStroke();

    for (int x = 10; x < screenW; x += 10) {
      for (int y = 10; y < screenH; y += 10) {
        float n = noise(x * 0.005f, y * 0.005f, frameCount * 0.05f);
        s.s.pushMatrix();
        s.s.translate(x, y);
        s.s.rotate(TWO_PI * n);
        s.s.scale(10 * n);
        s.s.rect(0, 0, 1, 1);
        s.s.popMatrix();
      }
    }
    s.s.endDraw();
  }
  rectMode(CORNER);
}


//////////////////////////////////////////////////////////////////////////////////
// CIRCLE PULSE
//////////////////////////////////////////////////////////////////////////////////
/**
 * @author aa_debdeb
 * https://www.openprocessing.org/sketch/385808
 */

public void initLACircle() {
  size(640, 640);
  noFill();
  strokeWeight(2);
}

public void displayLACircle() {
  background(238, 243, 239);
  translate(width / 2, height / 2);
  float radius = 200;
  float step = 5;
  for (float y = -radius + step / 2; y <= radius - step / 2; y += step) {
    float X = sqrt(sq(radius) - sq(y)); 
    float cRate = map(y, -radius + step / 2, radius + step / 2, 0, 1);
    stroke(lerpColor(color(69, 189, 207), color(234, 84, 93), cRate));
    beginShape();
    for (float x = -X; x <= X; x += 1) {
      vertex(x, y);
    }
    endShape();
  }
}



//////////////////////////////////////////////////////////////////////////////////
// WAVY CIRCLE
//////////////////////////////////////////////////////////////////////////////////
//https://www.openprocessing.org/sketch/399221
int c1 = 0xff191970;
int c2 = 0xffECF0F1;
int count = 19;
float r = 120;
float d = 8.25f;
int MAX = 330;

public void initWavyCircle() {
}

public void displayWavyCircle() {
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.smooth();
    //s.s.background(c1);
    s.s.ellipseMode(RADIUS);
    s.s.noStroke();

    s.s.fill(c1, 100);
    s.s.rect(0, 0, screenW, screenH);
    s.s.fill(c2, 100);

    s.s.pushMatrix();
    s.s.translate(screenW/ 2, screenH / 2);
    for (int n = 1; n < count; n++) {
      for (float a = 0; a <= 360; a += 1) {
        float progress = constrain(map(frameCount%MAX, 0+n*d, MAX+(n-count)*d, 0, 1), 0, 1);
        float ease = -0.5f*(cos(progress * PI) - 1);
        float phase = 0 + 2*PI*ease + PI + radians(map(frameCount%MAX, 0, MAX, 0, 360));
        float x = map(a, 0, 360, -r, r);
        float y = r * sqrt(1 - pow(x/r, 2)) * sin(radians(a) + phase);
        s.s.ellipse(x, y, 1.5f, 1.5f);
      }
    }
    s.s.popMatrix();
  }
}



//////////////////////////////////////////////////////////////////////////////////
// TESSERACT
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/205544
Tesseract tesseract;

public void initTesseract() {
  tesseract = new Tesseract();
}

public void displayTesseract() {
  updateSpectrum();
  beatCycle(300);
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.stroke(255);
    s.s.strokeWeight(2);
    s.s.pushMatrix();
    s.s.translate(screenW/2, screenH/2);

    tesseract.display(s);
    s.s.popMatrix();

    if (currentCycle%6 == 0) tesseract.turn(0, 1, .01f);
    else if (currentCycle%6 == 1) tesseract.turn(0, 2, .01f);
    else if (currentCycle%6 == 2) tesseract.turn(1, 2, .01f);
    else if (currentCycle%6 == 3) tesseract.turn(0, 3, .01f);
    else if (currentCycle%6 == 4) tesseract.turn(1, 3, .01f);
    else if (currentCycle%6 == 5) tesseract.turn(2, 3, .01f);
    s.s.endDraw();
  }
}
class Tesseract {
  float[][][] lines;
  float x, y, z, w, perspZ, perspW, size;

  Tesseract() {
    size=screenW/14;
    z=5;
    w=1;
    perspZ=4;
    perspW=1;

    float[][][] temp={
      {{1, 1, 1, 1}, {-1, 1, 1, 1}}, 
      {{1, 1, 1, 1}, { 1, -1, 1, 1}}, 
      {{1, 1, 1, 1}, { 1, 1, -1, 1}}, 
      {{1, 1, 1, 1}, { 1, 1, 1, -1}}, 

      {{-1, -1, 1, 1}, { 1, -1, 1, 1}}, 
      {{-1, -1, 1, 1}, {-1, 1, 1, 1}}, 
      {{-1, -1, 1, 1}, {-1, -1, -1, 1}}, 
      {{-1, -1, 1, 1}, {-1, -1, 1, -1}}, 

      {{-1, 1, -1, 1}, { 1, 1, -1, 1}}, 
      {{-1, 1, -1, 1}, {-1, -1, -1, 1}}, 
      {{-1, 1, -1, 1}, {-1, 1, 1, 1}}, 
      {{-1, 1, -1, 1}, {-1, 1, -1, -1}}, 

      {{-1, 1, 1, -1}, { 1, 1, 1, -1}}, 
      {{-1, 1, 1, -1}, {-1, -1, 1, -1}}, 
      {{-1, 1, 1, -1}, {-1, 1, -1, -1}}, 
      {{-1, 1, 1, -1}, {-1, 1, 1, 1}}, 

      {{1, -1, -1, 1}, {-1, -1, -1, 1}}, 
      {{1, -1, -1, 1}, { 1, 1, -1, 1}}, 
      {{1, -1, -1, 1}, { 1, -1, 1, 1}}, 
      {{1, -1, -1, 1}, { 1, -1, -1, -1}}, 

      {{1, -1, 1, -1}, {-1, -1, 1, -1}}, 
      {{1, -1, 1, -1}, { 1, 1, 1, -1}}, 
      {{1, -1, 1, -1}, { 1, -1, -1, -1}}, 
      {{1, -1, 1, -1}, { 1, -1, 1, 1}}, 

      {{1, 1, -1, -1}, {-1, 1, -1, -1}}, 
      {{1, 1, -1, -1}, { 1, -1, -1, -1}}, 
      {{1, 1, -1, -1}, { 1, 1, 1, -1}}, 
      {{1, 1, -1, -1}, { 1, 1, -1, 1}}, 

      {{-1, -1, -1, -1}, { 1, -1, -1, -1}}, 
      {{-1, -1, -1, -1}, {-1, 1, -1, -1}}, 
      {{-1, -1, -1, -1}, {-1, -1, 1, -1}}, 
      {{-1, -1, -1, -1}, {-1, -1, -1, 1}}};

    lines=temp;
  }

  public void turn(int a, int b, float deg) {
    float[] temp;
    for (int j=0; j<2; j++)
      for (int i=0; i<32; i++) {
        temp=lines[i][j];
        lines[i][j][a]=temp[a]*cos(deg)+temp[b]*sin(deg);
        lines[i][j][b]=temp[b]*cos(deg)-temp[a]*sin(deg);
      }
  }

  public void persp(float[][][] arr) {
    for (int j=0; j<2; j++)
      for (int i=0; i<32; i++) {
        arr[i][j][0]=arr[i][j][0]+(arr[i][j][0]+x)*((arr[i][j][2]+z)/perspZ+(arr[i][j][3]+w)/perspW);
        arr[i][j][1]=arr[i][j][1]+(arr[i][j][1]+y)*((arr[i][j][2]+z)/perspZ+(arr[i][j][3]+w)/perspW);
      }
  }

  public void resize(float[][][] arr) {
    for (int i=0; i<32; i++)
      for (int j=0; j<2; j++)
        for (int k=0; k<4; k++)
          arr[i][j][k]*=size;
  }

  public void display(Screen s) {
    float[][][] temp = new float[32][2][4];
    for (int i=0; i<32; i++)
      for (int j=0; j<2; j++)
        for (int k=0; k<4; k++)
          temp[i][j][k]=lines[i][j][k];
    persp(temp);
    resize(temp);
    for (int i=0; i<32; i++)
      s.s.line(temp[i][0][0], temp[i][0][1], temp[i][1][0], temp[i][1][1]);
  }
}


//////////////////////////////////////////////////////////////////////////////////
// PARTICLES
//////////////////////////////////////////////////////////////////////////////////
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/17163*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
class particle {
  PVector x;
  PVector v;
  PVector f;
  particle() {
    x = new PVector(random(0, screenW*4), random(0, screenH));
    v = new PVector();
    f = new PVector();
  }
  public void update() {
    v.add(f);
    f = new PVector(0, 0.02f);
    x.add(v);
  }
}
ArrayList particles;
float diam = 10;
float suck = 1.2f;
float k = 0.1f;
float c = 0.01f;
public void initParticles() {
  particles = new ArrayList();
  for (int i=0; i<300; i++) {
    particles.add(new particle());
  }
}
public void updateParticles() {
  for (int i=1; i<particles.size(); i++) {
    particle A = (particle) particles.get(i);
    for (int j=0; j<i; j++) {
      particle B = (particle) particles.get(j);
      PVector dx = PVector.sub(B.x, A.x);
      if (abs(dx.x)<diam*suck) {
        if (abs(dx.y)<diam*suck) {
          if (dx.mag()<diam*suck) {
            float restore = (diam - dx.mag())*k;
            dx.normalize();
            float dampen = dx.dot(PVector.sub(B.v, A.v))*c;
            dx.mult(restore - dampen);
            A.f.sub(dx);
            B.f.add(dx);
          }
        }
      }
    }
  }
  for (int i=0; i<particles.size(); i++) {
    particle A = (particle) particles.get(i);
    PVector mouseV = new PVector(mouseX, mouseY);
    PVector pmouseV = new PVector(pmouseX, pmouseY);
    if (mousePressed) {
      PVector dx = PVector.sub(A.x, mouseV);
      float pushrad = 8;
      if (abs(dx.x)<pushrad) {
        if (abs(dx.y)<pushrad) {
          if (dx.mag()<pushrad) {
            //            dx.normalize();
            //            A.f.add(PVector.mult(dx,0.8));
            A.v.add(PVector.mult(PVector.sub(
              PVector.sub(mouseV, pmouseV), A.v), 0.2f));
          }
        }
      }
    }
    boolean dampen = false;
    if (A.x.x<0) {
      A.f.x -= A.x.x*k;
      dampen = true;
    };
    if (A.x.x>width) {
      A.f.x -= (A.x.x-width)*k;
      dampen = true;
    };
    if (A.x.y<0) {
      A.f.y -= A.x.y*k;
      dampen = true;
    };
    if (A.x.y>height) {
      A.f.y -= (A.x.y-height)*k;
      dampen = true;
    };
    if (dampen) {
      A.v.mult(0.9f);
    }
    A.update();
  }
}
public void displayParticles() {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    for (int i=0; i<particles.size(); i++) {
      particle A = (particle) particles.get(i);
      if (A.x.x > j * screenW && A.x.x <= (j+1) * screenW) {
        screens[j].s.fill(255);
        screens[j].s.ellipse(A.x.x, A.x.y, diam, diam);
      }
    }
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// RAINBOW
//////////////////////////////////////////////////////////////////////////////////
public void displayRainbow() {
  int j = 0;
  for (Screen s : screens) {
    s.s.beginDraw();
    s.s.colorMode(HSB, 255);
    s.s.background((frameCount+50*j)%255, 255, 255);
    s.s.endDraw();
    j++;
  }
}
public void displayShadowRainbow() {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.colorMode(HSB, 255);
    if (j%2 == 0) screens[j].s.background(frameCount%255, 200, 255, 255);
    else screens[j].s.background(frameCount%255, 200, 255, 100);
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// SHADOW LINES
//////////////////////////////////////////////////////////////////////////////////
public void displayShadowLines(int hue, int sz, int sp) {
  for (int j = 0; j < screens.length; j++) {
    screens[j].s.beginDraw();
    screens[j].s.colorMode(HSB, 255);

    screens[j].s.noStroke();
    int ynum = screenH/(sz+sp);
    int ysp = (screenH - ynum * (sz+sp))/2;
    for (int k = 0; k < 5; k++) {
      for (int i = 0; i < screenH/(sz+sp); i++) {
        if (j%2 == 0) screens[j].s.fill(hue, 255, 255, 150 + k * 20);
        else screens[j].s.fill((hue-10)%255, 255, 105, 150 + k * 20);
        if (j%2==0) screens[j].s.rect(ysp, ysp+i * (sz+sp), screenW-ysp*2-5*k, sz-5*k);
        else screens[j].s.rect(ysp+i * (sz+sp), ysp, sz-5*k, screenW-ysp*2-5*k);
      }
    }
    screens[j].s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// FROZEN BRUSH
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////
// PERLIN NOISE
//////////////////////////////////////////////////////////////////////////////////
int spacingTerr, colsTerr, rowsTerr;
float[][] terrain;
float flyingTerr = 0;
float flyingTerrInc = 0.01f;
boolean flyingTerrOn = true;
float xoffInc = 0.2f;
boolean acceleratingTerr = true;
int lastCheckedTerr = 0;
boolean beginningTerrain = false;
boolean addAudioAmp = true;

public void initTerrainCenter() {
  int w = screenW*4; 
  int h = 800; 
  int spacing = 20;
  this.colsTerr = w/spacing;
  this.rowsTerr = h/spacing;
  this.spacingTerr = spacing;
  terrain = new float[colsTerr][rowsTerr];
}
public void setAudioGrid() {
  updateSpectrum();

  beatCycle(300);
  if (currentCycle > previousCycle) {
    acceleratingTerr = true;
    previousCycle = currentCycle;
  }
  updateFlying(800);

  float yoff = flyingTerr;

  for (int y = 0; y < rowsTerr; y++) {
    float xoff = 0;
    float amp = 0.5f;
    for (int x = 0; x < colsTerr; x++) {
      float f = getFreq(map(x, 0, colsTerr, 0, 100));


      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      //terrain[x][y] += f*amp;
      //terrain[x][y] += map(y,0,rowsTerr,-f*amp,f*amp);
      xoff += xoffInc;
    }
    yoff += xoffInc;
  }
}

public void updateFlying(int delayT) {
  if (flyingTerrOn) {
    if (acceleratingTerr) {
      flyingTerr -= 0.3f;
      if (millis() - lastCheckedTerr > delayT) {
        acceleratingTerr = false;
      }
    } else {
      flyingTerr -= flyingTerrInc;
    }
  }
}

public void displayTerrainSplit() {
  setAudioGrid();
  int j = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.pushMatrix();

    // 0  +screenW*2
    // 1  +screenW
    // 2 -screenW
    // 3 -2*screenW

    s.translate((2-j) * screenW, screenH/2, 0);
    s.rotateX(radians(60));


    s.noFill();
    s.stroke(255);
    s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
    s.colorMode(HSB, 255);
    for (int y = 0; y < rowsTerr-1; y++) {
      s.beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < colsTerr; x++) {
        //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
        s.vertex(x * spacingTerr, y * spacingTerr, addAudioAmp?terrain[x][y]:0);
        s.vertex(x * spacingTerr, (y+1) * spacingTerr, addAudioAmp?terrain[x][y+1]:0);
      }
      s.endShape();
    }
    s.popMatrix();
    s.endDraw();
    j++;
  }
}


public void displayTerrainCenter() {
  PGraphics s = centerScreen.s;
  //setGrid();
  setAudioGrid();
  s.beginDraw();
  s.background(0);
  s.pushMatrix();
  if (beginningTerrain) {
    s.translate(screenW*2, screenH/2, 0);
    s.rotateX(radians(millis()/100.0f));
  } else {
    s.translate(screenW*2, screenH/2, 0);
    s.rotateX(radians(60));
  }

  s.noFill();
  s.stroke(255);
  s.translate(-colsTerr*spacingTerr/2, -rowsTerr*spacingTerr/2);
  s.colorMode(HSB, 255);
  for (int y = 0; y < rowsTerr-1; y++) {
    s.beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < colsTerr; x++) {
      //s.fill(map(terrain[x][y], -100, 100, 0, 255), 255, 255);  // rainbow
      s.vertex(x * spacingTerr, y * spacingTerr, addAudioAmp?terrain[x][y]:0);
      s.vertex(x * spacingTerr, (y+1) * spacingTerr, addAudioAmp?terrain[x][y+1]:0);
    }
    s.endShape();
  }
  s.popMatrix();
  s.endDraw();
}

// return frequency from 0 to 100 at x (band) between 0 and 100
public float getFreq(float col) {
  int x = constrain((int)col, 0, 100);
  x = (int)(x * (bands.length/100.0f));
  return constrain(bands[x], 0, 100);
}

//////////////////////////////////////////////////////////////////////////////////
// NOISE STRIP
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/203961
/*
author:  lisper <leyapin@gmail.com> 2015
 desc:    noise led strip
 This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
 */
float nx = 0;
float ny = 0;
float nz = 0;
float nxcolor;
float nycolor;
float nzcolor;

public void drawStream () {

  int ind = 0;
  for (Screen sc : screens) {
    //nx = 0;
    //nxcolor = 0;
    nx = 0.02f * screenW/20 * ind;
    nxcolor= 0.1f * screenW/20 * ind;
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.colorMode(HSB);
    s.stroke (255);
    s.strokeWeight(3);
    for (int i=0; i<= screenW; i += 20) {
      ny = 0;
      nycolor=0;
      for (int j=50; j<= screenW; j += 100) {
        float n = noise (nx, ny, nz);
        float angle = map (n, 0, 1.0f, 0, 6*PI);
        float x = 50 * cos (angle);
        float y = 40 * sin (angle);
        //int c = constrain( int (map( noise (nxcolor, nycolor, nzcolor), 0, 1.0, -200, 400)), 0, 255);
        int c = PApplet.parseInt (map( noise (nxcolor, nycolor, nzcolor), 0, 1.0f, 0, 255));
        //println (c);
        //s.stroke (c*2);
        s.stroke (c);
        s.line (i-x, j-y, i+x, j+y);
        ny += 0.5f;
        nycolor += 0.3f;
      }
      nxcolor += 0.1f;
      nx += 0.02f;
    }
    s.endDraw();
    ind++;
    nz +=0.001f;
    nzcolor += 0.001f;
  }
}

//////////////////////////////////////////////////////////////////////////////////
// TREE BRANCHES
//////////////////////////////////////////////////////////////////////////////////
//https://www.openprocessing.org/sketch/144159
class pathfinder {
  PVector location;
  PVector velocity;
  float diameter;
  pathfinder(PGraphics s) {
    location = new PVector(s.width/2, s.height);
    velocity = new PVector(0, -1);
    diameter = 32;
  }
  pathfinder(pathfinder parent) {
    location = parent.location.copy();
    velocity = parent.velocity.copy();
    float area = PI*sq(parent.diameter/2);
    float newDiam = sqrt(area/2/PI)*2;
    diameter = newDiam;
    parent.diameter = newDiam;
  }
  public void update() {
    if (diameter>0.5f) {
      location.add(velocity);
      PVector bump = new PVector(random(-1, 1), random(-1, 1));
      bump.mult(0.1f);
      velocity.add(bump);
      velocity.normalize();
      if (random(0, 1)<0.02f) {
        paths = (pathfinder[]) append(paths, new pathfinder(this));
      }
    } else if (location.x < -400) resetTreeBranchesAll();
  }
}
pathfinder[] paths;
public void initTreeBranchesAll() {
  smooth();
  paths = new pathfinder[1];
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    paths[0] = new pathfinder(s);
    s.beginDraw();
    s.background(0);
    s.endDraw();
  }
}
public void displayTreeBranchesAll() {
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.ellipseMode(CENTER);
    s.fill(255);
    s.noStroke();
    for (int i=0; i<paths.length; i++) {
      PVector loc = paths[i].location;
      float diam = paths[i].diameter;
      s.ellipse(loc.x, loc.y, diam, diam);
      paths[i].update();
    }
    s.endDraw();
  }
}
public void resetTreeBranchesAll() {
  PGraphics s = screens[0].s;
  paths = new pathfinder[1];
  paths[0] = new pathfinder(s);
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.background(0);
    sc.s.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////
// TREE BRANCHES
//////////////////////////////////////////////////////////////////////////////////
float thetaFTree; 
public void displayFractalTreeAll(int mode) {
  int j = 0;
  for (Screen sc : screens) {
    PGraphics s = sc.s;
    s.beginDraw();
    s.background(0);
    s.stroke(255);
    s.strokeWeight(2);
    s.pushMatrix();
    // Let's pick an angle 0 to 90 degrees based on the mouse position
    float a = (mouseX / (float) s.width) * 90f;
    if (mode == 1) a = 40*sin(frameCount/100.0f + j * 0.35f); // (mouseX / (float) s.width) * 90f 
    // Convert it to radians
    thetaFTree = radians(a);
    // Start the tree from the bottom of the screen
    s.translate(s.width/2, s.height);
    // Draw a line 120 pixels
    s.line(0, 0, 0, -120);
    // Move to the end of that line
    s.translate(0, -120);
    // Start the recursive branching!
    //s.scale(3);
    branch(s, 120);
    s.popMatrix();
    s.endDraw();
    j++;
  }
}

public void branch(PGraphics s, float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66f;

  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    s.pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    s.rotate(thetaFTree);   // Rotate by theta
    s.line(0, 0, 0, -h);  // Draw the branch
    s.translate(0, -h); // Move to the end of the branch
    branch(s, h);       // Ok, now call myself to draw two new branches!!
    s.popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    s.pushMatrix();
    s.rotate(-thetaFTree);
    s.line(0, 0, 0, -h);
    s.translate(0, -h);
    branch(s, h);
    s.popMatrix();
  }
}


//////////////////////////////////////////////////////////////////////////////////
// WAVES
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/546665
public void displayWavesCenter() {
  cycleWaves();
  PGraphics s = centerScreen.s;
  s.beginDraw();
  s.background(0);  
  for (int i = 0; i < waves.size(); i++) {
    Wave w = waves.get(i);
    if (w != null) {
      w.tick();
      w.display(s);
    }
  }
  s.endDraw();
}
ArrayList<Wave> waves;
public void initWaves() {
  waves = new ArrayList();
}

class Wave {
  PVector pos, dim;

  Wave(int x, int y) {
    pos = new PVector(x, y);
    dim = new PVector(0, 0);
  }

  public void display(PGraphics s) {
    s.stroke(255);
    s.strokeWeight(5);
    s.noFill();
    s.ellipse(pos.x, pos.y, dim.x, dim.y);
  }

  public void tick() {
    dim.add(new PVector(3, 3));
    if (dim.x > width*2) {
      waves.remove(this);
    }
  }
}

public void cycleWaves() {
  updateSpectrum();
  beatCycle(500);
  if (currentCycle > previousCycle) {
    waves.add(new Wave(centerScreen.s.width/2, centerScreen.s.height/2));
    previousCycle = currentCycle;
  }
}


//////////////////////////////////////////////////////////////////////////////////
// LINES BOUNCE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/449873
// modified by jdeboi
float angleBottom = 0;

public void displayLineBounceAll() {
  for (Screen s : screens) {
    displayLineBounce(s.s, 30);
  }
  angleBottom += 0.01f;
}
public void displayLineBounce(PGraphics s, int spacing) {
  s.beginDraw();
  s.background(0);
  s.stroke(255);
  int w = s.width;
  int h = s.height ;
  int centerX = w/2;
  //int bottomY = h-50;
  int bottomY = h;
  int centerY = bottomY/2;
  for (int i = 0; i<w; i+=spacing) {
    // 0 -> 1, not 0 -> 2h
    float yMove = bottomY/2-sin(angleBottom)*bottomY/2;
    s.line(centerX, bottomY, i, yMove); // bottom lines
    yMove = bottomY/2+sin(angleBottom)*bottomY/2;
    s.line(centerX, 0, i, yMove);         // top lines
  }
  for (int i = 0; i<=bottomY; i+=spacing) {

    float xMove = centerX/2 + sin(angleBottom)*centerX/2;
    s.line(0, i, xMove, centerY);        // left to right lines

    xMove = w-sin(angleBottom)*w/4 - w/4;
    // between w and w/2
    s.line(xMove, centerY, w, i);
  }
  s.endDraw();
}



//////////////////////////////////////////////////////////////////////////////////
// MOVING THROUGH SPACE
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/96938
ArrayList<PVector> starsSpace = new ArrayList<PVector>();
int convergeX = 1;
int convergeY = 1;

public void displayMoveSpaceAll() {
  cycleStarsSpaceModes();
  for (Screen s : screens) {
    displayMoveSpace(s.s, 0.8f);
  }
}

public void displayMoveSpaceCenter() {
  cycleStarsSpaceModes();
  displayMoveSpace(centerScreen.s, 1.0f);
}

public void displayMoveSpace(PGraphics s, float speed) {
  //int controlX = mouseX;
  //int controlY = mouseY;
  speed = constrain(speed, 0.6f, 1.0f);
  int controlX = PApplet.parseInt(map(convergeX, 0, 2, s.width*(1-speed), s.width*speed));
  int controlY = PApplet.parseInt(map(convergeY, 0, 2, s.height*(1-speed), s.height*speed));
  float w2=s.width/2;
  float h2= s.height/2;
  float d2 = dist(0, 0, w2, h2);
  s.beginDraw();
  s.noStroke();
  s.fill(0, map(dist(controlX, controlY, w2, h2), 0, d2, 255, 5));
  s.rect(0, 0, s.width, s.height);
  s.fill(255);

  for (int i = 0; i<20; i++) {   // star init
    starsSpace.add(new PVector(random(s.width), random(s.height), random(1, 3)));
  }

  for (int i = 0; i<starsSpace.size(); i++) {
    float x =starsSpace.get(i).x;//local vars
    float y =starsSpace.get(i).y;
    float d =starsSpace.get(i).z;

    /* movement+"glitter"*/
    starsSpace.set(i, new PVector(x-map(controlX, 0, s.width, -0.05f, 0.05f)*(w2-x), y-map(controlY, 0, s.height, -0.05f, 0.05f)*(h2-y), d+0.2f-0.6f*noise(x, y, frameCount)));

    if (d>3||d<-3) starsSpace.set(i, new PVector(x, y, 3));
    if (x<0||x>s.width||y<0||y>s.height) starsSpace.remove(i);
    if (starsSpace.size()>999) starsSpace.remove(1);
    s.ellipse(x, y, d, d);//draw stars
  }
  s.endDraw();
}

public void cycleStarsSpaceModes() {
  updateSpectrum();
  beatCycle(500);
  if (currentCycle > previousCycle) {
    convergeX = (currentCycle/3)%3;
    convergeY = currentCycle%3;

    previousCycle = currentCycle;
  }
}

//////////////////////////////////////////////////////////////////////////////////
// RED PLANET
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/422775
ArrayList<PVector> pathPoints = new ArrayList<PVector> ();
public void displayRedPlanetAll() {
  for (Screen s : screens) {
    displayRedPlanet(s.s);
  }
}
public void displayRedPlanet(PGraphics s) {
  s.beginDraw();
  //create the path
  pathPoints = circlePoints(s);

  for (int j=0; j<8; j++) {
    pathPoints = complexifyPath(pathPoints);
  }

  //draw the path
  s.stroke(random(100, 255), 20, 15, random(10, 55));
  //filter(BLUR,0.571) ;
  for (int i=0; i<pathPoints.size() -1; i++) {
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i+1);
    s.line(v1.x, v1.y, v2.x, v2.y);
  }
  s.endDraw();
}

public ArrayList<PVector>   complexifyPath(ArrayList<PVector> pathPoints) {
  //create a new path array from the old one by adding new points inbetween the old points
  ArrayList<PVector> newPath = new ArrayList<PVector>();

  for (int i=0; i<pathPoints.size() -1; i++) {
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i+1);
    PVector midPoint = PVector.add(v1, v2).mult(0.5f);
    float distance =  v1.dist(v2);

    //the new point is halfway between the old points, with some gaussian variation
    float standardDeviation = 0.125f*distance;
    PVector v = new PVector((randomGaussian()-0.5f)*standardDeviation+midPoint.x, (randomGaussian()-0.5f)*standardDeviation+midPoint.y);
    newPath.add(v1);
    newPath.add(v);
  }

  //don't forget the last point!
  newPath.add(pathPoints.get(pathPoints.size()-1));
  return newPath;
}

public ArrayList<PVector> circlePoints(PGraphics s) {
  //two points somewhere on a circle
  float r = s.height/2;
  int x = s.width/2;
  int y = s.height/2;
  //float theta1 = random(TWO_PI);
  float theta1 = (randomGaussian()-0.5f)*PI/4;
  float theta2 = theta1 + (randomGaussian()-0.5f)*PI/3;
  PVector v1 = new PVector(x + r*cos(theta1), y+ r*sin(theta1)*.7f );
  PVector v2 = new PVector(x + r*cos(theta2), y + r*sin(theta2)*.7f);
  ArrayList<PVector> vecs = new ArrayList<PVector>();
  vecs.add(v1);
  vecs.add(v2);
  return vecs;
}


//////////////////////////////////////////////////////////////////////////////////
// MOONS
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/219297
int moonColor = 0xffffe699;
float moonRadius = 40;
int moonFrames = 250;
int moonCell = 108;
float moonDelay = 0;
int moonColumns = 12;
int moonRows = 1;

//Draws the rows and columns of moons.
//Adds a delay for each moon.
public void displayMoonsAcross() {
  for (int k = 0; k < screens.length; k++) {
    PGraphics s = screens[k].s;
    s.beginDraw();
    s.background(0);
    s.noStroke(); 

    for (int j = 0; j < moonRows; j++) {
      for (int i = 0; i < moonColumns/4; i++) {
        float x = i*moonCell;
        //float y = j*moonCell;
        float y = 100;
        s.pushMatrix();
        s.translate(x, y);
        drawMoon(s, moonDelay);
        moonDelay = moonDelay+0.025f;
        s.popMatrix();
      }
    }

    s.endDraw();
  }
  moonDelay = 0;
}

//Draws a moon. 
//This function is a modifiend version of "the moon" by Jerome Herr.
public void drawMoon(PGraphics s, float delay) {
  float t = (((frameCount)%moonFrames*1.5f)/(float)moonFrames)+delay;
  if (t > 1.5f) t -= 1.5f;
  s.translate(moonCell, moonCell);
  //Moon growing to full moon
  if (t < 0.5f) { 
    float tt = map(t, 0, 0.5f, 0, 1); 
    if (tt < 0.5f) { 
      float r = map(tt, 0, 0.5f, moonRadius, 0);
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5f); //left moon
      s.fill(0);
      s.arc(0, 0, r, moonRadius, PI/2, PI*1.5f); //left background shrinking
    } else {
      float r = map(tt, 0.5f, 1, 0, moonRadius);
      s.fill(moonColor);
      s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right moon growing
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5f); //left moon
    }
    //Moon shrinking to new moon
  } else if (t < 1.0f) {
    float tt = map(t, 0.5f, 1, 0, 1);
    if (tt < 0.5f) {
      float r = map(tt, 0, 0.5f, moonRadius, 0); 
      s.fill(0);
      s.arc(0, 0, moonRadius, moonRadius, PI/2, PI*1.5f); //left background
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      s.arc(0, 0, r, moonRadius, PI/2, PI*1.5f); //left moon shrinking
    } else {
      float r = map(tt, 0.5f, 1, 0, moonRadius); 
      s.fill(moonColor);
      s.arc(0, 0, moonRadius, moonRadius, -PI/2, PI/2); //right moon
      s.fill(0);
      s.arc(0, 0, r, moonRadius, -PI/2, PI/2); //right background growing
    }
  } else if (t < 1.5f) {
    s.fill(0);
  }
}

//////////////////////////////////////////////////////////////////////////////////
// FLOWY WAVES
//////////////////////////////////////////////////////////////////////////////////
// https://www.openprocessing.org/sketch/133048
float myPerlin;
float cFW=0;
float dFW=0;
float eFW=0;
//float x=0;
float yFW=0;
float randPerl;
float countFW=150;
float  mapHeightFW;
int modeFW = 0;
int startCFW;
int midCFW;
int endCFW;

public void initDisplayFlowyWaves(PGraphics s) {
  mapHeightFW = screenH;
  s.beginDraw();
  s.background(255);

  colorMode(HSB);
  startCFW = color(random(255), 255, 255);
  midCFW = color((hue(startCFW)+60)%255, 255, 255);
  endCFW = color((hue(startCFW)+120)%255, 255, 255);
  colorMode(RGB);
  s.endDraw();
}

public void displayFlowyWaves(PGraphics s) {
  s.beginDraw();
  int fadeStart = 1150;
  int fadeEnd = 1200;
  if (countFW > fadeStart) {
    s.noStroke();
    int c = getColorFW(0, modeFW);
    s.fill(hue(c), saturation(c), brightness(c), map(countFW, fadeStart, fadeEnd, 2, 50));
    s.rect(0, 0, s.width, s.height);
  }
  s.noFill();
  changeColor(s, countFW);
  changePerlin();
  paintFW(s);
  countFW++;

  if (countFW > fadeEnd) {
    //s.background(255);
    countFW = 100;
    mapHeightFW = screenH;
  }
  mapHeightFW=mapHeightFW-1;
  s.endDraw();
}

public void changeColor(PGraphics s, float cnt) {
  s.colorMode(HSB);
  s.stroke(getColorFW(cnt, modeFW));
}

public int getColorFW(float cnt, int mode) {
  if (mode == 0) {
    cFW = sin(radians(cnt))+1;
    dFW = sin(radians(cnt+30))+1;
    eFW = sin(radians(cnt+60))+1;
    cFW = map(cFW, 0, 1, 0, 255);
    dFW = map(dFW, 0, 1, 0, 255);
    eFW = map(eFW, 0, 1, 0, 255);
    return color(cFW, dFW, 220);
  } else if (mode == 1) {
    cFW = sin(radians(cnt))+1;
    return color(cFW);
  } else {
    cFW = sin(radians(cnt))+1;
    dFW = sin(radians(cnt+30))+1;
    eFW = sin(radians(cnt+60))+1;
    cFW = map(cFW, 0, 1, 0, 255);
    dFW = map(dFW, 0, 1, 0, 255);
    eFW = map(eFW, 0, 1, 0, 255);

    float s = sin(radians(cnt));
    int c;
    if (s < -0.5f) c = lerpColor(startCFW, midCFW, map(s, -1, -0.5f, 0, 1));
    else if (s < 0.5f) c = lerpColor(midCFW, endCFW, map(s, -0.5f, 0.5f, 0, 1));
    else  c = lerpColor(endCFW, startCFW, map(s, 0.5f, 1, 0, 1));
    return c;
  }
}

public void paintFW(PGraphics s) {
  for (int x=0; x<s.width; x=x+1) {
    myPerlin = noise(PApplet.parseFloat(x)/200, countFW/200);
    float myY = map(myPerlin, 0, 1, 0, s.height-mapHeightFW);
    s.line(x, myY, x, s.height );
  }
}

public void changePerlin() {
  myPerlin = noise(countFW);
}
  public void settings() {  fullScreen(P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OneEyedJacks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

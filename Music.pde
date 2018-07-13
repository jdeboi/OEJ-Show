import ddf.minim.*;
//import ddf.minim.analysis.*;


boolean backingTracks = true;
int cueDelay = 0;
//int cueDelay = 2300;

Minim minim;
AudioPlayer songFile;
//Song songFile;
//BeatDetect beat;
//BeatListener bl;
int currentCycle = 0;
int lastCheckedShape = 0;
int previousCycle = 0;

PImage[] constellations;
PImage[] hands;
PImage[] theremin;
PImage[] symbols;

//FFT         myAudioFFT;

//int         myAudioRange     = 256;
//int         myNumBands       = 11;
//int         myAudioMax       = 100;
//int[]       bandBreaks       = {20, 50, 60, 80, 100, 150, 175, 200, 225, 255};
//int[]       bands            = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
//float       myAudioAmp       = 170.0;
//float       myAudioIndex     = 0.2;
//float       myAudioIndexAmp  = myAudioIndex;
//float       myAudioIndexStep = 0.55;

//float       myAudioAmp2       = 250.0;
//float       myAudioIndex2     = 2.0;
//float       myAudioIndexAmp2  = 0.8;
//float       myAudioIndexStep2 = 2;


//class BeatListener implements AudioListener
//{
//  private BeatDetect beat;
//  private AudioPlayer source;

//  BeatListener(BeatDetect beat, AudioPlayer source) {
//    this.source = source;
//    this.source.addListener(this);
//    this.beat = beat;
//  }

//  void samples(float[] samps) {
//    beat.detect(source.mix);
//  }

//  void samples(float[] sampsL, float[] sampsR) {
//    beat.detect(source.mix);
//  }
//}

void initMusic() {
  minim = new Minim(this);
  if (!backingTracks) songFile = minim.loadFile("music/fullsong/intro.mp3");
  else songFile = minim.loadFile("music/backing/intro.mp3");
}

//void initFFT() {
  //minim = new Minim(this);
  //songFile = minim.loadFile("music/moon.mp3", 1024);
  //myAudioFFT = new FFT(songFile.bufferSize(), songFile.sampleRate());
  //myAudioFFT.linAverages(myAudioRange);
  //myAudioFFT.window(FFT.GAUSS);
//}

//void initBeat() {
//  beat = new BeatDetect(songFile.bufferSize(), songFile.sampleRate());
//  beat.setSensitivity(200);  
//  bl = new BeatListener(beat, songFile);
//}

//void drawFFTBarsCubes() {
//  for (int i = 0; i < numScreens; i++) {
//    screens[i].drawFFTBars();
//  }
//}

//void drawFFTBarsTop() {
//  for (int i = 0; i < 2; i++) {
//    topScreens[i].drawFFTBars();
//  }
//}

//void drawSpectrumCubes() {
//  //updateSpectrum();
//  for (Screen s : screens) {
//    drawSpectrum(s, screenW);
//  }
//}

//void drawSpectrum(Screen s, int w) {
//  s.s.beginDraw();
//  s.s.colorMode(HSB, bands.length);
//  for (int i = 0; i < bands.length; i++) {
//    s.s.fill(i, bands.length, bands.length);
//    s.s.noStroke();
//    s.s.rect(i*w, 40, w, bands[i]);
//  }
//  s.s.colorMode(RGB, 255);
//  s.s.endDraw();
//}

int getMoveOnBeats(float[] beats, int totalBeats) {
  int i = 0;
  int index = -1;
  float percentComplete = percentToNumBeats(totalBeats);
  float beatsPast = 0;
  while (i < beats.length) {
    if (beats[i] < 0) {
      beatsPast += abs(beats[i]);
    } else {
      beatsPast += beats[i];
      index++;
    }
    if (beatsPast/totalBeats >= percentComplete) {
      return index;
    }
    i++;
  }
  return index;
}



void cycleShapeFFTTop(color c) {
  for (Screen sc : topScreens) {
    cycleShapeFFT(sc.s, c);
  }
}

void cycleShapeFFTCubes(color c) {
  //updateSpectrum();
  //beatCycle(300);
  for (Screen sc : screens) {
    cycleShapeFFT(sc.s, c);
  }
}

void cycleShapeFFT(PGraphics s, color c) {
  s.beginDraw();
  s.background(0);
  s.stroke(c);
  s.noFill();
  s.strokeWeight(3);
  s.rectMode(CENTER);
  float ellSize = s.width * .5;
  float rectSize = s.width * .5;
  float triSize = s.width * .5;
  float lineSize = s.width * .5;
  if (currentCycle%4 == 0) s.ellipse(s.width/2, s.height/2, ellSize, ellSize);
  else if (currentCycle%4 == 1) s.rect(s.width/2, s.height/2, rectSize, rectSize);
  else if (currentCycle%4 == 2) {
    int x = s.width/2;
    int y = s.height/2;
    float alt = triSize*sqrt(3)/2.0;
    s.triangle(x-triSize/2, y + alt/2, x, y - alt/2, x+triSize/2, y + alt/2);
  } else s.line(s.width/2, s.height/2 - lineSize/2, s.width/2, s.height/2 + lineSize/2);
  s.rectMode(CORNERS);
  s.endDraw();
}


void initConst() {
  constellations = new PImage[5];
  constellations[0] = loadImage("images/constellations/0.jpg");
  constellations[1] = loadImage("images/constellations/1.jpg");
  constellations[2] = loadImage("images/constellations/2.jpg");
  constellations[3] = loadImage("images/constellations/3.jpg");
  constellations[4] = loadImage("images/constellations/4.jpg");
}
void initSymbols() {
  symbols = new PImage[6];
  for (int i = 0; i < 6; i++) {
    symbols[i] = loadImage("images/symbols/" + i + ".jpg");
  }
}
void cycleConstFFT() {
  //updateSpectrum();
  //beatCycle(300);
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
void initHands() {
  int numHands = 5;
  hands = new PImage[numHands];
  for (int i = 0; i < numHands; i++) {
    hands[i] = loadImage("images/hand/hand" + i + ".jpg");
  }
}

void initTheremin() {
  int numHands = 8;
  theremin = new PImage[numHands];
  for (int i = 0; i < numHands; i++) {
    theremin[i] = loadImage("images/theremin/" + i + ".jpg");
  }
}
void cycleHandsFFT() {
  int j = 0;
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.background(0);
    sc.s.blendMode(SCREEN);
    sc.s.noFill();
    sc.s.strokeWeight(3);
    sc.s.rectMode(CENTER);

    int imgW = 400;
    
    // 4 forward
    // 2 back
    // repeat
    int num = (currentCycle + j)% 6;
    if (num > 4) num = 8 - num;
    PImage p = hands[num];
    int imgH = int(p.height *  imgW*1.0/p.width);
    sc.drawImage(p, screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //if (currentCycle%hands.length == j) sc.drawImage(hands[0], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //else  sc.drawImage(hands[4], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
    j++;
  }
}


void beatTile() {
  //updateSpectrum();
  //beatCycle(300);
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

//void drawTriangleSpectrum() {
//  int numBands = 10;
//  float rectW = screenW / numBands/2;
//  float rectH = screenH / numBands/2;

//  int j = 0;
//  for (Screen sc : screens) {
//    PGraphics s = sc.s;
//    s.beginDraw();
//    for (int i = 0; i < numBands; ++i) {
//      if ( beat.isOnset(i) ) {
//        s.stroke(255);
//        s.strokeWeight(3);
//        if (j==0 ) {
//          s.line( i*rectW, screenH, screenW*2, screenH-i*rectH);
//          s.line( i*rectW, 0, screenW*2, i*rectH);
//        } else if (j==1) {
//          s.line( i*rectW - screenW, screenH, screenW, screenH-i*rectH);
//          s.line( i*rectW - screenW, 0, screenW, i*rectH);
//        } else if (j==2) {
//          s.line( 0, screenH-i*rectH, i*rectW + screenW, screenH);
//          s.line( 0, i*rectH, i*rectW + screenW, 0);
//        } else {
//          s.line( -screenW, screenH-i*rectH, i*rectW, screenH);
//          s.line( -screenW, i*rectH, i*rectW, 0);
//        }
//      }
//    }
//    s.endDraw();
//    j++;
//  }
//}

void drawWaveForm() {
  for (Screen sc : screens) {
    sc.s.beginDraw();
    sc.s.stroke(255);
    sc.s.strokeWeight(5);
    int j = 0;
    for (int i = 0; i < screenW; i++) {
      //sc.s.line(i, screenH/2-50  + songFile.left.get(i + j * screenW)*50, (i+1), screenH/2-50  + songFile.left.get(i+1 + j * screenW)*50);
      //sc.s.line(i, screenH/2+50 + songFile.right.get(i + j * screenW)*50, (i+1), screenH/2+50 + songFile.right.get(i+1 + j * screenW)*50);
    }
    j++;
    sc.s.endDraw();
  }
}

//void drawSpectrumMirror() {
//  int numBands = 20;
//  int w = int(screenW * 2.0 / numBands);
//  int j = 0;

//  float temp = 0;
//  Screen s1 = screens[1];
//  Screen s2 = screens[2];

//  float t = myAudioIndexAmp2;
//  s1.s.beginDraw();
//  for (int i = 0; i <= numBands/2; i++) {
//    myAudioIndexAmp2 += myAudioIndexStep2;
//    temp = myAudioFFT.getAvg(i + numBands/2 * j);
//    temp *= myAudioIndexAmp2;

//    s1.s.fill(255);
//    s1.s.noStroke();
//    s1.s.rect(screenW-i*w, screenH, w, -temp );
//  }
//  s1.s.endDraw();

//  s2.s.beginDraw();
//  myAudioIndexAmp2 = t;
//  for (int i = 0; i <= numBands/2; i++) {
//    myAudioIndexAmp2 += myAudioIndexStep2;
//    temp = myAudioFFT.getAvg(i + numBands/2 * j);
//    temp *= myAudioIndexAmp2;

//    s2.s.fill(255);
//    s2.s.noStroke();
//    s2.s.rect(i*w, screenH, w, -temp );
//  }
//  s2.s.endDraw();


//  j++;

//  s1 = screens[0];
//  s2 = screens[3];

//  s1.s.beginDraw();
//  t = myAudioIndexAmp2;
//  for (int i = 0; i < numBands/2; i++) {
//    myAudioIndexAmp2 += myAudioIndexStep2;
//    temp = myAudioFFT.getAvg(i + numBands/2 * j);
//    temp *= myAudioIndexAmp2;

//    s1.s.fill(255);
//    s1.s.noStroke();
//    s1.s.rect(screenW-i*w, screenH, w, -temp );
//  }
//  myAudioIndexAmp2 = t;
//  s1.s.endDraw();
//  s2.s.beginDraw();
//  for (int i = 0; i < numBands/2; i++) {
//    myAudioIndexAmp2 += myAudioIndexStep2;
//    temp = myAudioFFT.getAvg(i + numBands/2 * j);
//    temp *= myAudioIndexAmp2;
//    s2.s.fill(255);
//    s2.s.noStroke();
//    s2.s.rect(i*w, screenH, w, -temp );
//  }
//  s2.s.endDraw();
//  myAudioIndexAmp = myAudioIndex;
//  myAudioIndexAmp2 = myAudioIndex2;
//}
//void drawSpectrumAcross() {
//  int numBands = 80;
//  int w = int(screenW * 4.0 / numBands);
//  int j = 0;
//  for (Screen s : screens) {
//    float temp = 0;
//    s.s.beginDraw();
//    for (int i = 0; i < numBands/4; i++) {
//      myAudioIndexAmp2 += myAudioIndexStep2;
//      temp = myAudioFFT.getAvg(i + numBands/4 * j);
//      temp *= myAudioIndexAmp2;
//      s.s.fill(255);
//      s.s.noStroke();
//      s.s.rect(i*w, screenH, w, -temp );
//    }
//    s.s.endDraw();
//    j++;
//  }
//  myAudioIndexAmp = myAudioIndex;
//  myAudioIndexAmp2 = myAudioIndex2;
//}

//void updateSpectrum() {
//  myAudioFFT.forward(songFile.mix);

//  int bandIndex = 0;
//  while (bandIndex < bandBreaks.length) {
//    float temp = 0;
//    int startB = 0; 
//    int endB = 0;
//    if (bandIndex == 0) {
//      startB = -1;
//      endB = bandBreaks[bandIndex];
//    } else if (bandIndex < bandBreaks.length) {
//      startB = bandBreaks[bandIndex-1];
//      endB = bandBreaks[bandIndex];
//    }
//    for (int j = startB+1; j <= endB; j++) {
//      myAudioIndexAmp2 += myAudioIndexStep2;
//      temp += myAudioFFT.getAvg(j);
//    }
//    temp /= endB - startB;
//    temp *= myAudioAmp*myAudioIndexAmp;
//    myAudioIndexAmp+=myAudioIndexStep;
//    bands[bandIndex] = int(temp);
//    bandIndex++;
//  }
//  myAudioIndexAmp = myAudioIndex;
//  myAudioIndexAmp2 = myAudioIndex2;
//}

void displayAmplitudeHoriz() {
  //int lev = int(map((songFile.left.level() + songFile.right.level())/2, 0, 0.5, 0, screenW*4));
  int lev = 1;
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

//void drawFFT() {
//  // draw a green rectangle for every detect band
//  // that had an onset this frame
//  float rectW = width / beat.detectSize();
//  for (int i = 0; i < beat.detectSize(); ++i)
//  {
//    // test one frequency band for an onset
//    if ( beat.isOnset(i) )
//    {
//      fill(0, 200, 0);
//      rect( i*rectW, 0, rectW, height);
//    }
//  }

//  // draw an orange rectangle over the bands in 
//  // the range we are querying
//  int lowBand = 5;
//  int highBand = 15;
//  // at least this many bands must have an onset 
//  // for isRange to return true
//  int numberOfOnsetsThreshold = 4;
//  if ( beat.isRange(lowBand, highBand, numberOfOnsetsThreshold) )
//  {
//    fill(232, 179, 2, 200);
//    rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, height);
//  }

//  //if ( beat.isKick() ) kickSize = 32;
//  //if ( beat.isSnare() ) snareSize = 32;
//  //if ( beat.isHat() ) hatSize = 32;
//}

float percentToNumBeats(int numBeats) {
  return percentToNumBeats(0, numBeats);
}
float percentToNumBeats(float startT, int numBeats) {
  float timePassed = songFile.position()/1000.0 - startT;
  float bps = currentScene.tempo / 60.0;
  float spb = 1.0 / bps;
  int cyclesSinceStartT = floor(timePassed / spb);
  int currentGroup = (cyclesSinceStartT) / numBeats;
  if (cyclesSinceStartT == 0) currentGroup = 0;
  float timePerGroup = numBeats * spb;
  float timeFromLastGroup = timePassed - (currentGroup * timePerGroup);
  float perGroup = map(timeFromLastGroup, 0, timePerGroup, 0, 1);
  //println(currentGroup, timeFromLastGroup, timePassed, perGroup);
  return constrain(perGroup, 0, 1);
}

void setCurrentCycleCueClick() {
  float timePassedMinutes = (songFile.position()/1000.0/60); 
  currentCycle = int(timePassedMinutes/currentScene.tempo);
}

float percentToNextMeasure(float startT) {
  return percentToNumBeats(startT, currentScene.signature);
}

float percentToNextBeat(float startT) {
  return percentToNumBeats(startT, 1);
}


void checkBeatReady(float startT) {
  float timePassed = songFile.position()/1000.0 - startT;
  float bps = currentScene.tempo / 60.0;
  float spb = 1.0 / bps;

  if (currentCycle == 0) {
    if (timePassed > spb)
      currentCycle++;
  } else if (timePassed > currentCycle * spb) {
    currentCycle++;
  }
}


class Song {
  int duration, position;
  long startTime;
  boolean isPaused = true;
  ArrayList left, right;

  Song (int duration, float tempo) {
    left = new ArrayList<Integer>();
    right = new ArrayList<Integer>();
    this.duration = duration;
  }

  int length() {
    return duration;
  }

  void update() {
    if (!isPaused) {
      position += millis() - startTime;
      startTime = millis();
      if (position > duration) position = duration;
    }
  }

  void pause() {
    update();
    isPaused = true;
  }

  void play() {
    isPaused = false;
    startTime = millis();
  }

  float position() {
    return position;
  }

  void cue(int p) {
    if (p >= 0 && p < duration) {
      position = p;
      startTime = millis();
    }
  }

  void skip(int mil) {
    position += mil;
  }

  int bufferSize () {
    return 100;
  }
}


boolean af_ON = false;
int selected = -1;
boolean editingBreaks = false;

//import java.util.*;
//import java.util.LinkedList;
//import java.util.List;

int currentBreak = 0;

int xSpace = 50;
int vW = 600;
int vH = 40;
int ySpace = 150;
int infoX = 400;
int infoY = 150;

void drawPlayer() {
  stroke(255);
  strokeWeight(2);
  noFill();
  //if (editingBreaks) fill(255);
  rect(xSpace, ySpace, vW, vH);
  float position = map( songFile.position(), 0, songFile.length(), xSpace, xSpace+vW );
  stroke(255);
  line( position, ySpace, position, ySpace+vH );

  //for (int i = 0; i < breaks.size(); i++) {
  //  breaks.get(i).display();
  //}
  stroke(255);
  strokeWeight(1);
  textSize(12);
  timeText.setText((nf(songFile.position()/1000.0, 3, 2)));
  //text(nf(songFile.position()/1000.0, 3,2), xSpace, ySpace + vH);

  strokeWeight(1);
  displayCues();
}

void drawSongLabel() {
  textSize(20);
  fill(255);
  text(currentScene.order + ". " + currentScene.song, xSpace, ySpace - 10);
}

void mousePlayer() {
  int x = xSpace;
  int y = ySpace;
  int w = vW;
  int h = vH;
  if (mouseY > y && mouseY < y + h && mouseX > x && mouseX < x + w) {
    int position = int( map( mouseX, x, x+w, 0, songFile.length() ) );
    songFile.cue( position );
    setCurrentCue();
    setCurrentCycleCueClick();
    println("current cue: " + currentCue);
    if (currentCue != -1) cues[currentCue].initCue();
  } else {
    selected = -1;
  }
}


void drawLines() {
  for (int i = 0; i < songFile.bufferSize() - 1; i++) {
    //line(i, 50  + songFile.left.get(i)*50, i+1, 50  + songFile.left.get(i+1)*50);
    //line(i, 150 + songFile.right.get(i)*50, i+1, 150 + songFile.right.get(i+1)*50);
  }
}

int getClickTrackLen() {
  float bpm = currentScene.tempo;
  float mpb = 1/bpm;
  int mspb = int(mpb * 60 * 1000);
  int mspbars = mspb * currentScene.signature * currentScene.numClickBars;
  return mspbars;
}

float getBarLenSeconds() {
  float bpm = currentScene.tempo;
  float mpb = 1/bpm;
  int mspb = int(mpb * 60 * 1000);
  int mspbars = mspb * currentScene.signature;
  return mspbars/1000.0;
}

float getClickTrackLenSeconds() {
  return getClickTrackLen()/1000.0;
}

void checkClickTrack() {
  if (clickTrackStarted) {
    if (backingTracks) {
      songFile.cue(getClickTrackLen());
      songFile.pause();
    }
    fill(0, 255, 0);
    rect(width-5, height-5, 5, 5);
    if (millis() - midiStartTime > (getClickTrackLen() - cueDelay)) {
      playScene();
      clickTrackStarted = false;
    }
  }
}

void printMeasureBeatsCurrentScene() {
  println("--------------------");
  println(currentScene.song, ": Bar Times");
  float bar = getBarLenSeconds();
  for (float i = 0; i < songFile.length()/1000.0; i+= bar) {
    println(i);
  }
}

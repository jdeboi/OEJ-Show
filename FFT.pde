import ddf.minim.*;
import ddf.minim.analysis.*;

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
float       myAudioAmp       = 170.0;
float       myAudioIndex     = 0.2;
float       myAudioIndexAmp  = myAudioIndex;
float       myAudioIndexStep = 0.55;

float       myAudioAmp2       = 250.0;
float       myAudioIndex2     = 2.0;
float       myAudioIndexAmp2  = 0.8;
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

  void samples(float[] samps) {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR) {
    beat.detect(source.mix);
  }
}

void initFFT() {
  minim = new Minim(this);
  songFile = minim.loadFile("music/moon.mp3", 1024);


  myAudioFFT = new FFT(songFile.bufferSize(), songFile.sampleRate());
  myAudioFFT.linAverages(myAudioRange);
  //myAudioFFT.window(FFT.GAUSS);
}

void initBeat() {
  beat = new BeatDetect(songFile.bufferSize(), songFile.sampleRate());
  beat.setSensitivity(200);  
  bl = new BeatListener(beat, songFile);
}

void drawSpectrum(int w) {
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
void beatCycle(int delayT) {
  if (bands[3] > 225 && millis() - lastCheckedShape > delayT) {
    lastCheckedShape = millis();
    currentCycle++;
  }
}
void cycleShapeFFT() {
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
      float alt = sz*sqrt(3)/2.0;
      sc.s.triangle(x-sz/2, y + alt/2, x, y - alt/2, x+sz/2, y + alt/2);
    } else sc.s.line(screenW/2, screenH/2 - screenW/8, screenW/2, screenH/2 + screenW/8);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
  }
}

PImage[] constellations;
PImage[] hands;
void initConst() {
  constellations = new PImage[5];
  constellations[0] = loadImage("images/constellations/0.png");
  constellations[1] = loadImage("images/constellations/1.png");
  constellations[2] = loadImage("images/constellations/2.png");
  constellations[3] = loadImage("images/constellations/3.png");
  constellations[4] = loadImage("images/constellations/4.png");
}
void cycleConstFFT() {
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
void initHands() {
  hands = new PImage[5];
  hands[0] = loadImage("images/hand/hand0.jpg");
  hands[1] = loadImage("images/hand/hand1.jpg");
  hands[2] = loadImage("images/hand/hand2.jpg");
  hands[3] = loadImage("images/hand/hand3.jpg");
  hands[4] = loadImage("images/hand/hand4.jpg");
}
void cycleHandsFFT() {
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
    int imgH = int(hands[(currentCycle+j)%hands.length].height *  imgW*1.0/hands[(currentCycle+j)%hands.length].width);
    sc.drawImage(hands[(currentCycle+j)%hands.length], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //if (currentCycle%hands.length == j) sc.drawImage(hands[0], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    //else  sc.drawImage(hands[4], screenW/2 -imgW/2, screenH/2 - imgH/2, imgW, imgH);
    sc.s.rectMode(CORNERS);
    sc.s.endDraw();
    j++;
  }
}


void beatTile() {
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

void drawTriangleSpectrum() {
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

void drawWaveForm() {
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

void drawSpectrumMirror() {
  int numBands = 20;
  int w = int(screenW * 2.0 / numBands);
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
void drawSpectrumAcross() {
  int numBands = 80;
  int w = int(screenW * 4.0 / numBands);
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

void updateSpectrum() {
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
    bands[bandIndex] = int(temp);
    bandIndex++;
  }
  myAudioIndexAmp = myAudioIndex;
  myAudioIndexAmp2 = myAudioIndex2;
}

void displayAmplitudeHoriz() {
  int lev = int(map((songFile.left.level() + songFile.right.level())/2, 0, 0.5, 0, screenW*4));

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

void drawFFT() {
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

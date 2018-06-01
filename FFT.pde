import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer songFile;
BeatDetect beat;
BeatListener bl;

float kickSize, snareSize, hatSize;

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
  kickSize = snareSize = hatSize = 16;
}

void initBeat() {
  beat = new BeatDetect(songFile.bufferSize(), songFile.sampleRate());
  beat.setSensitivity(200);  
  bl = new BeatListener(beat, songFile);
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

  if ( beat.isKick() ) kickSize = 32;
  if ( beat.isSnare() ) snareSize = 32;
  if ( beat.isHat() ) hatSize = 32;

  fill(255);

  textSize(kickSize);
  text("KICK", width/4, height/2);

  textSize(snareSize);
  text("SNARE", width/2, height/2);

  textSize(hatSize);
  text("HAT", 3*width/4, height/2);

  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);
}

void drawPlayer(int x, int y, int w, int h) {
  stroke(255);
  noFill();
  rect(x, y, w, h);
  float position = map( songFile.position(), 0, songFile.length(), x, x+w );
  stroke(255, 0, 0);
  line( position, y, position, y+h );
}

void mousePlayer(int x, int y, int w, int h) {
  if (mouseY > y && mouseY < y + h && mouseX > x && mouseX < x + w) {
    int position = int( map( mouseX, x, x+w, 0, songFile.length() ) );
    songFile.cue( position );
  }
}

void drawLines() {
  for (int i = 0; i < songFile.bufferSize() - 1; i++) {
    line(i, 50  + songFile.left.get(i)*50, i+1, 50  + songFile.left.get(i+1)*50);
    line(i, 150 + songFile.right.get(i)*50, i+1, 150 + songFile.right.get(i+1)*50);
  }
}
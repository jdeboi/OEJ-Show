import processing.video.*;
Movie vid1;
Movie vid2;
boolean vidIsPlaying = false;
boolean vid1IsPlaying = false;

void initVid(String path1) {
  vid1 = new Movie(this, path1);
  vid2 = null;
  vid1IsPlaying = true;
  vidIsPlaying = true;
  pauseVids();
}

void initVid(String path1, String path2) {
  vid1 = new Movie(this, path1);
  vid2 = new Movie(this, path2);
  vid1IsPlaying = true;
  vidIsPlaying = true;
  pauseVids();
}

void playVids() {
  if (vid1IsPlaying && vid1 != null) {
    vid1.play();
    vid1.volume(0);
  } else if (vid2 != null) {
    vid2.play();
    vid2.volume(0);
  }
}

void stopVids() {
  pauseVids();
  vidIsPlaying = false;
}

void pauseVids() {
  if (vid1 != null) vid1.stop();
  if (vid2 != null) vid2.stop();
}

void mirrorVidCenter(Movie m, int x, int y) {
  screens[1].drawImage(m, x, y);
  screens[2].drawImageMirror(m, x, y);
}

void displayVid(Movie m, int screen, int x, int y) {
  screens[screen].drawImage(m, x, y);
}

void movieAcrossAll(Movie m, int y) {
  for (int i = 0; i < numScreens; i++) {
    screens[i].drawImage(m, -i*screenW, y, screenW*4, g.height*screenW*4/g.width);
  }
}


void tileVid(Movie m, int x, int y) {
  for (int i = 0; i < 4; i++) {
    screens[i].drawImage(m, x, y);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

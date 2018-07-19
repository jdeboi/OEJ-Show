import processing.video.*;
Movie vid1;
Movie vid2;
Movie sphereMovie;
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

void initSphereVid(String path) {
  sphereMovie = new Movie(this, path);
}

void displaySphereMovie(int x, int y, int w, int h) {
  if (sphereMovie != null) {
    sphereScreen.s.beginDraw();
    sphereScreen.s.image(sphereMovie, x, y, w, h);
    sphereScreen.s.endDraw();
  }
}



void displaySphereMovieCentered(float scale) {
  int w = int(sphereMovie.width*scale);
  int h = int(sphereMovie.height*scale);
  int x = sphereScreen.s.width/2 - w/2;
  int y = sphereScreen.s.height/2 - h/2;
  displaySphereMovie(x, y, w, h);
}

void clearVids() {
  vid1 = null;
  vid2 = null;
  sphereMovie = null;
}

void playVids() {
  if (vid1IsPlaying) {
    if (vid1 != null) {
      vid1.play();
      vid1.volume(0);
    } 
    if (vid2 != null) {
      vid2.play();
      vid2.volume(0);
    } 
    if (sphereMovie != null) {
      sphereMovie.loop();
      sphereMovie.volume(0);
    }
  }
}

void stopVids() {
  pauseVids();
  vidIsPlaying = false;
}

void pauseVids() {
  if (vid1 != null) vid1.stop();
  if (vid2 != null) vid2.stop();
  if (sphereMovie != null) sphereMovie.stop();
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




PGraphics maskGif;

void initMaskGif() {
  maskGif = createGraphics(currentGifs.get(1).width, currentGifs.get(1).height);
  int y = -50;
  maskGif.beginDraw();
  maskGif.background(255);
  maskGif.fill(0);
  maskGif.noStroke();
  int h = screenH - maskGif.height - y;
  maskGif.rect(0, maskGif.height - h, maskGif.width, h);
  maskGif.endDraw();
}

// y = 0 means the top will be at the top of the screen
// and topp will be riding on the bottom
void splitGifHorizontal(PGraphics s, Gif g, int y) {
  s.beginDraw();
  s.background(0);
  s.blendMode(BLEND);
  s.image(g, 0, y);
  s.fill(0);
  s.noStroke();
  s.rect(0, s.height/2, s.width, s.height);
  s.pushMatrix();
  s.scale(1, -1);
  s.blendMode(ADD);
  PImage p = g.copy();
  p.mask(maskGif);
  s.image(p, 0, -s.height + y); // -s.height);
  s.popMatrix();
  s.endDraw();
}

// this is with the bottom of the gif on the middle
void splitGifHorizontal(PGraphics s, Gif g) {
  s.beginDraw();
  s.background(0);
  s.image(g, 0, (s.height/2-g.height));
  s.pushMatrix();
  s.scale(1, -1);
  s.image(g, 0, -1*(g.height) -s.height/2);
  s.popMatrix();
  s.endDraw();
}

void centerVidCycles() {
  int x = (vid1.width - screenW*2)/2;
  screens[1].drawImage(vid1, -x, 0);
  screens[2].drawImage(vid1, -screenW-x, 0);

  screens[0].drawImage(currentGifs.get(1), 0, 0, screenW, screenH);
  screens[3].drawImage(currentGifs.get(1), 0, 0, screenW, screenH);
  //splitGifHorizontal(screens[0].s, currentGifs.get(1), -50);
  //splitGifHorizontal(screens[3].s, currentGifs.get(1));
}

//void centerVidCycles2() {
//  centerVidCycles();
//  screens[0].drawImage(vid2, 0, 0);
//  screens[3].drawImageMirror(vid2, 0, 0);
//}


void moodMovie() {
  //int x = (vid1.width - screenW*2)/2;
  screens[0].drawImage(vid1, 0, 0, screenW, screenH);
  screens[3].drawImageMirror(vid1, 0, 0, screenW, screenH);

  int y = -100;
  int h = int(screenH*1.0*screenW/currentGifs.get(0).width);
  screens[1].drawImage(currentGifs.get(0), 0 ,y , screenW, h);
  screens[2].drawImageMirror(currentGifs.get(0), 0, y, screenW, h);
}

void movieSong() {
  screens[0].drawImage(vid1, 0, 0, screenW, screenH);
  screens[3].drawImage(vid1, 0, 0, screenW, screenH);
  
  screens[1].drawImage(currentGifs.get(0), 0, 0, screenW, screenH);
  screens[2].drawImage(currentGifs.get(0), 0, 0, screenW, screenH);
  
  //int x = (vid1.width - screenW*2)/2;
  //screens[1].drawImage(vid1, -x, 0);
  //screens[2].drawImage(vid1, -screenW-x, 0);
  //splitGifHorizontal(screens[0].s, currentGifs.get(1), -50);
  //splitGifHorizontal(screens[3].s, currentGifs.get(1));
}

void movieCrush() {
  screens[0].drawImage(vid2, 0, 0);
  screens[3].drawImage(vid2, 0, 0);

  screens[1].drawImage(vid1, 0, 0);
  screens[2].drawImageMirror(vid1, 0, 0);
}

void maskGifSphere() {
  PGraphics s = sphereScreen.s;
  s.beginDraw();
  s.image(currentGifs.get(0), 0, 0, sphereW, sphereW);
  s.mask(tempSphere);
  s.endDraw();
}

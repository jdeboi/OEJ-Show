

void displayDelta() {
  drawSolidAll(color(255));
}

void displayRite() {
  drawSolidAll(color(255, 0, 0));
}

void displayMoon() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}

void displayLollies() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}

void displayCrush() {
  drawSolidAll(color(0));

  if (songFile.position() < 2000) drawFFTBarsAll();

  //else drawGifAcross(gifAcross, 0);
}

void displayCycles() {
  if (songFile.position() < 5000) mirrorVidCenter(vid1, -100, 0);
  else if (songFile.position() < 15000) {
    drawSolidAll(color(0));
    drawImageAll(images.get(0), 0, 0);
  }
  else {
    drawSolidAll(color(0));
    drawFFTBarsAll();
  }
}

void displayDirty() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayFifty() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayWiz() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayViolate() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayMood() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displaySong() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayEllon() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}
void displayEgrets() {
  drawSolidAll(color(0));
  drawFFTBarsAll();
}

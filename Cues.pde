
void setCurrentCue() {
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

void displayCrush() {
  setCurrentCue();
  switch(currentCue) {
  case 0:
    //drawSolidAll(color(0));

    movieAcrossAll(vid1, -350); 
    haromCenter(color(255), 3, 180);
    break;
  case 1: 
    drawSolidAll(color(0));
    haromAll(color(255), 3);
    //movieAcrossAll(vid1, -screenW/2);
    break;
  case 2:
    drawGifAll(currentGifs.get(currentGif), 0, 0, screenW, screenH);
    //disaplyNervous();
    //movieAcrossAll(vid1, -screenW/2);
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
    drawSolidAll(color(200, 0, 0));
    break;
  default:
    drawSolidAll(color(0));
    break;
  }
  //else drawGifAcross(gifAcross, 0);
}

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


void displayCycles() {
  if (songFile.position() < 5000) mirrorVidCenter(vid1, -100, 0);
  else if (songFile.position() < 15000) {
    drawSolidAll(color(0));
    drawImageAll(images.get(0), 0, 0);
  } else {
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

SpotLight[] spotLights;
boolean spotLightsOn = false;
int spotLightsTime = 0;
int spotLightMode = 0;

void initSpotLights() {
  spotLights = new SpotLight[3];
  int h = int(height*.75);
  spotLights[0] = new SpotLight(50, h, 50, h + 100, 50);
  spotLights[1] = new SpotLight(width/2, h, width/2, h+100, 50);
  spotLights[2] =  new SpotLight(width-50, h, width-50, h+100, 50);
}

void displaySpotLights() {
  int delayt = 2000;
  if (spotLightMode == 1) {
    if (millis() - spotLightsTime > delayt) {
      spotLightMode = 0;
    }
    fadeInSpotLights();
  }
  if (spotLightMode == 0) {
    for (int i = 0; i < 3; i++) {
      spotLights[i].display();
    }
  }
  else if (spotLightMode == -1) {
    if (millis() - spotLightsTime > delayt) {
      spotLightMode = 0;
    }
    fadeOutSpotLights();
  }
}

void fadeInSpotLights() {
  for (int i = 0; i < 3; i++) {
    spotLights[i].c = color(map(millis()-spotLightsTime, 0, 2000, 0, 255));
  }
}
void fadeOutSpotLights() {
  for (int i = 0; i < 3; i++) {
    spotLights[i].c = color(map(millis()-spotLightsTime, 0, 2000, 255, 0));
  }
}
class SpotLight {
  color c;
  int x1, x2;
  int y1, y2;
  int r;
  int mode;

  SpotLight(int x1, int y1, int x2, int y2, int r) {
    this.x1 = x1; 
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.r = r;
    c = color(255);
    mode = 0;
  }

  void display() {
    if (mode == 0) displayEllipse();
    else if (mode == 1) displayLine();
  }

  void displayLine() {
    strokeCap(ROUND);
    strokeWeight(30);
    noFill();
    stroke(c);
    for (int i = 4; i >= 0; i--) {
      strokeWeight(map(i, 4, 0, 30, 20));
      stroke(c, 20);
      line(x1, y1, x2, y2);
    }
  }

  void displayEllipse() {
    blendMode(BLEND);
    strokeCap(ROUND);
    strokeWeight(30);
    //noFill();
    //stroke(c);
    noStroke();
    pushMatrix();
    translate(0, 0, 3);
    for (int i = 14; i >= 0; i--) {
      //strokeWeight(map(i, 4, 0, 30, 20));
      //stroke(c, 20);
      //fill(map(i, 14, 0, 50, 85));
      fill(c, 5);
      float w = map(i, 14, 0, 100, 20);
      ellipse(x1, y1, w, 220);
    }
    popMatrix();
  }
}

void toggleSpotLights() {
  spotLightsTime = millis();
  if (!spotLightsOn) {
    spotLightMode = 1;
  } else {
    spotLightMode = -1;
  }
  spotLightsOn = !spotLightsOn;
}


MPoint [][] maskPoints;
boolean editingMask = false;
MPoint selectedP = null;
boolean showMask = true;

void initMask() {
  maskPoints = new MPoint[numMappings][10];
  loadMasks();
}


void saveMaskPoints() {
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

void loadMasks() {
  for (int i = 0; i < numMappings; i++) {
    loadMask(i);
  }
}

void loadMask(int index) {
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

void moveSelectedMask() {
  if (selectedP != null) {
    selectedP.move();
  }
}

void drawMaskPoints() {
  for (MPoint mp : maskPoints[keystoneNum]) {
    mp.display();
  }
}

void checkMaskClick() {
  if (selectedP == null) {
    for (MPoint mp : maskPoints[keystoneNum]) {
      if (mp.mouseOver()) {
        selectedP = mp;
        return;
      }
    }
  } else selectedP = null;
}


void maskScreens() {
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

  void display() {
    noFill();
    stroke(0, 255, 255);
    ellipse(x, y, 15, 15);
    fill(0, 255, 255);
    ellipse(x, y, 5, 5);
  }

  boolean mouseOver() {
    float d = dist(x, y, mouseX, mouseY);
    return d < 5;
  }

  void move() {
    x = mouseX;
    y = mouseY;
  }
}

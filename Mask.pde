
MPoint [] maskPoints;
boolean editingMask = false;
MPoint selectedP = null;

void initMask() {
  maskPoints = new MPoint[10];
  loadMask();
  centerX = (maskPoints[2].x+maskPoints[7].x)/2; 
  centerY = (maskPoints[2].y+maskPoints[7].y)/2;
}


void saveMaskPoints() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  processing.data.JSONArray maskList = new processing.data.JSONArray();      

  for (int i = 0; i < maskPoints.length; i++) {
    processing.data.JSONObject maskJSON = new processing.data.JSONObject();
    maskJSON.setInt("x", maskPoints[i].x);
    maskJSON.setInt("y", maskPoints[i].y);

    maskList.setJSONObject(i, maskJSON);
  }

  json.setJSONArray("maskList", maskList);
  saveJSONObject(json, "data/mask/maskPoints.json");
}


void loadMask() {
  processing.data.JSONObject maskJson;
  maskJson = loadJSONObject("data/mask/maskPoints.json");

  processing.data.JSONArray maskArray = maskJson.getJSONArray("maskList");
  for (int i = 0; i < 10; i++) {
    processing.data.JSONObject m = maskArray.getJSONObject(i);
    int x = m.getInt("x");
    int y = m.getInt("y");
    maskPoints[i] = new MPoint(x, y);
  }
}

void moveSelectedMask() {
  if (selectedP != null) {
    selectedP.move();
  }
}

void drawMaskPoints() {
  for (MPoint mp : maskPoints) {
    mp.display();
  }
}

void checkMaskClick() {
  if (selectedP == null) {
    for (MPoint mp : maskPoints) {
      if (mp.mouseOver()) {
        selectedP = mp;
        return;
      }
    }
  }
  else selectedP = null;
}


void maskScreens() {
  fill(50);
  noStroke();
  beginShape();
  vertex(0, maskPoints[0].y);
  for (MPoint mp : maskPoints) {
    vertex(mp.x, mp.y);
  }
  vertex(0, maskPoints[9].y);
  vertex(0, height);
  vertex(width, height);
  vertex(width, 0);
  vertex(0, 0);
  endShape();
  quad(0, maskPoints[0].y, maskPoints[0].x, maskPoints[0].y, maskPoints[9].x, maskPoints[9].y, 0, maskPoints[9].y);
}

class MPoint {
  int x, y;

  MPoint(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    noFill();
    stroke(150);
    ellipse(x, y, 10, 10);
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

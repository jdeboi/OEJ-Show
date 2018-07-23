
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
    for (int i = 0; i < 10; i++) {
      processing.data.JSONObject maskJSON = new processing.data.JSONObject();
      maskJSON.setInt("x", maskPoints[j][i].x);
      maskJSON.setInt("y", maskPoints[j][i].y);

      maskList.setJSONObject(i, maskJSON);
    }

    json.setJSONArray("maskList", maskList);
    if (useTestKeystone) saveJSONObject(json, "data/mask/testEnv/maskPoints_" + j + ".json");
    else saveJSONObject(json, "data/mask/maskPoints_" + j + ".json");
  }
}

void loadMasks() {
  for (int i = 0; i < numMappings; i++) {
    loadMask(i);
  }
}

void loadMask(int index) {
  processing.data.JSONObject maskJson;
  if (useTestKeystone) maskJson = loadJSONObject("data/mask/testEnv/maskPoints_"+ index + ".json");
  else maskJson = loadJSONObject("data/mask/maskPoints_"+ index + ".json");

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
  int j = 0;
  for (MPoint mp : maskPoints[keystoneNum]) {
    mp.display();
    stroke(255);
    noFill();
    textSize(30);
    text(j++, mp.x, mp.y);
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


void maskScreens(color c) {
  pushMatrix();
  translate(0, 0, -1);
  fill(c);
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
  popMatrix();
}

void snapMaskToOutline() {
  maskPoints[keystoneNum][0] = new MPoint(int(lines.get(0).p1.x)-5, int(lines.get(0).p1.y)-5); 
  maskPoints[keystoneNum][1] = new MPoint(int(lines.get(4).p1.x)-5, int(lines.get(4).p1.y)-5); 
  maskPoints[keystoneNum][2] = new MPoint(int(lines.get(8).p1.x)-5, int(lines.get(8).p1.y)-5); 
  maskPoints[keystoneNum][3] = new MPoint(int(lines.get(12).p1.x)-5, int(lines.get(12).p1.y)-5); 


  maskPoints[keystoneNum][4] = new MPoint(int(lines.get(12).p2.x)+5, int(lines.get(12).p2.y)-5); 
  maskPoints[keystoneNum][5] = new MPoint(int(lines.get(14).p1.x)+5, int(lines.get(14).p1.y)+5); 

  maskPoints[keystoneNum][6] = new MPoint(int(lines.get(14).p1.x)-5, int(lines.get(14).p2.y)+5); 
  maskPoints[keystoneNum][7] = new MPoint(int(lines.get(10).p1.x)-5, int(lines.get(10).p2.y)+5);  
  maskPoints[keystoneNum][8] = new MPoint(int(lines.get(6).p1.x)-5, int(lines.get(6).p2.y)+5);  
  maskPoints[keystoneNum][9] = new MPoint(int(lines.get(2).p1.x)-5, int(lines.get(2).p2.y)+5); 
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

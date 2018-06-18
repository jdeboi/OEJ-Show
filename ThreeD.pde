boolean editing3D = false;
boolean isDragging = false;
int cubeMode = 0;
int moveMode = 0;
int moveModeZ = 1;
int rotateModeX = 2;
int rotateModeY = 3;
int rotateModeZ = 4;
int changeScaleMode = 5;
Cube selectedCube;

ArrayList<Cube> cubes;

void initCubes() {
  //cubes = new ArrayList<Cube>();
  //cubes.add(new Cube(new PVector(100, 300, -50), new PVector(radians(-10), 0, 0), screenW/4, color(255)));
  //cubes.add(new Cube(new PVector(500, 300, -50), new PVector(radians(-10), 0, 0), screenW/4, color(255)));
  loadCubes();
}

void display3D() {
  lights();
  noStroke();
  for (Cube c : cubes) {
    c.display();
  }
}

void cubesReleaseMouse() {
  isDragging = false;
  selectedCube = null;
}

void check3DClick() {
  for (Cube c : cubes) {
    if (c.mouseOver()) {
      selectedCube = c;
      isDragging = true;
      return;
    }
  }
  selectedCube = null;
  isDragging = false;
  return;
}

void updateCubes() {
  if (isDragging) {
    if (cubeMode == moveMode) {
      selectedCube.move();
    } else if (cubeMode == moveModeZ) {
      selectedCube.moveZ();
    }else if (cubeMode == rotateModeX) {
      selectedCube.rotateCX();
    }else if (cubeMode == rotateModeY) {
      selectedCube.rotateCY();
    }else if (cubeMode == rotateModeZ) {
      selectedCube.rotateCZ();
    }
    else if (cubeMode == changeScaleMode) {
      selectedCube.changeScale();
    }
  }
}

void saveCubes() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("numCubes", cubes.size());
  saveJSONObject(json, "data/cubes/cubes.json");

  processing.data.JSONArray cubesList = new processing.data.JSONArray();      

  for (int i = 0; i < cubes.size(); i++) {
    processing.data.JSONObject cubeJSON = new processing.data.JSONObject();
    Cube c = cubes.get(i);
    cubeJSON.setFloat("x", c.loc.x);
    cubeJSON.setFloat("y", c.loc.y);
    cubeJSON.setFloat("z", c.loc.z);
    
    cubeJSON.setFloat("rx", c.rot.x);
    cubeJSON.setFloat("ry", c.rot.y);
    cubeJSON.setFloat("rz", c.rot.z);
    
    cubeJSON.setFloat("w", c.w);

    cubesList.setJSONObject(i, cubeJSON);
  }
  json.setJSONArray("cubes", cubesList);
  saveJSONObject(json, "data/cubes/cubes.json");
}

void loadCubes() {
  cubes = new ArrayList<Cube>();
  processing.data.JSONObject cubesJson;
  cubesJson = loadJSONObject("data/cubes/cubes.json");
  int numCubes = cubesJson.getInt("numCubes");
  println(numCubes);

  processing.data.JSONArray cubesArray = cubesJson.getJSONArray("cubes");
  for (int i = 0; i < numCubes; i++) {
    processing.data.JSONObject c = cubesArray.getJSONObject(i);
    float x = c.getFloat("x");
    float y = c.getFloat("y");
    float z = c.getFloat("z");
    
    float rx = c.getFloat("rz");
    float ry = c.getFloat("ry");
    float rz = c.getFloat("rz");
    
    float w = c.getFloat("w");
    
    cubes.add(new Cube(new PVector(x, y, z), new PVector(rx, ry, rz), w, color(255)));
  }
}

class Cube {

  PVector loc;
  float w;
  PVector rot;
  color c;

  Cube(PVector loc, PVector rot, float w, color c) {
    this.loc = loc;
    this.rot = rot;
    this.w = w;
    this.c = c;
  }

  boolean mouseOver() {
    return (mouseX > loc.x && mouseX < loc.x + w && mouseY > loc.y && mouseY < loc.y + w);
  }

  void move() {
    loc.set(mouseX, mouseY, 0);
  }
  
  void moveZ() {
    float rate = 1;
    float dz = (pmouseY-mouseY) * rate;
    loc.add(0, 0, dz);
    println(loc.z);
  }

  //void display(PImage tex) {
  void display() {
    if (mouseOver()) fill(255, 0, 0);
    else fill(c);
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    scale(w);
    beginShape(QUADS);
    //texture(tex);

    // Given one texture and six faces, we can easily set up the uv coordinates
    // such that four of the faces tile "perfectly" along either u or v, but the other
    // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
    // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
    // rotation along the X axis will put the "top" of either texture at the "top"
    // of the screen, but is not otherwised aligned with the X/Z faces. (This
    // just affects what type of symmetry is required if you need seamless
    // tiling all the way around the cube)

    // +Z "front" face
    vertex(-1, -1, 1, 0, 0);
    vertex( 1, -1, 1, 1, 0);
    vertex( 1, 1, 1, 1, 1);
    vertex(-1, 1, 1, 0, 1);

    // -Z "back" face
    vertex( 1, -1, -1, 0, 0);
    vertex(-1, -1, -1, 1, 0);
    vertex(-1, 1, -1, 1, 1);
    vertex( 1, 1, -1, 0, 1);

    // +Y "bottom" face
    vertex(-1, 1, 1, 0, 0);
    vertex( 1, 1, 1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex(-1, 1, -1, 0, 1);

    // -Y "top" face
    vertex(-1, -1, -1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, -1, 1, 1, 1);
    vertex(-1, -1, 1, 0, 1);

    // +X "right" face
    vertex( 1, -1, 1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, 1, -1, 1, 1);
    vertex( 1, 1, 1, 0, 1);

    // -X "left" face
    vertex(-1, -1, -1, 0, 0);
    vertex(-1, -1, 1, 1, 0);
    vertex(-1, 1, 1, 1, 1);
    vertex(-1, 1, -1, 0, 1);

    endShape();

    popMatrix();
  }

  void rotateCX() {
    float rate = 0.01;
    float rotx = (pmouseY-mouseY) * rate;
    //float roty = (mouseX-pmouseX) * rate;
    rot.add(rotx, 0, 0);
  }
  void rotateCY() {
    float rate = 0.01;
    float roty = (mouseX-pmouseX) * rate;
    rot.add(0, roty, 0);
  }
  void rotateCZ() {
    float rate = 0.01;
    float rotz = (mouseX-pmouseX) * rate;
    rot.add(0, 0, rotz);
  }
  void changeScale() {
    float rate = 1;
    float dw = (mouseX-pmouseX) * rate;
    w += dw;
  }
}

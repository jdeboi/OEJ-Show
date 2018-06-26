 import controlP5.*;
import java.util.*;
ControlP5 cp5;

// start / stop music

Toggle togMap, togEdit, togShow, togP, togEditMask, togMask, togEdit3D;
Textlabel timeText;
Textarea myTextarea;
int ymen = 0;

void initControls() {
  cp5 = new ControlP5(this);

  // create a toggle and change the default look to a (on/off) switch look
  togMap = cp5.addToggle("toggleMap")
    .setPosition(750, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Map OFF")
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addButton("saveMap")
    .setValue(0)
    .setPosition(750, 200)
    .setSize(80, 19)
    .setLabel("Save Mapping")
    ;

  togP = cp5.addToggle("toggleP")
    .setPosition(xSpace, ySpace + vH + 30)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("PLAY")
    ;

  togEdit = cp5.addToggle("toggleEditBreak")
    .setPosition(850, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Breaks Off")
    .setMode(ControlP5.SWITCH)
    ;

  togEditMask = cp5.addToggle("toggleEditMask")
    .setPosition(950, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Mask Off")
    .setMode(ControlP5.SWITCH)
    ;
    
  togMask = cp5.addToggle("toggleMask")
    .setPosition(950, 100)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Mask Off")
    .setMode(ControlP5.SWITCH)
    ;

  togEdit3D = cp5.addToggle("toggleEdit3D")
    .setPosition(1100, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit 3D Off")
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addButton("saveCubes")
    .setValue(0)
    .setPosition(1100, 200)
    .setSize(80, 19)
    .setLabel("Save Cubes")
    ;

  cp5.addButton("saveMask")
    .setValue(0)
    .setPosition(950, 200)
    .setSize(80, 19)
    .setLabel("Save Mask")
    ;

  cp5.addButton("saveBreaks")
    .setValue(0)
    .setPosition(850, 200)
    .setSize(80, 19)
    .setLabel("Save Breaks")
    ;

  timeText = cp5.addTextlabel("label")
    .setText(nf(0))
    .setPosition(xSpace, ySpace + 50)
    ;


  String[] songNames = new String[scenes.length];
  for (int i = 0; i < scenes.length; i++) {
    songNames[i] = (i+1) + ". " + scenes[i].shortName;
  }
  List l = Arrays.asList(songNames);
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("songs")
    .setColorBackground(color(10, 155, 0))
    .setPosition(0, ymen)
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("GIF_ALL", "GIF_ACROSS", "IMG_ALL", "IMG_ACROSS", "FFT", "TILE_VID", "VID_ACROSS", "VID_MIRROR");
  cp5.addScrollableList("modeList")
    .setPosition(150, ymen)
    .setColorBackground(color(105, 10, 0))
    .setSize(150, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("0", "1");
  cp5.addScrollableList("keystoneList")
    .setPosition(750, ymen)
    .setColorBackground(color(105, 110, 0))
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

  l = Arrays.asList("moveXY", "moveZ", "rotateX", "rotateY", "rotateZ", "scale");
  cp5.addScrollableList("cubeEdit")
    .setPosition(850, ymen)
    .setColorBackground(color(105, 170, 0))
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    ;

}


void modeList(int n) {
  mode = n + 1;
}

void movieList(int n) {
  initVid("_testing/movies/" + testingMovies[n]);
}

void imageList(int n) {
  currentTestImg = loadImage("_testing/images/" + testingImages[n]);
}

void cubeEdit(int n) {
  cubeMode = n;
  println("cube mode : " + cubeMode);
}

void keystoneList(int n) {
  keystoneNum = n;
  loadKeystone(n);
}

void gifs(int n) {
  currentTestGif = new Gif(this, "_testing/gifs/" + testingGifs[n]);
  currentTestGif.loop();
}

void songs(int n) {
  changeScene(n);
}

public void saveMap(int theValue) {
  println("map saved " + keystoneNum);
  if (useCenterScreen) ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
  else ks.save("data/keystone/keystone" + keystoneNum + ".xml");
}

//public void saveMapAs(int theValue) {
//  if (millis() > 10000) keystoneNum++;
//  println("map saved as " + keystoneNum);
//  if (useCenterScreen) ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
//  else ks.save("data/keystone/keystone" + keystoneNum + ".xml");
//}

public void saveMask(int theValue) {
  println("mask saved");
  saveMaskPoints();
}

public void saveCubes(int theValue) {
  println("cubes saved");
  saveCubes();
}

public void saveBreaks(int theValue) {
  println("breaks saved");
  bubbleSort();
  saveToFile();
}

public void input(String theText) {
  if (editingBreaks && selected > -1) {
    println(theText + " " + selected);
    breaks.get(selected).text = theText;
  }
}

void toggleP(boolean theFlag) {
  if (startShow) {
    togglePlay();
    if (isPlaying) {
      togP.setLabel("PAUSE");
    } else {
      togP.setLabel("PLAY");
    }
  }
}

void toggleEditMask(boolean theFlag) {
  editingMask = theFlag;
  String o = editingMask?"ON":"OFF";
  togEditMask.setLabel("Edit Mask " + o);
  println("toggling edit mask");
}

void toggleMask(boolean theFlag) {
  showMask = theFlag;
  String o = showMask?"ON":"OFF";
  togMask.setLabel("Mask " + o);
  println("toggling show mask");
}

void toggleEdit3D(boolean theFlag) {
  editing3D = theFlag;
  String o = editing3D?"ON":"OFF";
  togEdit3D.setLabel("Edit 3D " + o);
  println("toggling edit 3D");
}

void toggleEditBreak(boolean theFlag) {
  editingBreaks = theFlag;
  String o = editingBreaks?"ON":"OFF";
  togEdit.setLabel("Edit Breaks " + o);
  println("toggling edit");
}

//void toggleShow(boolean theFlag) {
//  if (theFlag) {
//    isTesting = theFlag;
//    togShow.setLabel("TESTING");
//  }
//  else {
//    isTesting = false;
//    changeScene(0);
//    togShow.setLabel("SHOW TIME");
//  }
//}


void toggleMap(boolean theFlag) {
  editingMapping = theFlag;
  if (theFlag) ks.startCalibration();
  else ks.stopCalibration();
  String o = theFlag?"ON":"OFF";
  togMap.setLabel("Map " + o);
}
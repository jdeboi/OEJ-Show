import controlP5.*;
import java.util.*;
boolean controlsON = false;
ControlP5 cp5;

// start / stop music

Toggle togMap, togEdit, togShow, togP, togEditMask, togEditAll, togMask, togEdit3D, togEditLines;
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

  togEditAll = cp5.addToggle("toggleEditAll")
    .setPosition(400, 50)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Editing OFF")
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

  //togEdit3D = cp5.addToggle("toggleEdit3D")
  //  .setPosition(1100, 150)
  //  .setSize(50, 20)
  //  .setValue(false)
  //  .setLabel("Edit 3D Off")
  //  .setMode(ControlP5.SWITCH)
  //  ;

  togEditLines =  cp5.addToggle("toggleEditLines")
    .setPosition(1250, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Lines Off")
    .setMode(ControlP5.SWITCH)
    ;

  //cp5.addButton("saveCubes")
  //  .setValue(0)
  //  .setPosition(1100, 200)
  //  .setSize(80, 19)
  //  .setLabel("Save Cubes")
  //  ;

  cp5.addButton("saveMask")
    .setValue(0)
    .setPosition(950, 200)
    .setSize(80, 19)
    .setLabel("Save Mask")
    ;

  cp5.addButton("snapMask")
    .setValue(0)
    .setPosition(950, 250)
    .setSize(80, 19)
    .setLabel("Snap Mask To Lines")
    ;


  cp5.addButton("saveLines")
    .setValue(0)
    .setPosition(1250, 200)
    .setSize(80, 19)
    .setLabel("Save Lines")
    ;

  timeText = cp5.addTextlabel("label")
    .setText(nf(0))
    .setPosition(xSpace, ySpace + 50)
    ;


  //String[] songNames = new String[scenes.length];
  //for (int i = 0; i < scenes.length; i++) {
  //  songNames[i] = (i+1) + ". " + scenes[i].shortName;
  //}
  //List l = Arrays.asList(songNames);
  ///* add a ScrollableList, by default it behaves like a DropdownList */
  //cp5.addScrollableList("songs")
  //  .setColorBackground(color(10, 155, 0))
  //  .setPosition(0, ymen)
  //  .setSize(150, 100)
  //  .setBarHeight(20)
  //  .setItemHeight(20)
  //  .addItems(l)
  //  ;

//  l = Arrays.asList("GIF_ALL", "GIF_ACROSS", "IMG_ALL", "IMG_ACROSS", "FFT", "TILE_VID", "VID_ACROSS", "VID_MIRROR");
//  cp5.addScrollableList("modeList")
//    .setPosition(150, ymen)
//    .setColorBackground(color(105, 10, 0))
//    .setSize(150, 100)
//    .setBarHeight(20)
//    .setItemHeight(20)
//    .addItems(l)
//    ;

//  l = Arrays.asList("0", "1");
//  cp5.addScrollableList("keystoneList")
//    .setPosition(750, ymen)
//    .setColorBackground(color(105, 110, 0))
//    .setSize(100, 100)
//    .setBarHeight(20)
//    .setItemHeight(20)
//    .addItems(l)
//    ;

  //l = Arrays.asList("moveXY", "moveZ", "rotateX", "rotateY", "rotateZ", "scale");
  //cp5.addScrollableList("cubeEdit")
  //  .setPosition(850, ymen)
  //  .setColorBackground(color(105, 170, 0))
  //  .setSize(100, 100)
  //  .setBarHeight(20)
  //  .setItemHeight(20)
  //  .addItems(l)
  //  ;
}


public void controlEvent(ControlEvent theEvent) {
  //println(theEvent.getController().getName());
  //n = 0;
}

//void modeList(int n) {
//  mode = n + 1;
//}

//void movieList(int n) {
//  initVid("_testing/movies/" + testingMovies[n]);
//}

//void imageList(int n) {
//  currentTestImg = loadImage("_testing/images/" + testingImages[n]);
//}

//void cubeEdit(int n) {
//  if (controlsON) {
//    cubeMode = n;
//    println("cube mode : " + cubeMode);
//  }
//}

//void keystoneList(int n) {
//  loadKeystone(n);
//}

//void gifs(int n) {
//  currentTestGif = new Gif(this, "_testing/gifs/" + testingGifs[n]);
//  currentTestGif.loop();
//}

//void songs(int n) {
//  changeScene(n);
//}

public void saveMap(int theValue) {
  if (controlsON) {
    println("map saved " + keystoneNum);
    saveKeystone();
  }
}

//public void saveMapAs(int theValue) {
//  if (millis() > 10000) keystoneNum++;
//  println("map saved as " + keystoneNum);
//  if (useCenterScreen) ks.save("data/keystone/keystoneCenter" + keystoneNum + ".xml");
//  else ks.save("data/keystone/keystone" + keystoneNum + ".xml");
//}

public void saveMask(int theValue) {
  if (controlsON) {
    saveMaskPoints();
  }
}

public void snapMask(int theValue) {
  if (controlsON) {
    println("mask snapped to outline");
    snapMaskToOutline();
  }
}

//public void saveCubes(int theValue) {
//  if (controlsON) {
//    println("cubes saved");
//    saveMappedCubes();
//  }
//}


public void saveLines(int theValue) {
  if (controlsON) {
    println("lines saved");
    saveMappedLines();
  }
}


void toggleP(boolean theFlag) {
  if (controlsON) {
    if (startShow) {
      togglePlay();
      if (isPlaying) {
        togP.setLabel("PAUSE");
      } else {
        togP.setLabel("PLAY");
      }
    }
  }
}

void toggleEditMask(boolean theFlag) {
  if (controlsON) {
    editingMask = theFlag;
    String o = editingMask?"ON":"OFF";
    togEditMask.setLabel("Edit Mask " + o);
    println("toggling edit mask");
  }
}

void toggleMask(boolean theFlag) {
  if (controlsON) {
    showMask = theFlag;
    String o = showMask?"ON":"OFF";
    togMask.setLabel("Mask " + o);
    println("toggling show mask");
  }
}

//void toggleEdit3D(boolean theFlag) {
//  if (controlsON) {
//    editing3D = theFlag;
//    String o = editing3D?"ON":"OFF";
//    togEdit3D.setLabel("Edit 3D " + o);
//    println("toggling edit 3D");
//  }
//}

void toggleEditLines(boolean theFlag) {
  if (controlsON) {
    editingLines = theFlag;
    String o = editingLines?"ON":"OFF";
    togEditLines.setLabel("Edit Lines " + o);
    println("toggling edit lines");
  }
}

void toggleEditBreak(boolean theFlag) {
  if (controlsON) {
    editingBreaks = theFlag;
    String o = editingBreaks?"ON":"OFF";
    togEdit.setLabel("Edit Breaks " + o);
    println("toggling edit");
  }
}

void toggleEditAll(boolean theFlag) {
  if (controlsON) {
    mappingON = theFlag;
    String o = theFlag?"ON":"OFF";
    togEditAll.setLabel("editing " + o);
  }
}

void toggleMap(boolean theFlag) {
  if (controlsON) {
    editingMapping = theFlag;
    strokeWeight(1);
    if (theFlag) ks.startCalibration();
    else ks.stopCalibration();
    String o = theFlag?"ON":"OFF";
    togMap.setLabel("Map " + o);
  }
}

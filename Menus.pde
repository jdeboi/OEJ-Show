import controlP5.*;
import java.util.*;
ControlP5 cp5;

// start / stop music

// choose song

Toggle togMap, togEdit;
Textlabel timeText;
Textarea myTextarea;

void initControls() {
  cp5 = new ControlP5(this);

  // create a toggle and change the default look to a (on/off) switch look
  togMap = cp5.addToggle("toggleMap")
    .setPosition(50, 150)
    .setSize(50, 20)
    .setValue(true)
    .setLabel("Map On")
    .setMode(ControlP5.SWITCH)
    ;

  cp5.addButton("saveMap")
    .setValue(0)
    .setPosition(50, 200)
    .setSize(100, 19)
    .setLabel("Save Mapping")
    ;

  togEdit = cp5.addToggle("toggleEditBreak")
    .setPosition(250, 150)
    .setSize(50, 20)
    .setValue(false)
    .setLabel("Edit Breaks Off")
    .setMode(ControlP5.SWITCH)
    ;



  cp5.addButton("saveBreaks")
    .setValue(0)
    .setPosition(250, 200)
    .setSize(100, 19)
    .setLabel("Save Breaks")
    ;

  timeText = cp5.addTextlabel("label")
    .setText(nf(0))
    .setPosition(50, 130)
    ;
    
  cp5.addTextfield("input")
    .setPosition(500, 150)
    .setSize(200, 20)
    .setFocus(false)
    ;

  myTextarea = cp5.addTextarea("txt")
    .setPosition(500, 200)
    .setSize(300, 50)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100));
  ;
  myTextarea.setText("");
}

public void saveMap(int theValue) {
  println("map saved");
  ks.save();
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

void toggleEditBreak(boolean theFlag) {
  editingBreaks = theFlag;
  String o = editingBreaks?"ON":"OFF";
  togEdit.setLabel("Edit Breaks " + o);
}


void toggleMap(boolean theFlag) {
  ks.toggleCalibration();
  String o = theFlag?"ON":"OFF";
  togMap.setLabel("Map " + o);
}

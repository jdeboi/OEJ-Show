
boolean ADD_ON = false;
int selected = -1;
boolean editingBreaks = false;

import java.util.*;
import java.util.LinkedList;
import java.util.List;
ArrayList<Break> breaks;
int currentBreak = 0;

int xSpace = 270;
int vW = 800;
int vH = 40;
int ySpace = 60;
int infoX = 400;
int infoY = 150;

class Break {

  int songT;
  char breakType;
  int x, y;
  boolean highlight = false;
  String text;

  Break(int t, char b, int x, int y) {
    songT = t;
    breakType = b;
    this.x = x;
    this.y = y;
  }
  Break(int t, char b) {
    songT = t;
    breakType = b;
    x = int(map(songT, 0, songFile.length(), xSpace, xSpace + vW));
    y = ySpace;
  }
  Break(int t, String b, int x, int y, String txt) {
    songT = t;
    breakType = b.charAt(0);
    this.x = x;
    this.y = y;
    text = txt;
  }

  void display() {
    stroke((parseInt(breakType)*15)%255, 255, 255);
    strokeWeight(1);
    if (mouseOver() || highlight) strokeWeight(3);
    line(x, y+1, x, y + vH - 2);
    //if (highlight) {
    //  noFill();
    //  stroke(200);
    //  rect(x-1, y, 3, vH);
    //}
  }

  void displayInfo() {
    if (mouseOver() || highlight) {
    strokeWeight(1);
    stroke(255);
    String t = "'" + breakType + "'" + ": " + timeString(songT) + "\n" + text;
    myTextarea.setText(t);
    }
  }


  boolean mouseOver() {
    int sp = 5;

    return (mouseX > x - sp/2 && mouseX < x + sp/2 && mouseY > ySpace && mouseY < ySpace + vH);
  }

  void move(int t) {
    songT -= t;
    if (songT < 0) songT = 0;
    else if (songT >= songFile.length()) songT = songFile.length() -1;
  }
}

String timeString(int mil) {
  return nf(mil/1000.0, 3, 2);
}

void sortByTime() {
  bubbleSort();
}

void bubbleSort() {
  int n = breaks.size();

  for (int i=0; i < n; i++) {
    for (int j=1; j < (n-i); j++) {

      if (breaks.get(j-1).songT > breaks.get(j).songT) {
        //swap the elements!
        Collections.swap(breaks, j, j-1);
      }
    }
  }
}

void saveToFile() {
  processing.data.JSONObject json;
  json = new processing.data.JSONObject();
  json.setInt("numBreaks", breaks.size());
  json.setInt("songLen", songFile.length());
  saveJSONObject(json, "data/breaks/" + currentScene.song + "_breaks.json");

  processing.data.JSONArray breakList = new processing.data.JSONArray();      

  for (int i = 0; i < breaks.size(); i++) {
    processing.data.JSONObject breakJSON = new processing.data.JSONObject();
    Break b = breaks.get(i);
    breakJSON.setInt("time", b.songT);
    breakJSON.setString("text", b.text);
    breakJSON.setString("breakType", str(b.breakType));

    breakList.setJSONObject(i, breakJSON);
  }

  json.setJSONArray("breakList", breakList);


  saveJSONObject(json, "data/breaks/" + currentScene.song + "_breaks.json");
}


void loadBreaks() {
  processing.data.JSONObject breaksJson;
  breaksJson = loadJSONObject("data/breaks/" + currentScene.song + "_breaks.json");
  int numBreaks = breaksJson.getInt("numBreaks");
  int songLen = breaksJson.getInt("songLen");
  println(numBreaks);
  //resetBreaks();

  processing.data.JSONArray breaksArray = breaksJson.getJSONArray("breakList");
  for (int i = 0; i < numBreaks; i++) {
    processing.data.JSONObject b = breaksArray.getJSONObject(i);
    String breakType = b.getString("breakType");
    int t = b.getInt("time");
    String txt = b.getString("text");
    println(t);
    int x = int(map(t, 0, songLen, xSpace, xSpace + vW));
    int y = ySpace;
    breaks.add(new Break(t, breakType, x, y, txt));
  }
}

void resetBreaks() {
  breaks = new ArrayList<Break>();
}

void initBreaks() {
  breaks = new ArrayList<Break>();
  if (ADD_ON) loadBreaks();
}

void drawPlayer() {
  stroke(255);
  strokeWeight(1);
  noFill();
  //if (editingBreaks) fill(255);
  rect(xSpace, ySpace, vW, vH);
  float position = map( songFile.position(), 0, songFile.length(), xSpace, xSpace+vW );
  stroke(255, 0, 0);
  line( position, ySpace, position, ySpace+vH );

  for (int i = 0; i < breaks.size(); i++) {
    breaks.get(i).display();
  }
  stroke(255);
  strokeWeight(1);
  textSize(12);
  timeText.setText((nf(songFile.position()/1000.0, 3, 2)));
  //text(nf(songFile.position()/1000.0, 3,2), xSpace, ySpace + vH);
}

void drawSongLabel() {
  textSize(20);
  fill(255);
  text(currentScene.order + ". " + currentScene.song, xSpace, 50);
}

void mousePlayer() {
  int x = xSpace;
  int y = ySpace;
  int w = vW;
  int h = vH;
  if (mouseY > y && mouseY < y + h && mouseX > x && mouseX < x + w) {
    int position = int( map( mouseX, x, x+w, 0, songFile.length() ) );
    songFile.cue( position );
  } else {
    if (!cp5.get(Textfield.class, "input").isMouseOver()) {
      resetHighlights();
      selected = -1;
    }
  }
}

void resetHighlights() {
  for (Break b : breaks) {
    b.highlight = false;
  }
}

void drawBreakInfo() {
  strokeWeight(1);
  //if (editingBreaks && selected > -1) {
  //  breaks.get(selected).displayInfo();
  //} 
  if (editingBreaks) {
    for (Break b : breaks) {
      b.displayInfo();
    }
  }
}

void drawLines() {
  for (int i = 0; i < songFile.bufferSize() - 1; i++) {
    line(i, 50  + songFile.left.get(i)*50, i+1, 50  + songFile.left.get(i+1)*50);
    line(i, 150 + songFile.right.get(i)*50, i+1, 150 + songFile.right.get(i+1)*50);
  }
}

//void drawModeLabel() {
//  if (editingBreaks) {
//    noStroke();
//    fill(150, 255, 255);
//    rect(0,height-50, width, 50);
//    fill(255);
//    stroke(255);
//    textSize(30);
//    text("EDITING BEATS", 35, height - 15);
//  }
//}

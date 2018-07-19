Spotlight[] spotlights;

class Spotlight {
  color c;
  int x1, x2;
  int y1, y2;
  int r;
  int mode;
  
  Spotlight(int x1, int y1, int x2, int y2, int r) {
    this.x1 = x1; 
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.r = r;
    
    mode = 0;
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
}

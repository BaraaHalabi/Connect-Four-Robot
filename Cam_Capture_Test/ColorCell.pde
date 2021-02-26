class ColorCell {
  int x, y, r;
  color cellColor;
  boolean highlight;

  ColorCell(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
    highlight = false;
  }

  ColorCell() {
    highlight = false;
  }

  void setPos(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void setRaduis(int r) {
    this.r = r;
  }

  color getAvgColor() {
    int r = 0, g = 0, b = 0, c = 1;
    for (int i = x - this.r; i < x + this.r; i ++) {
      for (int j = y - this.r; j < y + this.r; j ++) {
        if (dist(i, j, x, y) <= this.r) {
          r += red(get(i, j));
          g += green(get(i, j));
          b += blue(get(i, j));
          c ++;
        }
      }
    }
    r /= c;
    g /= c;
    b /= c;
    return color(r, g, b);
  }

  color getAvgColor(int x, int y) {
    int r = 0, g = 0, b = 0, c = 1;
    for (int i = x - this.r; i < x + this.r; i ++) {
      for (int j = y - this.r; j < y + this.r; j ++) {
        
        if (dist(i, j, x, y) <= this.r) {
          r += red(get(i, j));
          g += green(get(i, j));
          b += blue(get(i, j));
          c ++;
        }
      }
    }
    r /= c;
    g /= c;
    b /= c;
    return color(r, g, b);
  }

  void print() {
    color c = getAvgColor();
    println("[" + red(c) + ", " + green(c) + ", ", blue(c) + "]");
  }

  void print(int x, int y) {
    color c = getAvgColor(x, y);
    println("[" + red(c) + ", " + green(c) + ", ", blue(c) + "]");
  }
  
  void setColor(color c) {
    cellColor = c; 
  }
  
  void renderByCellColor() {
    stroke(0);
    strokeWeight(4);
    ellipseMode(CENTER);
    fill(cellColor);
    ellipse(x, y, r * 2, r * 2);
  }

  void render() {
    if(highlight)
      stroke(255, 0, 0);
    else
      stroke(0);
    strokeWeight(r / 3);
    ellipseMode(CENTER);
    fill(getAvgColor());
    ellipse(x, y, r * 2, r * 2);
    
    //optional
    if(highlight) {
      printColor(); 
    }
  }

  void render(int x, int y) {
    if(highlight)
      stroke(255, 0, 0);
    else
      stroke(0);
    strokeWeight(r / 10);
    ellipseMode(CENTER);
    fill(getAvgColor(x, y));
    ellipse(x, y, r * 2, r * 2);
    
    //optional
    if(highlight) {
      printColor();
    }
  }
  
  void printColor() {
    color c = getAvgColor(x, y);
     println((red(c) + green(c) + blue(c)) / 3.0);
  }
  
  double getGrayValue() {
    color c = getAvgColor(x, y);
    return (red(c) + green(c) + blue(c)) / 3.0;
  }
  
  boolean isOver() {
    if(dist(mouseX, mouseY, x, y) <= r)
      return true;
    return false;
  }
}

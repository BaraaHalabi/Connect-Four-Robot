class cd {
  int x, y, r;
  color cellColor;

  cd(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  cd() {
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
    stroke(0);
    strokeWeight(4);
    ellipseMode(CENTER);
    fill(getAvgColor());
    ellipse(x, y, r * 2, r * 2);
  }

  void render(int x, int y) {
    stroke(0);
    strokeWeight(4);
    ellipseMode(CENTER);
    fill(getAvgColor(x, y));
    ellipse(x, y, r * 2, r * 2);
  }
}

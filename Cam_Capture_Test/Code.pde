class circle {
  public
    int x, y;
  color c;

  void render() {
    ellipseMode(CENTER);
    ellipse(x, y, 20, 20);
  }

  void printColor() {
    println('[', red(c), ", ", green(c), ", ", blue(c), ']');
  }
}

class point {
  public
    int x, y;
  point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

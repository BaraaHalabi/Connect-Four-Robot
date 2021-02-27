public enum Cell {
  Empty(0), Red(1), Yellow(2);
  int state;

  private Cell(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

public enum Turn {
  Bot(0), Human(1);
  int state;

  private Turn(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

public enum Shape {
  Rect(0), Eclipse(1);
  int state;

  private Shape(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

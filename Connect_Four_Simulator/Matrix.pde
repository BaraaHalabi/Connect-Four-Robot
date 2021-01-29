class Matrix {
  int PX;
  
  Matrix() {
    
  }
  
  void Create(int x, int y, int w, int h, int padding, int columns, int rows, PShape shape) {
    PX = x;
    for (int i = 0; i < rows; i ++) {
      for (int j = 0; j < columns; j ++) {
           shape(shape);
         x += w + padding;
      }
      y += padding + h;
      x = PX;
    }
  }
}

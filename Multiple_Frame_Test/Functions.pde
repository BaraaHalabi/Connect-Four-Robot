String substr(String s, int a, int b) {
  String ret = "";
  for(int i = a; i <= b; i ++)
    ret += s.charAt(i);
  return ret;
}

int power(int b, int p) {
  return (p == 0 ? 1 : b * power(b, --p));
}

int strToInt(String s) {
  int ret = 0;
  for(int i = 0; i < s.length(); i ++)
     ret += (s.charAt(i) - '0') * power(10, s.length() - i - 1);
  return ret;
}

void loadBoardCells(String data, int size) {
  int prev = 0, next, cnt = 0;
  for(int i = 1; i < data.length(); i ++) { 
    while(data.charAt(i) != '#')
       i ++;
    next = i;
    String values = substr(data, prev + 1, next - 1);
    int a = 0;
    for(int j = 0; j < values.length(); j ++)
      if(values.charAt(j) == ',')
        a = j;
    int x = strToInt(substr(values, 0, a - 1)), y = strToInt(substr(values, a + 1, values.length() - 1));
    boardCells[cnt / 7][cnt % 7] = new ColorCell(x, y, size);
    cnt ++;
    prev = next;
    i ++;
  }
}

void loadRailCells(String data, int size) {
  int prev = 0, next, cnt = 0;
  for(int i = 1; i < data.length(); i ++) { 
    while(data.charAt(i) != '#')
       i ++;
    next = i;
    String values = substr(data, prev + 1, next - 1);
    int a = 0;
    for(int j = 0; j < values.length(); j ++)
      if(values.charAt(j) == ',')
        a = j;
    int x = strToInt(substr(values, 0, a - 1)), y = strToInt(substr(values, a + 1, values.length() - 1));
    railCells[cnt] = new ColorCell(x, y, size);
    cnt ++;
    prev = next;
    i ++;
  }
}

void editData() {
  writer = createWriter("pos.txt");
  for(int i = 0; i < 7; i ++) {
    writer.print("#");
    writer.print(railCells[i].x);
    writer.print(",");
    writer.print(railCells[i].y);
  }
  writer.println("#");
  
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      writer.print("#");
      writer.print(boardCells[i][j].x);
      writer.print(",");
      writer.print(boardCells[i][j].y);
    }
  }
  writer.print("#");
  writer.flush();
}

import processing.video.*;
import processing.serial.*;

SimApp simApp;
Popup popup;
Game game;

ColorCell[][] boardCells = new ColorCell[6][7];
ColorCell[] railCells = new ColorCell[7];
PrintWriter writer;
Capture cam;

void settings() {
  size(640, 480);
  simApp = new SimApp();
}

void setup() {
  surface.setTitle("Computer Vision");
  String args[] = {"Simulator Applet"};
  
  //retrieving data from txt file
  String[] preload = loadStrings("pos.txt");
  writer = createWriter("pos.txt");
  for(int i = 0; i < preload.length; i ++)
    writer.print(preload[i]);
  writer.flush();
  
  //looking for and starting the camera
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No cameras available");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[1]);
    cam.start();
  }
  delay(3000);
  
  //luach the game simulator
  PApplet.runSketch(args, simApp);
  
  //loading data from txt file
  loadRailCells(preload[0], 5);
  loadBoardCells(preload[1], 10);
}

void draw() {
  background(55);
  if (cam.available())
    cam.read();
  image(cam, 0, 0);
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      boardCells[i][j].render();
    }
  }
  for(int i = 0; i < 7; i ++) {
    railCells[i].render(); 
  }
  
  int target = 7;
  
  if(200 - railCells[target - 1].getGrayValue() > 100) {
    //do something
    //port.write('d');
    //noLoop();
    //exit();
  }
  editData();
}

void mousePressed() {
  for (int i = 0; i < 6; i ++)
    for (int j = 0; j < 7; j ++)
      boardCells[i][j].highlight = false;
  for(int i = 0; i < 7; i ++)
    railCells[i].highlight = false;
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      if (boardCells[i][j].isOver()) {
        for (int k = 0; k < 6; k ++)
          for (int l = 0; l < 7; l ++)
            boardCells[k][l].highlight = false;
        boardCells[i][j].highlight = true;
      }
    }
  }
  for(int i = 0; i < 7; i ++) {
    if(railCells[i].isOver()) {
      for(int j = 0; j < 7; j ++)
        railCells[i].highlight = false;  
      railCells[i].highlight = true;
    }
  }
  //println(mouseX, mouseY);
}

void keyPressed() {
  final int shiftValue = 1;
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      if (boardCells[i][j].highlight) {
        switch(keyCode) {
        case LEFT:
          boardCells[i][j].x -= shiftValue;
          break;
        case UP:
          boardCells[i][j].y -= shiftValue;
          break;
        case RIGHT:
          boardCells[i][j].x += shiftValue;
          break;
        case DOWN:
          boardCells[i][j].y += shiftValue;
          break;
        }
      }
    }
  }
  for(int i = 0; i < 7; i ++) {
    if(railCells[i].highlight) {
      switch(keyCode) {
        case LEFT:
          railCells[i].x -= 1;
          break;
        case UP:
          railCells[i].y -= 1;
          break;
        case RIGHT:
          railCells[i].x += 1;
          break;
        case DOWN:
          railCells[i].y += 1;
          break;
        } 
    }
  }
}

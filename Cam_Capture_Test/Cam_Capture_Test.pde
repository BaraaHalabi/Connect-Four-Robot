import processing.video.*;
import processing.serial.*;

Serial cPort;

ArrayList<circle> circles = new ArrayList<circle>();

point p = new point(563, 20);

boolean found = false, filterOn = true;

double val = 0, cnt = 0;

//final color red = color(248.458, 88.6042, 0);
final color red = color(248.458, 0, 0);  
final color yellow = color(253.073, 248.454, 0);

final color monoRed = color(38.27272727272727);
final color monoYellow = color(125.6);

Capture cam;
int rad = 10;
 
int currBoard[][] = new int[6][7];

cd board[][] = {
  {
    new cd(66, 91, rad), 
    new cd(154, 89, rad), 
    new cd(237, 90, rad), 
    new cd(321, 92, rad), 
    new cd(398, 91, rad), 
    new cd(484, 90, rad), 
    new cd(568, 88, rad)
  }, 

  {
    new cd(66, 160, rad), 
    new cd(151, 162, rad), 
    new cd(235, 161, rad), 
    new cd(318, 164, rad), 
    new cd(401, 159, rad), 
    new cd(485, 162, rad), 
    new cd(565, 162, rad), 
  }, 

  {
    new cd(65, 238, rad), 
    new cd(150, 236, rad), 
    new cd(234, 236, rad), 
    new cd(320, 236, rad), 
    new cd(403, 234, rad), 
    new cd(487, 232, rad), 
    new cd(570, 233, rad), 
  }, 

  {
    new cd(59, 311, rad), 
    new cd(150, 311, rad), 
    new cd(234, 311, rad), 
    new cd(319, 310, rad), 
    new cd(407, 313, rad), 
    new cd(490, 309, rad), 
    new cd(575, 305, rad), 
  }, 

  {
    new cd(56, 392, rad), 
    new cd(144, 392, rad), 
    new cd(232, 388, rad), 
    new cd(320, 390, rad), 
    new cd(405, 387, rad), 
    new cd(492, 387, rad), 
    new cd(580, 386, rad)
  }, 



  {
    new cd(52, 462, rad), 
    new cd(145, 465, rad), 
    new cd(234, 462, rad), 
    new cd(320, 460, rad), 
    new cd(408, 462, rad), 
    new cd(495, 461, rad), 
    new cd(586, 460, rad)
}};

int s = 1;

void setup() {
  size(640, 480);
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      print("#");
      print(board[i][j].x);
      print(",");
      print(board[i][j].y);
    }
  }
  print("#");

  //cPort = new Serial(this, "COM4", 9600);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    //exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    
    //cam = new Capture(this, cameras[0]);
    //cam.start();
    
    
  }
  delay(3000);
}

void draw() {
  frameRate(60);
  background(255);
  
  
  //if (cam.available()) {
  //  cam.read();
  //}
  
  
  //image(cam.get(0, 0, cam.width, 50), 0, 0);
  //filter(ERODE);
  //filter(THRESHOLD);
  //image(cam.get(0, 49, cam.width, cam.height - 50), 0, 49);
  
  
  //image(cam, 0, 0);
  
  
  filter(GRAY);
  if (filterOn) {
    filterBlock();
    //tint(255,255,0, 128);
    //cd coldet = new cd(mouseX, mouseY, 10);
    //coldet.setRaduis(s);
    //coldet.print(mouseX, mouseY);
    //coldet.render(mouseX, mouseY);
    //background(255);
    for (int i = 0; i < 6; i ++) {
      for (int j = 0; j < 7; j ++) {
        board[i][j].setColor(board[i][j].getAvgColor());
      }
    }
    background(255);
    for (int i = 0; i < 6; i ++) {
      for (int j = 0; j < 7; j ++) {
        board[i][j].renderByCellColor();
      }
    }
    for (circle c : circles) {
      c.c = get(c.x, c.y);
      fill(c.c);
      c.render();
      c.printColor();
    }
  }

  //cd test = new cd(mouseX, mouseY, 10);
  //test.render(mouseX, mouseY);

  //println(red(get(p.x, p.y)), green(get(p.x, p.y)), blue(get(p.x, p.y)));
  if (red(get(p.x, p.y)) <= 50 && green(get(p.x, p.y)) <= 50 && blue(get(p.x, p.y)) >= 120) {
    println("found it");
    if (!found) {
      found = !found; 
      //cPort.write('s');
    }
  }
  //showGraphics();
}

void keyPressed() {
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      println(colorDiff(board[i][j].getAvgColor(), red), colorDiff(board[i][j].getAvgColor(), yellow));
      if (colorDiff(board[i][j].getAvgColor(), red) < colorDiff(board[i][j].getAvgColor(), yellow)) {
        currBoard[i][j] = 2;
      } else {
        currBoard[i][j] = 1;
      }
    }
  }
  for (int i = 0; i < 6; i ++) {
    for (int j = 0; j < 7; j ++) {
      print(currBoard[i][j]);
    }
    println();
  }
  //circle c = new circle();
  //c.x = mouseX;
  //c.y = mouseY;
  //circles.add(c);
  if (keyCode == ENTER) {
    println(val / cnt);
  }
  if (keyCode == 32) {
    filterOn = !filterOn;
  }
  //cPort.write('b');
  //cPort.readStringUntil('\n'); //emmit func
}

void filterBlock() {
  filter(ERODE);
  filter(BLUR, 2);
  filter(POSTERIZE, 4);
}

void mouseWheel(MouseEvent e) {
  if (e.getCount() == 1 && s > 1)
    s -= e.getCount();
  else if (e.getCount() == -1)
    s -= e.getCount();
}

void mousePressed() {
  println("Captured");
  val += red(get(mouseX, mouseY));
  cnt ++;
}

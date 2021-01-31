//import processing.video.*;

//int[][] board = {{1, 1, 1, 0, 1, 2, 2},
//                 {1, 1, 1, 2, 1, 2, 2},
//                 {2, 1, 1, 0, 1, 2, 0},
//                 {1, 1, 1, 0, 1, 2, 2},
//                 {1, 2, 1, 1, 0, 1, 2},
//                 {1, 1, 1, 0, 1, 2, 0}
//};

Game game = new Game(0, 0, 100);

PShape shape;
//Capture cam;

void setup() {
  size(700, 600);
  //String[] cameras = Capture.list();

  //if (cameras.length == 0) {
  //  println("There are no cameras available for capture.");
  //  exit();
  //} else {
  //  println("Available cameras:");
  //  for (int i = 0; i < cameras.length; i++) {
  //    println(cameras[i]);
  //  }
  //  cam = new Capture(this, cameras[0]);
  //  cam.start();
  //}
  //game.board = board;
  //game.turn = Turn.Human.getState();
}

void draw() {
  background(255);
  game.renderGame();
}

void keyPressed() {
  if(game.turn == Turn.Human.getState()) {
    game.dropCoin(mouseX / 100, Cell.Red.getState());
    game.renderGame();
    game.turn = Turn.Bot.getState();
  }
}

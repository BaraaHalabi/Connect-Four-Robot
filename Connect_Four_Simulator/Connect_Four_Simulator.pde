import processing.video.*;

//int[][] board = {{1, 1, 1, 0, 1, 2, 2},
//                 {1, 1, 1, 2, 1, 2, 2},
//                 {2, 1, 1, 0, 1, 2, 0},
//                 {1, 1, 1, 0, 1, 2, 2},
//                 {1, 2, 1, 1, 0, 1, 2},
//                 {1, 1, 1, 0, 1, 2, 0}
//};

Game game = new Game(0, 0, 100);

PShape shape;
Capture cam;

void setup() {
  size(700, 600);
}

void draw() {
  background(255);
  game.run();
}

void mousePressed() {
  if(game.turn == Turn.Human.getState()) {
    game.dropCoin(mouseX / 100, Cell.Red.getState());
    game.renderGame();
    game.turn = Turn.Bot.getState();
  }
  if(!game.gameIsRunning && game.button.isPressed()) {
    game.clear();
    game.gameState = Ai.winner(game.board);
    game.gameIsRunning = true; 
  }
}

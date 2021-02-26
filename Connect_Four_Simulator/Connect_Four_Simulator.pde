//import processing.video.*;

Popup popup = new Popup(200, 200, 300, 200);

Game game = new Game(0, 0, 100);

//int boardd[][] = {{0,0,2,1,0,0,2},{0,0,1,1,0,0,1},{0,0,2,2,0,0,2},{0,0,1,1,1,0,2},{0,0,2,1,2,0,2},{0,1,1,2,2,0,1}};

//Capture cam;

void setup() {
  size(700, 600);
  popup.setButton(150, 150, 100, 50, "Restart", color(50, 105, 165), color(255));
  popup.setPopupColor(color(255));
  popup.setMessageColor(color(50, 105, 165));
}

void draw() {
  //background(255);
  game.run();
  game.renderGame();
  if (game.gameState == 3) {
    popup.setMessage("Draw");
    popup.render();
  } else if (game.gameState != 0) {
    popup.setMessage(((game.gameState == Cell.Red.getState()) ? "Red" : "Yellow") + " Wins!");
    popup.render();
  }
}

void mousePressed() {
  if (popup.button.isPressed() && !game.gameIsRunning) {
    game = new Game(0, 0, 100);
  }
  if (game.turn == Turn.Human.getState() && game.gameIsRunning) {
    game.dropCoin(mouseX / 100, Cell.Red.getState());
    game.renderGame();
  }
  game.renderGame();
}

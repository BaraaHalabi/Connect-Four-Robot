class SimApp extends PApplet {

  void settings() {
    size(700, 600);
  }

  void setup() {
    game = new Game(0, 0, 100);
    popup = new Popup(width/2, height/2, 300, 200, new Button(width/2, height/2 + 40, 100, 50, this), this);
    popup.button.setLabel("Restart", 20);
    popup.button.setButtonColor(color(50, 105, 165));
    popup.button.setLabelColor(color(255));
    popup.setPopupColor(color(255));
    popup.setMessageColor(color(50, 105, 165));
    surface.setTitle("Simulator");
  }

  void draw() {
    background(55);
    game.run(this);
    if (game.gameState == 3) {
      popup.setMessage("Draw", 20);
      popup.render();
    } else if (game.gameState != 0) {
      popup.setMessage(((game.gameState == Cell.Red.getState()) ? "Red" : "Yellow") + " Wins!", 20);
      popup.render();
    }
  }

  void mousePressed() {
    if (popup.button.isPressed() && !game.gameIsRunning) {
      game = new Game(0, 0, 100);
    }
    if (game.turn == Turn.Human.getState() && game.gameIsRunning) {
      game.dropCoin(mouseX / 100, Cell.Red.getState());
      game.renderGame(simApp);
    }
  }
}

class SimApp extends PApplet {
  
  boolean sent = false;
  int tar = -1, approvedFrames = 0;
  
  void settings() {
    size(700, 600);
  }

  void setup() {
    game = new Game(0, 0, 100, this);
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
    game.run();

    int des = game.aiPlay();
    if (des != -1) {
      port.write('c');
      delay(2000);
      port.write('s');
      tar = 7 - des - 1;
      println(tar);
    }
    boolean approved = false;
    if (tar != -1 && 200 - railCells[tar].getGrayValue() >= 100) {
      println(railCells[tar].getGrayValue());  
      //do something
      approvedFrames ++;
      approved = true;
      if(!sent && approvedFrames >= 5) {
        port.write('d');
        sent = true;
        approvedFrames = 0;
      }
    }
    if(!approved) {
      approvedFrames = 0; 
    }
    if(port.readChar() == 'e') {
      sent = false;
      tar = -1;
    }
    
    
    if (game.gameState == 3) {
      popup.setMessage("Draw", 20);
      popup.render();
    } else if (game.gameState != 0) {
      popup.setMessage(((game.gameState == Cell.Red.getState()) ? "Red" : "Yellow") + " Wins!", 20);
      popup.render();
    }
  }

  void keyPressed() {
    if (game.turn == Turn.Human.getState() && game.gameIsRunning && keyCode == 32) {
      for (int i = 0; i < 7; i ++) {
        if (game.coinsInColumns[i] <= 5) {
          if (200 - boardCells[5 - game.coinsInColumns[i]][i].getGrayValue() >= 100) {
            game.dropCoin(i, Cell.Red.getState());
            //break;
          }
        }
      }
      game.renderGame();
    }
  }

  void mousePressed() {
    if (popup.button.isPressed() && !game.gameIsRunning) {
      game = new Game(0, 0, 100, this);
    }
    //if (game.turn == Turn.Human.getState() && game.gameIsRunning) {
    //  game.dropCoin(mouseX / 100, Cell.Red.getState());
    //  game.renderGame();
    //}
  }
}

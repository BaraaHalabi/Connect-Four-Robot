class Game {
  int board[][] = new int[6][7];
  int coinsInColumns[] = new int[7];
  int x, y, c;
  int turn = Turn.Bot.getState(), gameState;
  boolean gameIsRunning;
  
  
  Button button;

  Game() {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    x = 0;
    y = 0;
    c = 50;
    gameIsRunning = true;
    gameState = Ai.winner(board);
  }

  Game(int x, int y, int c) {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    this.x = x;
    this.y = y;
    this.c = c;
    gameIsRunning = true;
    gameState = Ai.winner(board);
  }

  void run() {
    renderGame();
    gameState = Ai.winner(board);
    if (gameState != 0)
      gameIsRunning = false;
    aiPlay();
    renderWinnerScreen(gameState);
  }

  void renderGame() {
    noStroke();
    rectMode(CORNER);
    ellipseMode(CORNER);
    int py = y;
    for (int i = 0; i < 6; i ++) {
      int px = x;
      for (int j = 0; j < 7; j ++) {
        fill(50, 105, 165);
        rect(px, py, c, c);
        if (board[i][j] == Cell.Yellow.getState())
          fill(230, 215, 5);
        else if (board[i][j] == Cell.Red.getState())
          fill(225, 65, 15); 
        else
          fill(255); 
        ellipse(px + 2, py + 2, c - 4, c - 4);
        px += c;
      }
      py += c;
    }
    renderDropArea();
  }

  void aiPlay() {
    if (turn == Turn.Bot.getState() && gameIsRunning) {
      game.dropCoin(Ai.decisionMaking(0, true, board, coinsInColumns), Cell.Yellow.getState());
      turn = Turn.Human.getState();
    }
  }

  void renderWinnerScreen(int gameState) {
    if (!gameIsRunning) {
      filter(BLUR, 5);
      fill(255, 128);
      rect(0, 200, width, 200);
      fill(0);
      String label = ((gameState == Cell.Red.getState()) ? "Red" : "Yellow") + " Wins!";
      textSize(24);
      textAlign(CORNER);
      button = new Button(350, 325, 150, 50);
      if(gameState == Cell.Red.getState())
        fill(225, 65, 15);
      else
        fill(255, 255, 0);
      text(label, width / 2  - textWidth(label) / 2, 250);
      button.setButtonColor(color(50, 105, 165));
      button.setLabelColor(color(255, 255, 255));
      button.setLabel("Reset", 24);
      button.render();
    }
  }

  void dropCoin(int column, int coin) {
    for (int i = 5; i >= 0; i --) {
      if (board[i][column] == Cell.Empty.getState()) {
        board[i][column] = coin;
        break;
      }
    }
    if (coinsInColumns[column] < 6)
      coinsInColumns[column] ++;
  }

  void renderDropArea() {
    if (turn == Turn.Human.getState() && gameIsRunning) {
      fill(255, 255, 255, 100);
      rect((mouseX / c) * c, 0, c, 6 * c);
    }
  }

  void printBoard() {
    for (int i = 0; i < 6; i ++) {
      for (int j = 0; j < 7; j ++) {
        print(board[i][j] + " ");
      }
      println();
    }
    println();
    println();
  }

  void clear() {
    for (int i = 0; i < 6; i ++) {
      coinsInColumns[i] = 0;
      for (int j = 0; j < 7; j ++) {
        board[i][j] = Cell.Empty.getState();
      }
    }
  }
}

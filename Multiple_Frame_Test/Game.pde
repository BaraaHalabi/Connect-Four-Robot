class Game {
  int board[][] = new int[6][7];
  int coinsInColumns[] = new int[7];
  int x, y, c;
  int turn, gameState, coins;
  PApplet applet;
  boolean gameIsRunning;

  Game(PApplet applet) {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    x = 0;
    y = 0;
    c = 50;
    this.applet = applet;
    gameIsRunning = true;
    gameState = Ai.winner(board);
    turn = Turn.Bot.getState();
    coins = 0;
  }

  Game(int x, int y, int c, PApplet applet) {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    this.x = x;
    this.y = y;
    this.c = c;
    gameIsRunning = true;
    this.applet = applet;
    gameState = Ai.winner(board);
    turn = Turn.Bot.getState();
    coins = 0;
  }

  void run() {
    renderGame();
    gameState = Ai.winner(board);
    if(coins == 42 && gameState == 0) {
      gameState = 3;
      gameIsRunning = false;
    }
    if (gameState != 0)
      gameIsRunning = false;
  }

  void renderGame() {
    applet.noStroke();
    applet.rectMode(CORNER);
    applet.ellipseMode(CORNER);
    int py = y;
    for (int i = 0; i < 6; i ++) {
      int px = x;
      for (int j = 0; j < 7; j ++) {
        applet.fill(50, 105, 165);
        applet.rect(px, py, c, c);
        if (board[i][j] == Cell.Yellow.getState())
          applet.fill(230, 215, 5);
        else if (board[i][j] == Cell.Red.getState())
          applet.fill(225, 65, 15); 
        else
          applet.fill(255); 
        applet.ellipse(px + 2, py + 2, c - 4, c - 4);
        px += c;
      }
      py += c;
    }
    //renderDropArea();
  }

  int aiPlay() {
    if (turn == Turn.Bot.getState() && gameIsRunning) {
      int dicision = Ai.decisionMaking(0, true, board, coinsInColumns);
      game.dropCoin(dicision, Cell.Yellow.getState());
      return dicision;
    }
    return -1;
  }

  void dropCoin(int column, int coin) {
    if (coinsInColumns[column] < 6) {
      for (int i = 5; i >= 0; i --) {
        if (board[i][column] == Cell.Empty.getState()) {
          board[i][column] = coin;
          break;
        }
      }
      if(turn == Turn.Human.getState())
        turn = Turn.Bot.getState();
      else
        turn = Turn.Human.getState();
      coinsInColumns[column] ++;
      coins ++;
    }
  }

  void renderDropArea() {
    if (turn == Turn.Human.getState() && gameIsRunning) {
      applet.fill(255, 255, 255, 100);
      applet.rect((applet.mouseX / c) * c, 0, c, 6 * c);
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

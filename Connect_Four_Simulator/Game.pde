class Game {
  int board[][] = new int[6][7]; //{{0,0,2,1,0,0,2},{0,0,1,1,0,0,1},{0,0,2,2,0,0,2},{0,0,1,1,1,0,2},{0,0,2,1,2,0,2},{0,1,1,2,2,0,1}};;
  int coinsInColumns[] = new int[7];
  int x, y, c;
  int turn, gameState, coins;
  boolean gameIsRunning;
  
  int numberOfTurns = 0;

  Game() {
    /*for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;*/
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    x = 0;
    y = 0;
    c = 50;
    gameIsRunning = true;
    gameState = Ai.winner(board);
    turn = Turn.Bot.getState();
    coins = 0;
  }

  Game(int x, int y, int c) {
    for (int i = 0; i < 6; i ++)
    {
      for (int j = 0; j < 7; j ++)
          //print(board[i][j]);
          board[i][j] = 0;
      //println();    
    }
    for (int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    /*coinsInColumns[0] = 0;
    coinsInColumns[1] = 1;
    coinsInColumns[2] = 6;
    coinsInColumns[3] = 6;
    coinsInColumns[4] = 3;
    coinsInColumns[5] = 0;
    coinsInColumns[6] = 6;*/
    this.x = x;
    this.y = y;
    this.c = c;
    gameIsRunning = true;
    gameState = Ai.winner(board);
    turn = Turn.Bot.getState();
    coins = 0;
    //coins = 22;
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
    aiPlay();
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
    if (turn == Turn.Bot.getState() && gameIsRunning)
    {
      //numberOfTurns++;
      int aiDecision = Ai.decisionMaking(0, true, board, coinsInColumns);
      //println(aiDecision , numberOfTurns);
      game.dropCoin(aiDecision, Cell.Yellow.getState());
    }
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
    /*for (int i = 0; i < 6; i ++)
    {
      for (int j = 0; j < 7; j ++)
          print(board[i][j]);
      println();    
    }*/
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

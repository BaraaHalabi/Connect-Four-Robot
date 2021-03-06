static class Ai {
  static int winingValue = Cell.Yellow.getState();
  static int loseValue = Cell.Red.getState();

  static int decisionMaking(int depth, boolean yellowTurn, int board[][], int coinsInColumns[]) {
    if(depth == 4) {
    for(int i = 0; i < 6; i ++) {
      for(int j = 0; j < 7; j ++) {
        print(board[i][j] + " "); 
      }
      println();
    }
    }
    println();
    println();
    if (depth >= 5)
      return 0;
    int gameState = winner(board);
    if (gameState == winingValue)
      return 100 / depth;
    else if (gameState == loseValue)
      return -100 / depth;
    int maxPoint = -1000000, bestCol = 0, totalPoint = 0;
    for (int i = 0; i < 7; i ++) {
      if (board[0][i] == 0) {
        if(yellowTurn)
          board[5 - coinsInColumns[i]][i] = winingValue;
        else
          board[5 - coinsInColumns[i]][i] = loseValue;
        int choice = decisionMaking(depth + 1, !yellowTurn, board, coinsInColumns);
        //print(choice + " ");
        board[5 - coinsInColumns[i]][i] = 0;
        if (choice >= maxPoint) {
          maxPoint = choice;
          bestCol = i;
          totalPoint += choice;
        }
      }
    }
    //println();
    if (depth == 0)
      return bestCol;
    else
      return totalPoint;
  }

  static int winner(int board[][]) {
    for (int i = 0; i < 6; i ++) {
      for (int j = 0; j < 7; j ++) {
        if (i >= 0 && i < 6 && j >= 0 && j < 4 && equal(board[i][j], board[i][j + 1], board[i][j + 2], board[i][j + 3]))
          return board[i][j];
        if (i >= 0 && i < 6 && j >= 3 && j < 7 && equal(board[i][j], board[i][j - 1], board[i][j - 2], board[i][j - 3]))
          return board[i][j];
        if (i >= 0 && i < 3 && j >= 0 && j < 7 && equal(board[i][j], board[i + 1][j], board[i + 2][j], board[i + 3][j]))
          return board[i][j];
        if (i >= 3 && i < 6 && j >= 0 && j < 7 && equal(board[i][j], board[i - 1][j], board[i - 2][j], board[i - 3][j]))
          return board[i][j];
        if (i >= 0 && i < 3 && j >= 0 && j < 4 && equal(board[i][j], board[i + 1][j + 1], board[i + 2][j + 2], board[i + 3][j + 3]))
          return board[i][j];
        if (i >= 0 && i < 3 && j >= 3 && j < 7 && equal(board[i][j], board[i + 1][j - 1], board[i + 2][j - 2], board[i + 3][j - 3]))
          return board[i][j];
        if (i >= 3 && i < 6 && j >= 4 && j < 7 && equal(board[i][j], board[i - 1][j - 1], board[i - 2][j - 2], board[i - 3][j - 3]))
          return board[i][j];
        if (i >= 3 && i < 6 && j >= 0 && j < 4 && equal(board[i][j], board[i - 1][j + 1], board[i - 2][j + 2], board[i - 3][j + 3]))
          return board[i][j];
      }
    }
    return 0;
  }


  static boolean equal(int a, int b, int c, int d) {
    if (a == b && b == c && c == d && a != 0)
      return true;
    return false;
  }
}

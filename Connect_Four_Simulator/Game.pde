public enum Cell {
  Empty(0), Red(1), Yellow(2);
  int state;

  private Cell(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

public enum Turn {
  Bot(0), Human(1);
  int state;

  private Turn(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

public enum Shape {
  Rect(0), Eclipse(1);
  int state;

  private Shape(int state) {
    this.state = state;
  }

  int getState() {
    return this.state;
  }
}

class Game {
  int board[][] = new int[6][7];
  int coinsInColumns[] = new int[7];
  int x, y, c;
  int turn = Turn.Bot.getState();

  Game() {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for(int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    x = 0;
    y = 0;
    c = 50;
  }

  Game(int x, int y, int c) {
    for (int i = 0; i < 6; i ++)
      for (int j = 0; j < 7; j ++)
        board[i][j] = 0;
    for(int i = 0; i < 7; i ++)
      coinsInColumns[i] = 0;
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void renderGame() {
    noStroke();
    //rectMode(CORNER);
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
    if(Ai.winner(board) != 0) {
       println(Ai.winner(board));
       noLoop();
    }
    if (turn == Turn.Bot.getState()) {
      game.dropCoin(Ai.decisionMaking(0, true, board, coinsInColumns), Cell.Yellow.getState());
      turn = Turn.Human.getState();
    }
  }

  void dropCoin(int column, int coin) {
    for (int i = 5; i >= 0; i --) {
      if (board[i][column] == Cell.Empty.getState()) {
        board[i][column] = coin;
        break;
      }
    }
    if(coinsInColumns[column] < 6)
      coinsInColumns[column] ++;
  }

  void renderDropArea() {
    if (turn == Turn.Human.getState()) {
      fill(255, 255, 255, 100);
      rect((mouseX / c) * c, 0, c, 6 * c);
    }
  }
}

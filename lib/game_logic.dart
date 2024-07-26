import 'dart:math';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
  static List<int> playerx = [];
  static List<int> playero = [];
}

extension Containall on List {
  bool containall(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    }
    return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playgame(int index, String activeplayer) {
    if (activeplayer == "X")
      Player.playerx.add(index);
    else
      Player.playero.add(index);
  }

  String checkwinner() {
    String winner = '';
    bool gameover = false;
    if (Player.playerx.containall(0, 1, 2) ||
        Player.playerx.containall(3, 4, 5) ||
        Player.playerx.containall(6, 7, 8) ||
        Player.playerx.containall(0, 3, 6) ||
        Player.playerx.containall(1, 4, 7) ||
        Player.playerx.containall(2, 5, 8) ||
        Player.playerx.containall(0, 4, 8) ||
        Player.playerx.containall(2, 4, 6))
      winner = 'X';
    else if (Player.playerx.containall(0, 1, 2) ||
        Player.playero.containall(3, 4, 5) ||
        Player.playero.containall(6, 7, 8) ||
        Player.playero.containall(0, 3, 6) ||
        Player.playero.containall(1, 4, 7) ||
        Player.playero.containall(2, 5, 8) ||
        Player.playero.containall(0, 4, 8) ||
        Player.playero.containall(2, 4, 6))
      winner = 'O';
    else {
      winner = '';
    }

    return winner;
  }

  Future<void> autoplay(activeplayer) async {
    int index = 0;
    List<int> emptycells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerx.contains(i) || Player.playero.contains(i))) {
        emptycells.add(i);
      }
    }
    if (Player.playerx.containall(0, 1) && emptycells.contains(2))
      index = 2;
    else if (Player.playerx.containall(3, 4) && emptycells.contains(5))
      index = 5;
    else if (Player.playerx.containall(6, 7) && emptycells.contains(8))
      index = 8;
    else if (Player.playerx.containall(0, 3) && emptycells.contains(6))
      index = 6;
    else if (Player.playerx.containall(1, 4) && emptycells.contains(7))
      index = 7;
    else if (Player.playerx.containall(2, 5) && emptycells.contains(8))
      index = 8;
    else if (Player.playerx.containall(0, 4) && emptycells.contains(8))
      index = 8;
    else if (Player.playerx.containall(2, 4) && emptycells.contains(6))
      index = 6;
    else {
      Random random = Random();
      int randomindex = random.nextInt(emptycells.length);
      index = emptycells[randomindex];
    }

    playgame(index, activeplayer);
  }
}

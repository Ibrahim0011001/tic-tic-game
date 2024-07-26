import 'package:flutter/material.dart';

import 'game_logic.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String activeplayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isswitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text(
                'Turn on/off tow player',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              value: isswitched,
              onChanged: (bool value) {
                setState(() {
                  isswitched = value;
                });
              },
            ),
            Text(
              'it\'s $activeplayer turn'.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.0,
                    children: List.generate(
                      9,
                      (index) => InkWell(
                        onTap: gameOver ? null : () => _ontap(index),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Text(
                              Player.playerx.contains(index)
                                  ? 'X'
                                  : Player.playero.contains(index)
                                      ? 'O'
                                      : '',
                              style: TextStyle(
                                  color: Player.playerx.contains(index)
                                      ? Colors.blue
                                      : Colors.pink,
                                  fontSize: 52),
                            ),
                          ),
                        ),
                      ),
                    ))),
            Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playerx = [];
                  Player.playero = [];

                  activeplayer = 'X';
                  gameOver = false;
                  turn = 0;
                  result = '';
                });
              },
              label: Text('Repeat the game'),
              icon: Icon(Icons.replay),
            )
          ],
        ),
      ),
    );
  }

  _ontap(int index) async {
    if (Player.playerx.isEmpty ||
        !Player.playerx.contains(index) && Player.playero.isEmpty ||
        !Player.playero.contains(index)) {
      game.playgame(index, activeplayer);

      updatestate();
      if (!isswitched && !gameOver && turn != 9) {
        await game.autoplay(activeplayer);
        updatestate();
      }
    }
  }

  void updatestate() {
    return setState(() {
      activeplayer = (activeplayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerplayer = game.checkwinner();
      if (winnerplayer != '') {
        gameOver = true;
        result = '$winnerplayer is the winner';
      } else if (!gameOver && turn == 9) result = 'it\'s draw';
    });
  }
}

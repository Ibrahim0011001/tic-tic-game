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
  String result = 'XXXXX';
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
                              "X",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 52),
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

  _ontap(int index) {
    game.playgame(index, activeplayer);
  }
}

import 'package:flutter/material.dart';

class DialogUtil {
  static Future<void> winnerDialog(BuildContext context, String winner) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('We have a winner!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('$winner won the game!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Play again!'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> helpDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to play!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text(
                  'First, you need to select a board to play. The board is composed of 64 tiles, each with a terrain. This terrain influences your machine\'s attack. ',
                ),
                Text(
                  'After that, you will be redirect to a page where the board and machines are all layed out.',
                ),
                Text(
                  'Each player, has a given number of machines, each with a set of health points, movement range, attack points, victory points, etc.',
                ),
                Text(
                  'To attack a enemy, you need first to get close enough to it. You can follow the instructions for each key under Controls Info.',
                ),
                Text(
                  'If you attack a machine with attack points lower than yours, will will apply your damage to the other machine',
                ),
                Text(
                  'On the other hand, if the enemy machine has a great combat point value, you will get hit. And if both are equal, both machines receive 1 attack damage.',
                ),
                Text(
                  'Terrain also influences the machines attack, each terrain has it\'s own combat power offset that can be seen under the Terrain Info.',
                ),
                Text(
                  'If a machine dies, the player who killed receives the dead\'s machine victory points',
                ),
                Text(
                  'Wins the first player to get 7 victory points, or kill the entire enemy team.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

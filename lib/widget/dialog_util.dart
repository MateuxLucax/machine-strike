import 'package:flutter/material.dart';

class DialogUtil {
  static Future<void> showWinnerDialog(BuildContext context, String winner) async {
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
}

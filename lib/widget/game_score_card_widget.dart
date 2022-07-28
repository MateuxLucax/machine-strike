import 'package:flutter/material.dart';

import '../design_patterns/state/game/game.dart';
import 'info_text_widget.dart';

class GameScoreWidget extends StatelessWidget {
  final Game game;
  const GameScoreWidget(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTextWidget(
              description: 'Turn: ',
              value: game.turn.toString(),
            ),
            const SizedBox(height: 12),
            InfoTextWidget(
              description: 'Current player: ',
              value: game.player.toString(),
            ),
            InfoTextWidget(
              description: 'Player score: ',
              value: game.getVictoryPoints().toString(),
            ),
          ],
        ),
      ),
    );
  }
}

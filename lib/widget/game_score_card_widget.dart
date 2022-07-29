import 'package:flutter/material.dart';

import '../design_patterns/state/game/game.dart';
import '../exceptions/game_finished_exception.dart';
import 'dialog_util.dart';
import 'info_text_widget.dart';

class GameScoreWidget extends StatelessWidget {
  final Game game;
  const GameScoreWidget(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoTextWidget(
                'Turn: ',
                game.turn.toString(),
              ),
              const SizedBox(height: 12),
              InfoTextWidget(
                'Current player: ',
                game.player.toString(),
              ),
              InfoTextWidget(
                'Player score: ',
                game.getVictoryPoints().toString(),
              ),
            ],
          ),
        ),
      );
    } on GameFinishedException catch (e) {
      Future.delayed(Duration.zero, () {
        DialogUtil.winnerDialog(
          context,
          e.winner.toString(),
        );
      });

      return Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoTextWidget(
                'Turn: ',
                game.turn.toString(),
              ),
              const SizedBox(height: 12),
              InfoTextWidget(
                'Current player: ',
                e.winner.toString(),
              ),
              InfoTextWidget(
                'Player score: ',
                game.victoryPoints[e.winner].toString(),
              ),
            ],
          ),
        ),
      );
    }
  }
}

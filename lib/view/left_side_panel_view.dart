import 'package:flutter/material.dart';

import '../controller/game_controller.dart';
import '../design_patterns/observer/events/game_event.dart';
import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../design_patterns/state/game/game.dart';
import '../widget/dialog_util.dart';
import '../widget/game_controls_widget.dart';
import '../widget/game_score_card_widget.dart';

class LeftSidePanelView extends StatefulWidget {
  final IGameController controller;
  const LeftSidePanelView(this.controller, {Key? key}) : super(key: key);

  @override
  State<LeftSidePanelView> createState() => _LeftSidePanelViewState();
}

class _LeftSidePanelViewState extends State<LeftSidePanelView> implements Observer {
  Game? observedGame;

  @override
  void initState() {
    super.initState();
    widget.controller.attach(this);
    observedGame = widget.controller.currentGame;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final game = observedGame;

    if (game != null) {
      final winner = game.winner;

      if (winner != null) {
        Future.delayed(Duration.zero, () {
          DialogUtil.showWinnerDialog(
            context,
            winner.toString(),
          );
        });
      }
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: theme.colorScheme.secondary,
        ),
        width: 256,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Info',
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontSize: theme.textTheme.headline6?.fontSize,
                ),
              ),
              if (game != null) GameScoreWidget(game),
              const SizedBox(height: 12),
              Text(
                'Game Controls',
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontSize: theme.textTheme.headline6?.fontSize,
                ),
              ),
              const GameControlsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void update(ObserverEvent event) {
    if (event is GameEvent) {
      setState(() {
        observedGame = event.game;
      });
    }
  }
}

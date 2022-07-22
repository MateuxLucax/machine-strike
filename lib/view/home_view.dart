import 'package:flutter/material.dart';

import '../controller/board_controller.dart';
import '../design_patterns/builder/game.dart';
import 'board_view.dart';
import 'machine_sidepanel_view.dart';

class HomeView extends StatelessWidget {
  final Game game;
  const HomeView(
    this.game, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final boardController = BoardController(game.board);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Strike'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_sharp),
            tooltip: 'How to play',
            onPressed: () {
              debugPrint('I need help');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Column(
            children: const [
              // Text('test'),
            ],
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoardView(boardController),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            children: [
              MachineSidePanelView(boardController),
            ],
          ),
        ],
      ),
    );
  }
}

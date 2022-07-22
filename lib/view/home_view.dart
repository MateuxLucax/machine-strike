import 'package:flutter/material.dart';

import '../controller/board_controller.dart';
import '../controller/iboard_controller.dart';
import '../design_patterns/builder/game.dart';
import 'board_view.dart';
import 'right_sidepanel_view.dart';

class HomeView extends StatelessWidget {
  final Game game;
  const HomeView(
    this.game, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IBoardController boardController = BoardController(game.board);

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoardView(boardController),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            children: [
              RightSidePanelView(boardController),
            ],
          ),
        ],
      ),
    );
  }
}

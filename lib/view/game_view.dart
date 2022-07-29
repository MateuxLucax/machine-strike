import 'package:flutter/material.dart';

import '../controller/game_controller.dart';
import '../controller/igame_controller.dart';
import '../model/board.dart';
import 'board_view.dart';
import 'left_side_panel_view.dart';
import 'right_side_panel_view.dart';

class GameView extends StatelessWidget {
  final Board board;
  const GameView(
    this.board, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IGameController controller = GameController(board);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Strike'),
        automaticallyImplyLeading: false,
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
            children: [
              LeftSidePanelView(controller),
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
                  BoardView(controller),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            children: [
              RightSidePanelView(controller),
            ],
          ),
        ],
      ),
    );
  }
}

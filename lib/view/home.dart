import 'package:flutter/material.dart';

import '../design_patterns/builder/game.dart';
import 'board_view.dart';

class HomeView extends StatelessWidget {
  final Game game;
  const HomeView(
    this.game, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                BoardView(
                  board: game.board,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            children: const [
              // Text('test'),
            ],
          ),
        ],
      ),
    );
  }
}

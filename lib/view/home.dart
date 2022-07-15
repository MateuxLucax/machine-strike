import 'package:flutter/material.dart';
import 'package:machinestrike/enum/direction.dart';
import 'package:machinestrike/view/board.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTile = 4;
  Direction tileDirection = Direction.north;

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
                  selectedTile: selectedTile,
                  tileDirection: tileDirection,
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

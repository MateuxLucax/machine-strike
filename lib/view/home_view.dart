import 'package:flutter/material.dart';

import '../design_patterns/builder/builders/standard_game_builder.dart';
import '../design_patterns/builder/game.dart';
import '../design_patterns/singleton/boards.dart';
import '../design_patterns/singleton/machines.dart';
import '../enum/player.dart';
import 'game_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
    padding: MaterialStateProperty.all(const EdgeInsets.all(24)),
    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 24)),
  );

  void _onPressed() {
    Game game = StandardGameBuilder()
        .setBoard(Boards().random())
        .setInitialPlayer(Player.one)
        .addMachine(Machines().get(0))
        .addMachine(Machines().get(1))
        .addMachine(Machines().get(2))
        .addMachine(Machines().get(3))
        .addMachine(Machines().get(4))
        .addMachine(Machines().get(5))
        .addMachine(Machines().get(6))
        .addMachine(Machines().get(7))
        .build();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameView(game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), _onPressed);

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
          const SizedBox(
            width: 24,
          ),
          SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(24)),
                        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 24)),
                      ),
                      onPressed: _onPressed,
                      child: const Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}

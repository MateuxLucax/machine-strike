import 'package:flutter/material.dart';

import 'config/machines.dart';
import 'design_patterns/adapter/adapters/json_tiles_adapter.dart';
import 'design_patterns/builder/builders/standard_game_builder.dart';
import 'design_patterns/builder/game.dart';
import 'design_patterns/singleton/boards.dart';
import 'view/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boards().loadBoards(JsonTilesAdapter());

  Game game = StandardGameBuilder()
      .addMachine(Machines.bristleback, 2, 4)
      .addMachine(Machines.burrower, 0, 2)
      .addMachine(Machines.grazer, 1, 7)
      .addMachine(Machines.charger, 6, 3)
      .addMachine(Machines.lancehorn, 7, 5)
      .addMachine(Machines.longleg, 5, 1)
      .build();

  runApp(MachineStrikeApp(game));
}

class MachineStrikeApp extends StatelessWidget {
  final Game game;
  const MachineStrikeApp(
    this.game, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Strike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: HomeView(game),
    );
  }
}

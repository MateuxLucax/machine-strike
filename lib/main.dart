import 'package:flutter/material.dart';
import 'package:machinestrike/design_patterns/abstract_factory/factories/burrower.dart';
import 'package:machinestrike/design_patterns/abstract_factory/factories/charger.dart';
import 'package:machinestrike/design_patterns/abstract_factory/factories/grazer.dart';
import 'package:machinestrike/design_patterns/abstract_factory/factories/lancehorn.dart';
import 'package:machinestrike/design_patterns/abstract_factory/factories/longleg.dart';

import 'design_patterns/abstract_factory/factories/bristleback.dart';
import 'design_patterns/adapter/adapters/json_tiles_adapter.dart';
import 'design_patterns/builder/builders/standard_game_builder.dart';
import 'design_patterns/builder/game.dart';
import 'design_patterns/singleton/boards.dart';
import 'enum/player.dart';
import 'view/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boards().loadBoards(JsonTilesAdapter());

  Game game = StandardGameBuilder()
      .addMachine(Bristleback(Player.one, 2, 4))
      .addMachine(Burrower(Player.one, 0, 2))
      .addMachine(Grazer(Player.one, 1, 7))
      .addMachine(Charger(Player.two, 6, 3))
      .addMachine(Lancehorn(Player.two, 7, 5))
      .addMachine(Longleg(Player.two, 5, 1))
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

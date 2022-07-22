import 'package:flutter/material.dart';

import 'design_patterns/abstract_factory/factories/bristleback.dart';
import 'design_patterns/abstract_factory/factories/burrower.dart';
import 'design_patterns/abstract_factory/factories/charger.dart';
import 'design_patterns/abstract_factory/factories/grazer.dart';
import 'design_patterns/abstract_factory/factories/lancehorn.dart';
import 'design_patterns/abstract_factory/factories/longleg.dart';
import 'design_patterns/abstract_factory/factories/plowhorn.dart';
import 'design_patterns/abstract_factory/factories/skydrifter.dart';
import 'design_patterns/builder/builders/standard_game_builder.dart';
import 'design_patterns/builder/game.dart';
import 'design_patterns/singleton/boards.dart';
import 'enum/player.dart';
import 'view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boards().loadBoards();

  Game game = StandardGameBuilder()
      .setBoard(Boards().random())
      .setInitialPlayer(Player.one)
      .addMachine(Plowhorn(Player.one, 1, 0))
      .addMachine(Bristleback(Player.one, 2, 4))
      .addMachine(Burrower(Player.one, 0, 2))
      .addMachine(Grazer(Player.one, 1, 7))
      .addMachine(Charger(Player.two, 6, 3))
      .addMachine(Skydrifter(Player.two, 6, 7))
      .addMachine(Lancehorn(Player.two, 7, 5))
      .addMachine(Longleg(Player.two, 5, 1))
      .build();

  // TODO: add game to state

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
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeView(game),
    );
  }
}

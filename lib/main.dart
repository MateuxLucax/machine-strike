import 'package:flutter/material.dart';

import 'design_patterns/singleton/boards.dart';
import 'design_patterns/singleton/machines.dart';
import 'view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boards().loadBoards();
  await Machines().loadMachines();

  runApp(const MachineStrikeApp());
}

class MachineStrikeApp extends StatelessWidget {
  const MachineStrikeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Strike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomeView(),
    );
  }
}

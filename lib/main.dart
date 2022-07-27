import 'package:flutter/material.dart';

import 'app.dart';
import 'design_patterns/singleton/boards.dart';
import 'design_patterns/singleton/machines.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boards().loadBoards();
  await Machines().loadMachines();

  runApp(const MachineStrikeApp());
}

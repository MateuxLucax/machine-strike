import 'package:flutter/foundation.dart';

import '../../../model/machine.dart';
import '../command.dart';

abstract class MachineCommand implements Command {
  final Machine machine;

  MachineCommand(this.machine);

  @override
  void redo() {
    debugPrint('Can\'t redo this command');
  }

  @override
  void undo() {
    debugPrint('Can\'t undo this command');
  }
}

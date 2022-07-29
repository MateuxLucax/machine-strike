import 'package:machinestrike/model/machine.dart';

import '../command.dart';

abstract class MachineCommand implements Command {
  final Machine machine;

  MachineCommand(this.machine);

  @override
  void redo() {
    // Nothing to do here
  }

  @override
  void undo() {
    // Nothing to do here
  }
}

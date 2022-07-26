import '../../model/machine.dart';

abstract class IMachineAdapter {
  Future<Machine> getMachine(String file);
}

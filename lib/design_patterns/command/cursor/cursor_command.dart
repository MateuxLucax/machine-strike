import '../command.dart';

abstract class CursorCommand implements Command {
  @override
  void redo() {
    execute();
  }
}

import '../../singleton/cursor.dart';
import 'cursor_command.dart';

class CursorLeftCommand extends CursorCommand {
  @override
  void execute() {
    Cursor().position.move(col: -1);
  }

  @override
  void undo() {
    Cursor().position.move(col: 1);
  }
}

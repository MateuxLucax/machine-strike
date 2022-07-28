import '../../singleton/cursor.dart';
import 'cursor_command.dart';

class CursorDownCommand extends CursorCommand {
  @override
  void execute() {
    Cursor().position.move(row: 1);
  }

  @override
  void undo() {
    Cursor().position.move(row: -1);
  }
}

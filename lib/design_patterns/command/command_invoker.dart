import '../../utils/stack.dart';
import 'command.dart';

class CommandInvoker {
  final Stack<Command> _undo = Stack<Command>(20);
  final Stack<Command> _redo = Stack<Command>(20);

  void execute(Command command) {
    _undo.push(command);
    _redo.clear();
    command.execute();
  }

  void undo() {
    if (_undo.isNotEmpty) {
      Command command = _undo.pop();
      command.undo();
      _redo.push(command);
    }
  }

  void redo() {
    Command command = _redo.pop();
    command.execute();
    _undo.push(command);
  }

  void clear() {
    _undo.clear();
    _redo.clear();
  }
}

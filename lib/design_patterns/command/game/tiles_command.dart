import '../../state/game/game.dart';
import '../command.dart';

abstract class GameCommand implements Command {
  final Game game;

  GameCommand(this.game);

  @override
  void redo() {
    // Nothing to do here
  }

  @override
  void undo() {
    // Nothing to do here
  }
}

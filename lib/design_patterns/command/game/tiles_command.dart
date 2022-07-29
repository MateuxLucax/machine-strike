import 'package:flutter/foundation.dart';

import '../../state/game/game.dart';
import '../command.dart';

abstract class GameCommand implements Command {
  final Game game;

  GameCommand(this.game);

  @override
  void redo() {
    debugPrint('Can\'t redo this command');
  }

  @override
  void undo() {
    debugPrint('Can\'t undo this command');
  }
}

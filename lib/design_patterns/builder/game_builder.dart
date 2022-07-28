import 'package:flutter/widgets.dart';

import '../../model/board.dart';
import '../../model/machine.dart';

abstract class GameBuilder {
  @protected
  Board board;

  GameBuilder(this.board);

  Board getBoard() => board;

  GameBuilder addMachine(Machine machine);
  Board build();
}

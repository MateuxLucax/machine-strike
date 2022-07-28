import '../../../enum/player.dart';
import '../../../model/board.dart';
import '../../../model/machine.dart';
import '../../decorator/tile/add_widget_on_stack_decorator.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  final Map<Player, int> remainingMachines = {
    Player.one: 4,
    Player.two: 4,
  };

  StandardGameBuilder(super.board);

  @override
  GameBuilder addMachine(Machine machine) {
    final remaining = remainingMachines[machine.player];

    if (remaining != null && remaining > 0) {
      final x = machine.position.row;
      final y = machine.position.col;
      board.tiles[x][y] = board.tiles[x][y].copyWith(
        machine: machine,
        tileStack: AddWidgetOnStackDecorator(
          board.tiles[x][y].tileStack,
          machine.getAsset(),
        ),
      );
      remainingMachines[machine.player] = remaining - 1;
    }

    return this;
  }

  @override
  Board build() {
    return board;
  }
}

import '../../../enum/player.dart';
import '../../../model/board.dart';
import '../../../model/machine.dart';
import '../../decorator/tile/add_widget_on_stack_decorator.dart';
import '../game.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  final Map<Player, int> remainingMachines = {
    Player.one: 3,
    Player.two: 3,
  };

  @override
  GameBuilder addMachine(Machine machine) {
    final remaining = remainingMachines[machine.player];

    if (remaining != null && remaining > 0) {
      final x = machine.position.row;
      final y = machine.position.col;
      game.board.tiles[x][y] = game.board.tiles[x][y].copyWith(
        machine: machine,
        tileStack: AddWidgetOnStackDecorator(
          game.board.tiles[x][y].tileStack,
          machine.getAsset(),
        ),
      );
      remainingMachines[machine.player] = remaining - 1;
    }

    return this;
  }

  @override
  Game build() {
    return game;
  }

  @override
  GameBuilder setBoard(Board board) {
    game.board = board;

    return this;
  }

  @override
  GameBuilder setInitialPlayer(Player player) {
    game.initialPlayer = player;

    return this;
  }
}

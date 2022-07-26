import '../../../enum/player.dart';
import '../../../model/board.dart';
import '../../abstract_factory/imachine_factory.dart';
import '../../decorator/tile/tile_stack_decorator.dart';
import '../game.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  @override
  GameBuilder addMachine(IMachineFactory machine) {
    final x = machine.getPosition().row;
    final y = machine.getPosition().col;
    game.board.tiles[x][y] = game.board.tiles[x][y].copyWith(
      machine: machine,
      tileStack: TileStackDecorator(game.board.tiles[x][y].tileStack.getStack()).addToStack(
        machine.getAsset(),
      ),
    );

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

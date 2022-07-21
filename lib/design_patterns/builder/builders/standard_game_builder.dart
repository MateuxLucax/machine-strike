import '../../../enum/player.dart';
import '../../abstract_factory/imachine_factory.dart';
import '../../decorator/tile/add_element_on_stack_decorator.dart';
import '../../singleton/boards.dart';
import '../game.dart';
import '../game_builder.dart';

class StandardGameBuilder extends GameBuilder {
  StandardGameBuilder() {
    super.createGame(Player.one, Boards().get(1));
  }

  @override
  GameBuilder addMachine(IMachineFactory machine) {
    final x = machine.getPosition().x;
    final y = machine.getPosition().y;
    game.board.tiles[x][y] = game.board.tiles[x][y].copyWith(
      machine: machine,
      tileStack: AddElementOnStackDecorator(
        game.board.tiles[x][y].tileStack,
        machine.getAsset(),
      ),
    );

    return this;
  }

  @override
  Game build() {
    return game;
  }
}

import '../../../config/game_const.dart';
import '../../state/game/game.dart';
import 'machine_command.dart';

class AttackCommand extends MachineCommand {
  Game game;

  AttackCommand(super.machine, this.game);

  @override
  void execute() {
    final selectedTile = game.selectedTile;

    if (!machine.alreadyAttacked && selectedTile != null) {
      for (var tile in game.board.tilesInAttackRange) {
        final attackedMachine = tile.machine;
        if (attackedMachine != null && attackedMachine.player != game.player) {
          machine.updateAlreadyAttacked(true);
          final attack = machine.combatPower + (tile.terrain.combatPowerOffset);
          if (attackedMachine.combatPower == machine.combatPower) {
            attackedMachine.receiveAttack(1);
            machine.receiveAttack(1);
          } else if (attackedMachine.combatPower > machine.combatPower) {
            machine.receiveAttack(attack);
          } else {
            attackedMachine.receiveAttack(attack);
          }

          if (machine.dead) {
            // TODO: add points to enemy
            selectedTile.unsetMachine();
            game.reset();
          }

          if (attackedMachine.dead) {
            tile.unsetMachine();
            if (game.board.getMachinesByPlayer(game.enemy).isEmpty) {
              game.updateVictoryPoints(GameConst.victoryPointsWin + 1);
            } else {
              game.updateVictoryPoints(attackedMachine.victoryPoints);
            }
          }
        }
      }
    }

    game.updateSelectedTile(null);
  }
}

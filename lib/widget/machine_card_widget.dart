import 'package:flutter/material.dart';

import '../model/machine.dart';
import 'info_text_widget.dart';

class MachineCardWidget extends StatelessWidget {
  final Machine machine;
  const MachineCardWidget(this.machine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 64,
                height: 64,
                child: machine.getAsset(),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.center,
              child: Text(
                machine.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InfoTextWidget(
              'Name: ',
              machine.name,
            ),
            InfoTextWidget(
              'Combat power: ',
              machine.combatPower.toString(),
            ),
            InfoTextWidget(
              'Health: ',
              machine.health.toString(),
            ),
            InfoTextWidget(
              'Movement range: ',
              machine.movementRange.toString(),
            ),
            InfoTextWidget(
              'Attack range: ',
              machine.attackRange.toString(),
            ),
            InfoTextWidget(
              'Victory points: ',
              machine.victoryPoints.toString(),
            ),
            InfoTextWidget(
              'Machine owner: ',
              machine.player.toString(),
            ),
            InfoTextWidget(
              'Position: ',
              machine.position.description,
            ),
            InfoTextWidget(
              'Direction: ',
              machine.direction.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

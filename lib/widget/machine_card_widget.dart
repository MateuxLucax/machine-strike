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
              description: 'Name: ',
              value: machine.name,
            ),
            InfoTextWidget(
              description: 'Combat power: ',
              value: machine.combatPower.toString(),
            ),
            InfoTextWidget(
              description: 'Health: ',
              value: machine.health.toString(),
            ),
            InfoTextWidget(
              description: 'Movement range: ',
              value: machine.movementRange.toString(),
            ),
            InfoTextWidget(
              description: 'Attack range: ',
              value: machine.attackRange.toString(),
            ),
            InfoTextWidget(
              description: 'Machine owner: ',
              value: machine.player.toString(),
            ),
            InfoTextWidget(
              description: 'Position: ',
              value: machine.position.description,
            ),
            InfoTextWidget(
              description: 'Direction: ',
              value: machine.direction.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

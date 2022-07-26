import 'package:flutter/material.dart';

import '../model/machine.dart';

class MachineCardWidget extends StatelessWidget {
  final Machine machine;
  const MachineCardWidget(this.machine, {Key? key}) : super(key: key);

  Widget _infoItem(String description, String value) {
    return Wrap(
      children: [
        Text(
          description,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }

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
            _infoItem('Name: ', machine.name),
            _infoItem('Combat power: ', machine.combatPower.toString()),
            _infoItem('Health: ', machine.health.toString()),
            _infoItem('Movement range: ', machine.movementRange.toString()),
            _infoItem('Attack range: ', machine.attackRange.toString()),
            _infoItem('Machine owner: ', machine.player.toString()),
            _infoItem('Position: ', machine.position.toString()),
            _infoItem('Direction: ', machine.direction.toString()),
          ],
        ),
      ),
    );
  }
}

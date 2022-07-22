import 'package:flutter/material.dart';

import '../design_patterns/abstract_factory/imachine_factory.dart';

class MachineCardWidget extends StatelessWidget {
  final IMachineFactory machine;
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
                machine.getName(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _infoItem('Name: ', machine.getName()),
            _infoItem('Combat power: ', machine.getCombatPower().toString()),
            _infoItem('Health: ', machine.getHealth().toString()),
            _infoItem('Movement range: ', machine.getMovementRange().toString()),
            _infoItem('Machine owner: ', machine.getPlayer().toString()),
            _infoItem('Position: ', machine.getPosition().toString()),
          ],
        ),
      ),
    );
  }
}

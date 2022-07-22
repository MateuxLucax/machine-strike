import 'package:flutter/material.dart';

import '../model/terrain.dart';

class TerrainCardWidget extends StatelessWidget {
  final Terrain terrain;
  const TerrainCardWidget(this.terrain, {Key? key}) : super(key: key);

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
              child: terrain.asset,
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.center,
              child: Text(
                terrain.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _infoItem('Combat power offset: ', terrain.combatPowerOffset.toString()),
          ],
        ),
      ),
    );
  }
}

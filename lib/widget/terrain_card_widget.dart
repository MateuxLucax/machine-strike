import 'package:flutter/material.dart';

import '../model/terrain.dart';
import 'info_text_widget.dart';

class TerrainCardWidget extends StatelessWidget {
  final Terrain terrain;
  const TerrainCardWidget(this.terrain, {Key? key}) : super(key: key);

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
                child: terrain.asset,
              ),
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
            InfoTextWidget(
              description: 'Combat power offset: ',
              value: terrain.combatPowerOffset.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class AttackTileDecorator extends TileStackDecorator {
  final String key;

  AttackTileDecorator(super.tileStack, this.key);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
        key: Key('unreachable-$key'),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color.fromARGB(128, 228, 105, 98),
          border: Border.all(
            color: Colors.redAccent,
            width: 4,
          ),
        ),
      ),
    ];
  }
}

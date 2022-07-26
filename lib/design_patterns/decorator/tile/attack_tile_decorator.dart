import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class AttackTileDecorator extends TileStackDecorator {
  AttackTileDecorator(super.tileStack);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
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

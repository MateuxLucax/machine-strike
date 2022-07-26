import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class ReachableTileDecorator extends TileStackDecorator {
  ReachableTileDecorator(super.tileStack);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color.fromARGB(128, 183, 243, 151),
          border: Border.all(
            color: Colors.greenAccent,
            width: 4,
          ),
        ),
      ),
    ];
  }
}

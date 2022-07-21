import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class SelectTileStackDecorator extends TileStackDecorator {
  SelectTileStackDecorator(super.tileStack);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color.fromARGB(128, 255, 255, 255),
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
        ),
      ),
    ];
  }
}

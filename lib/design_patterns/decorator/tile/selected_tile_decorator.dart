import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class SelectedTileDecorator extends TileStackDecorator {
  SelectedTileDecorator(super.tileStack);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color.fromARGB(167, 41, 97, 152),
          border: Border.all(
            color: Colors.blue,
            width: 4,
          ),
        ),
      ),
    ];
  }
}

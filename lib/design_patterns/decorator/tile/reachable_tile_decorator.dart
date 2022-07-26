import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class ReachableTileDecorator extends TileStackDecorator {
  final String key;

  ReachableTileDecorator(super.tileStack, this.key);

  @override
  List<Widget> getStack() {
    return [
      ...super.getStack(),
      Container(
        key: Key('unreachable-$key'),
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

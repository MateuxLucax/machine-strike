import 'package:flutter/widgets.dart';

import 'tile_stack.dart';

abstract class TileStackDecorator implements TileStack {
  final TileStack decoratedStack;

  TileStackDecorator(this.decoratedStack);

  @override
  List<Widget> getStack() {
    return decoratedStack.getStack();
  }
}

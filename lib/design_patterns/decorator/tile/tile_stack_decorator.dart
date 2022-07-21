import 'package:flutter/widgets.dart';

import 'tile_stack.dart';

class TileStackDecorator extends TileStack {
  final TileStack tileStack;

  TileStackDecorator(this.tileStack);

  @override
  List<Widget> getStack() {
    return tileStack.getStack();
  }
}

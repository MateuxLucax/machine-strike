import 'package:flutter/widgets.dart';

import 'tile_stack.dart';

class TileStackDecorator extends TileStack {
  TileStackDecorator(List<Widget> tileStack) {
    super.tileStack = tileStack;
  }

  @override
  List<Widget> getStack() {
    return tileStack;
  }

  @override
  TileStack addToStack(Widget widget) {
    tileStack.add(widget);

    return this;
  }

  @override
  TileStack removeFromStack(Key key) {
    tileStack.removeWhere((tile) {
      return tile.key == key;
    });

    return this;
  }
}

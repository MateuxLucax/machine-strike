import 'package:flutter/widgets.dart';

import 'tile_stack.dart';

class TileStackBase extends TileStack {
  TileStackBase(Widget tile) {
    this.tile = tile;
  }

  @override
  List<Widget> getStack() {
    return [tile];
  }
}

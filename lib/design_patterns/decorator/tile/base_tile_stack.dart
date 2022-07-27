import 'package:flutter/material.dart';

import 'tile_stack.dart';

class BaseTileStack implements TileStack {
  final Widget widget;

  BaseTileStack(this.widget);

  @override
  List<Widget> getStack() {
    return [widget];
  }
}

import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class AddWidgetOnStackDecorator extends TileStackDecorator {
  final Widget widget;

  AddWidgetOnStackDecorator(
    super.tileStack,
    this.widget,
  );

  @override
  List<Widget> getStack() {
    return [...super.getStack(), widget];
  }
}

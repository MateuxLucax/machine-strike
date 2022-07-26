import 'package:flutter/material.dart';

import 'tile_stack_decorator.dart';

class AddElementOnStackDecorator extends TileStackDecorator {
  final Widget widget;

  AddElementOnStackDecorator(
    super.tileStack,
    this.widget,
  );

  @override
  List<Widget> getStack() {
    return [...super.getStack(), widget];
  }
}

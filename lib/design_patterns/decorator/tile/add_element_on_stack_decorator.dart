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
    // TODO: add key to stack, so it can be properly manipulated, like a decorator to remove a element
    // tileStack.getStack().where((element) => element.key)
    return [...super.getStack(), widget];
  }
}

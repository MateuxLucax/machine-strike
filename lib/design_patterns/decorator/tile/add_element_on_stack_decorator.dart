import 'package:flutter/material.dart';
import 'package:machinestrike/design_patterns/decorator/tile/tile_stack_decorator.dart';

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

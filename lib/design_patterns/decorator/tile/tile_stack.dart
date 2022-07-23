import 'package:flutter/widgets.dart';

abstract class TileStack {
  @protected
  late List<Widget> tileStack;

  List<Widget> getStack();

  TileStack addToStack(Widget widget);

  TileStack removeFromStack(Widget widget);
}

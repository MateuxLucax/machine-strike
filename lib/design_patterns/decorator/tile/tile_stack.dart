import 'package:flutter/widgets.dart';

abstract class TileStack {
  @protected
  late Widget tile;

  List<Widget> getStack();
}

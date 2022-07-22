import 'package:flutter/services.dart';

import '../design_patterns/observer/cursor_observer.dart';
import '../model/tile.dart';

abstract class IBoardController {
  Tile get selectedTile;

  List<List<Tile>> get tiles;

  void attachCursorObserver(CursorObserver observer);

  void handleKeyStroke(RawKeyEvent event);
}

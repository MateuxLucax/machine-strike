import 'package:flutter/services.dart';

import '../design_patterns/observer/cursor_observer.dart';
import '../design_patterns/observer/update_tiles_observer.dart';
import '../model/tile.dart';

abstract class IBoardController {
  Tile get currentTile;

  List<List<Tile>> get tiles;

  void attachCursorObserver(CursorObserver observer);

  void attachTilesObserver(UpdateTilesObserver observer);

  void handleKeyStroke(RawKeyEvent event);
}

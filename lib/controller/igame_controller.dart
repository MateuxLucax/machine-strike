import 'package:flutter/cupertino.dart';

import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../design_patterns/state/game/game.dart';
import '../model/tile.dart';

abstract class IGameController {
  Tile get cursorTile;

  List<List<Tile>> get tiles;

  Game get currentGame;

  void handleKeyStroke(RawKeyEvent event);

  void attach(Observer observer);

  void notifyObservers(List<ObserverEvent> events);
}

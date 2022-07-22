import 'package:flutter/material.dart';

import '../controller/iboard_controller.dart';
import '../design_patterns/decorator/tile/select_tile_stack_decorator.dart';
import '../design_patterns/observer/cursor_observer.dart';
import '../model/tile.dart';
import '../model/tile_position.dart';
import '../widget/tile_widget.dart';

class BoardView extends StatefulWidget {
  final IBoardController controller;
  const BoardView(
    this.controller, {
    super.key,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> implements CursorObserver {
  List<TileWidget> tileWidgets = [];
  int cursorPosition = 0;

  _tilesToWidgets(List<List<Tile>> tiles) {
    for (var row in tiles) {
      for (var column in row) {
        tileWidgets.add(TileWidget(
          tile: column,
          tileStack: column.tileStack,
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tilesToWidgets(widget.controller.tiles);
    widget.controller.attachCursorObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var widgets = [...tileWidgets];
    widgets[cursorPosition] = widgets[cursorPosition].copyWith(
      tileStack: SelectTileStackDecorator(widgets[cursorPosition].tile.tileStack),
    );

    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: widget.controller.handleKeyStroke,
      child: SizedBox(
        width: 64 * 8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black, width: 4),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              padding: const EdgeInsets.all(0),
              itemCount: tileWidgets.length,
              itemBuilder: (context, index) => widgets[index],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void updateCursor(TilePosition cursor, Tile? terrain) {
    setState(() {
      cursorPosition = tileWidgets.indexWhere((widget) => widget.tile.position == cursor);
    });
  }
}

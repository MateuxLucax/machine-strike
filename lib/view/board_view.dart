import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machinestrike/config/game_config.dart';
import 'package:machinestrike/design_patterns/decorator/tile/select_tile_stack_decorator.dart';

import '../model/board.dart';
import '../enum/direction.dart';
import '../widget/tile_widget.dart';

class BoardView extends StatefulWidget {
  final Board board;
  const BoardView({
    super.key,
    required this.board,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  final size = 64;
  int selectedTile = 0;
  Direction tileDirection = Direction.north;
  List<TileWidget> tiles = [];

  void _updateTile(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    final key = event.logicalKey;
    int newVal = selectedTile;
    if (key == LogicalKeyboardKey.keyA) {
      newVal -= 1;
    } else if (key == LogicalKeyboardKey.keyS) {
      newVal += GameConst.size;
    } else if (key == LogicalKeyboardKey.keyW) {
      newVal -= GameConst.size;
    } else if (key == LogicalKeyboardKey.keyD) {
      newVal += 1;
    } else if (key == LogicalKeyboardKey.enter) {
      print(tiles[selectedTile].tile.position);
    }

    if (newVal != selectedTile && (newVal >= 0 && newVal < size)) {
      setState(() {
        selectedTile = newVal;
      });
    }
  }

  void _buildTiles() {
    for (var row in widget.board.tiles) {
      for (var column in row) {
        tiles.add(TileWidget(
          tile: column,
          tileStack: column.tileStack,
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _buildTiles();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: _updateTile,
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
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                if (index == selectedTile) {
                  return tiles[index].copyWith(
                    tileStack: SelectTileStackDecorator(
                      tiles[selectedTile].tile.tileStack,
                    ),
                  );
                }

                return tiles[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}

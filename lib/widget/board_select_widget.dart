import 'package:flutter/material.dart';

import '../design_patterns/builder/builders/standard_game_builder.dart';
import '../design_patterns/builder/game.dart';
import '../design_patterns/singleton/machines.dart';
import '../enum/player.dart';
import '../model/board.dart';
import '../model/tile.dart';
import '../view/game_view.dart';
import 'tile_widget.dart';

class BoardSelectWidget extends StatelessWidget {
  final Board board;
  const BoardSelectWidget(this.board, {Key? key}) : super(key: key);

  List<TileWidget> _tilesToWidgets(List<List<Tile>> tiles) {
    List<TileWidget> newTiles = [];
    for (var row in tiles) {
      for (var column in row) {
        newTiles.add(TileWidget(column.tileStack));
      }
    }

    return newTiles;
  }

  @override
  Widget build(BuildContext context) {
    var widgets = _tilesToWidgets(board.tiles);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Game game = StandardGameBuilder()
              .setBoard(board)
              .setInitialPlayer(Player.one)
              .addMachine(Machines().get(0))
              .addMachine(Machines().get(1))
              .addMachine(Machines().get(2))
              .addMachine(Machines().get(3))
              .addMachine(Machines().get(4))
              .addMachine(Machines().get(5))
              .addMachine(Machines().get(6))
              .addMachine(Machines().get(7))
              .build();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameView(game)),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 32 * 8,
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
                    itemCount: widgets.length,
                    itemBuilder: (context, index) {
                      return widgets[index];
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

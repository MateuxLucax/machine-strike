import 'package:flutter/material.dart';
import 'package:machinestrike/enum/direction.dart';

import '../widget/board_tile.dart';

class BoardView extends StatelessWidget {
  final int selectedTile;
  final Direction tileDirection;

  const BoardView({
    Key? key,
    required this.selectedTile,
    required this.tileDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> testItems = List.filled(
      8 * 8,
      BoardTileWidget(
        terrain: Image.asset('assets/images/tiles/chasm.png'),
      ),
    );

    if (selectedTile >= 0 && selectedTile < testItems.length) {
      debugPrint([selectedTile, tileDirection].toString());
      testItems[selectedTile] = BoardTileWidget(
        terrain: Image.asset('assets/images/tiles/chasm.png'),
        direction: tileDirection,
        piece: Image.asset('assets/images/pieces/burrower.png'),
      );
    }

    return SizedBox(
      width: 64 * 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.count(
            padding: const EdgeInsets.all(0),
            crossAxisCount: 8,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: testItems,
          ),
        ),
      ),
    );
  }
}

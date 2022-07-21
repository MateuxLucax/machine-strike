import 'package:flutter/material.dart';

import '../design_patterns/decorator/tile/tile_stack.dart';
import '../model/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;
  final TileStack tileStack;

  bool get hasMachine => tile.machine != null;

  const TileWidget({
    Key? key,
    required this.tile,
    required this.tileStack,
  }) : super(key: key);

  TileWidget copyWith({Tile? tile, TileStack? tileStack}) {
    return TileWidget(
      tile: tile ?? this.tile,
      tileStack: tileStack ?? this.tileStack,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Widget? pieceWidget;
    // if (piece != null) {
    //   pieceWidget = RotatedBox(
    //     quarterTurns: direction?.value ?? 0,
    //     child: piece,
    //   );
    // }

    // if (isSelected)

    return Container(
      width: 64,
      height: 64,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: tileStack.getStack(),
      ),
    );
  }
}

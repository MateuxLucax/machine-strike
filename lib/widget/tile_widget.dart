import 'package:flutter/material.dart';

import '../model/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget(
    this.tile, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: tile.tileStack.getStack(),
      ),
    );
  }
}

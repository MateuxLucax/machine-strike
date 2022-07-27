import 'package:flutter/material.dart';

import '../design_patterns/decorator/tile/tile_stack.dart';

class TileWidget extends StatelessWidget {
  final TileStack tileStack;

  const TileWidget(
    this.tileStack, {
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
        children: tileStack.getStack(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:machinestrike/enum/direction.dart';

class BoardTileWidget extends StatelessWidget {
  final Image? piece;
  final Direction? direction;
  final Image terrain;

  const BoardTileWidget({
    Key? key,
    required this.terrain,
    this.direction,
    this.piece,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? pieceWidget;
    if (piece != null) {
      pieceWidget = RotatedBox(
        quarterTurns: direction?.value ?? 0,
        child: piece,
      );
    }

    return Container(
      width: 64,
      height: 64,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          terrain,
          if (pieceWidget != null) pieceWidget,
        ],
      ),
    );
  }
}

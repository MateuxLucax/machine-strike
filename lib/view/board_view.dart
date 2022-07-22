import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machinestrike/model/tile_position.dart';
import '../controller/board_controller.dart';
import '../design_patterns/decorator/tile/select_tile_stack_decorator.dart';

class BoardView extends StatefulWidget {
  final BoardController controller;
  const BoardView(
    this.controller, {
    super.key,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  int cursorPosition = 0;
  late StreamSubscription<TilePosition> _cursorPositionSubscription;

  @override
  void initState() {
    super.initState();

    _cursorPositionSubscription = widget.controller.cursorSubscriber.stream.listen(_onCursorChange);
  }

  @override
  void dispose() {
    _cursorPositionSubscription.cancel();

    super.dispose();
  }

  _onCursorChange(TilePosition event) {
    setState(() {
      cursorPosition = widget.controller.indexFromPosition(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgets = [...widget.controller.tileWidgets];
    widgets[cursorPosition] = widget.controller.tileWidgets[cursorPosition].copyWith(
        tileStack: SelectTileStackDecorator(
      widget.controller.tileWidgets[cursorPosition].tile.tileStack,
    ));

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
              itemCount: widget.controller.tileWidgets.length,
              itemBuilder: (context, index) => widgets[index],
            ),
          ),
        ),
      ),
    );
  }
}

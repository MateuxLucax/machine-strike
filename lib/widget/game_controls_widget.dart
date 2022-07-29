import 'package:flutter/material.dart';

import 'info_text_widget.dart';

class GameControlsWidget extends StatelessWidget {
  const GameControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            InfoTextWidget(
              'W/A/S/D: ',
              'Cursor direction',
            ),
            InfoTextWidget(
              'Enter: ',
              'Select a machine',
            ),
            InfoTextWidget(
              'Esc: ',
              'Unselect a machine',
            ),
            InfoTextWidget(
              'Q/E: ',
              'Rotate machine',
            ),
            InfoTextWidget(
              'T: ',
              'Attack other machine',
            ),
            InfoTextWidget(
              'F: ',
              'Finish turn',
            ),
            InfoTextWidget(
              'Z: ',
              'Undo cursor',
            ),
            InfoTextWidget(
              'X: ',
              'Redo cursor',
            ),
          ],
        ),
      ),
    );
  }
}

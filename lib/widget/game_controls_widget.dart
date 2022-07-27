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
              description: 'W/A/S/D: ',
              value: 'Cursor direction',
            ),
            InfoTextWidget(
              description: 'Enter: ',
              value: 'Select a machine',
            ),
            InfoTextWidget(
              description: 'Esc: ',
              value: 'Unselect a machine',
            ),
            InfoTextWidget(
              description: 'Q/E: ',
              value: 'Rotate machine',
            ),
            InfoTextWidget(
              description: 'K: ',
              value: 'Attack other machine',
            ),
          ],
        ),
      ),
    );
  }
}

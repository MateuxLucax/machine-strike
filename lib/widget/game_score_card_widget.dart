import 'package:flutter/material.dart';

import 'info_text_widget.dart';

class GameScoreWidget extends StatelessWidget {
  const GameScoreWidget({Key? key}) : super(key: key);

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
              description: 'Turn: ',
              value: '1',
            ),
          ],
        ),
      ),
    );
  }
}

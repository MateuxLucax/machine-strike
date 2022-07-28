import 'package:flutter/material.dart';

import '../design_patterns/singleton/boards.dart';
import '../widget/board_select_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxW = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Strike'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Select which board you want to play!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: theme.textTheme.bodyText1?.fontSize,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              width: maxW,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: Boards().all.map((board) => BoardSelectWidget(board)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

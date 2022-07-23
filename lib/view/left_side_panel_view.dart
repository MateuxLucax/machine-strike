import 'package:flutter/material.dart';

class LeftSidePanelView extends StatefulWidget {
  const LeftSidePanelView({Key? key}) : super(key: key);

  @override
  State<LeftSidePanelView> createState() => _LeftSidePanelViewState();
}

class _LeftSidePanelViewState extends State<LeftSidePanelView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: theme.colorScheme.secondary,
        ),
        width: 256,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Score',
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontSize: theme.textTheme.headline6?.fontSize ?? 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

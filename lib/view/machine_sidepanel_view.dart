import 'dart:async';

import 'package:flutter/material.dart';

import '../controller/board_controller.dart';
import '../design_patterns/abstract_factory/imachine_factory.dart';
import '../model/tile_position.dart';
import '../widget/machine_card_widget.dart';

class MachineSidePanelView extends StatefulWidget {
  final BoardController controller;
  const MachineSidePanelView(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<MachineSidePanelView> createState() => _MachineSidePanelViewState();
}

class _MachineSidePanelViewState extends State<MachineSidePanelView> {
  IMachineFactory? selectedMachine;
  int cursorPosition = 0;
  late StreamSubscription<TilePosition> _cursorPositionSubscription;
  late StreamSubscription<IMachineFactory> _machineSubscription;

  @override
  void initState() {
    super.initState();

    _cursorPositionSubscription = widget.controller.cursorSubscriber.stream.listen(_onCursorChange);
    _machineSubscription = widget.controller.selectedMachineSubscriber.stream.listen(_onMachineChange);
  }

  @override
  void dispose() {
    _cursorPositionSubscription.cancel();
    _machineSubscription.cancel();

    super.dispose();
  }

  _onCursorChange(TilePosition event) {
    setState(() {
      selectedMachine = null;
    });
  }

  _onMachineChange(IMachineFactory event) {
    setState(() {
      selectedMachine = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final machine = selectedMachine;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          color: theme.colorScheme.secondary,
        ),
        width: 256,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Machine info',
              style: TextStyle(
                color: theme.colorScheme.onSecondary,
                fontSize: theme.textTheme.headline6?.fontSize ?? 12.0,
              ),
            ),
            const SizedBox(height: 24),
            if (machine != null)
              MachineCardWidget(machine)
            else
              Text(
                'Hover or select a machine to see it\'s details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontSize: theme.textTheme.bodyText1?.fontSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

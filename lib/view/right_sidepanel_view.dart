import 'dart:async';

import 'package:flutter/material.dart';

import '../controller/board_controller.dart';
import '../design_patterns/abstract_factory/imachine_factory.dart';
import '../model/terrain.dart';
import '../model/tile_position.dart';
import '../widget/machine_card_widget.dart';
import '../widget/terrain_card_widget.dart';

class RightSidePanelView extends StatefulWidget {
  final BoardController controller;
  const RightSidePanelView(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<RightSidePanelView> createState() => _RightSidePanelViewState();
}

class _RightSidePanelViewState extends State<RightSidePanelView> {
  IMachineFactory? selectedMachine;
  int cursorPosition = 0;
  Terrain? currentTerrain;
  late StreamSubscription<TilePosition> _cursorPositionSubscription;
  late StreamSubscription<IMachineFactory> _machineSubscription;
  late StreamSubscription<Terrain> _terrainSubscription;

  @override
  void initState() {
    super.initState();

    _cursorPositionSubscription = widget.controller.cursorSubscriber.stream.listen(_onCursorChange);
    _machineSubscription = widget.controller.selectedMachineSubscriber.stream.listen(_onMachineChange);
    _terrainSubscription = widget.controller.currentTerrainSubscriber.stream.listen(_onChangeTerrain);

    currentTerrain = widget.controller.currentTileWidget.tile.terrain;
  }

  @override
  void dispose() {
    _cursorPositionSubscription.cancel();
    _machineSubscription.cancel();
    _terrainSubscription.cancel();

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

  _onChangeTerrain(Terrain event) {
    setState(() {
      currentTerrain = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final machine = selectedMachine;
    final terrain = currentTerrain;

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SingleChildScrollView(
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
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              Text(
                'Terrain info',
                style: TextStyle(
                  color: theme.colorScheme.onSecondary,
                  fontSize: theme.textTheme.headline6?.fontSize ?? 12.0,
                ),
              ),
              const SizedBox(height: 12),
              if (terrain != null)
                TerrainCardWidget(terrain)
              else
                Text(
                  'Couldn\'t retrieve terrain info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: theme.textTheme.bodyText1?.fontSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

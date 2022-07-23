import 'package:flutter/material.dart';

import '../controller/iboard_controller.dart';
import '../design_patterns/abstract_factory/imachine_factory.dart';
import '../design_patterns/observer/cursor_observer.dart';
import '../model/terrain.dart';
import '../model/tile.dart';
import '../model/tile_position.dart';
import '../widget/machine_card_widget.dart';
import '../widget/terrain_card_widget.dart';

class RightSidePanelView extends StatefulWidget {
  final IBoardController controller;
  const RightSidePanelView(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<RightSidePanelView> createState() => _RightSidePanelViewState();
}

class _RightSidePanelViewState extends State<RightSidePanelView> implements CursorObserver {
  IMachineFactory? currentMachine;
  Terrain? currentTerrain;

  @override
  void initState() {
    super.initState();
    currentMachine = widget.controller.currentTile.machine;
    currentTerrain = widget.controller.currentTile.terrain;
    widget.controller.attachCursorObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final machine = currentMachine;
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
              const SizedBox(height: 12),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void updateCursor(TilePosition cursor, Tile tile) {
    setState(() {
      currentTerrain = tile.terrain;
      currentMachine = tile.machine;
    });
  }
}

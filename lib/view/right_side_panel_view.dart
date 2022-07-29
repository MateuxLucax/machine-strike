import 'package:flutter/material.dart';

import '../controller/igame_controller.dart';
import '../design_patterns/observer/events/cursor_event.dart';
import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../model/machine.dart';
import '../model/terrain.dart';
import '../widget/machine_card_widget.dart';
import '../widget/terrain_card_widget.dart';

class RightSidePanelView extends StatefulWidget {
  final IGameController controller;
  const RightSidePanelView(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<RightSidePanelView> createState() => _RightSidePanelViewState();
}

class _RightSidePanelViewState extends State<RightSidePanelView> implements Observer {
  Machine? currentMachine;
  Terrain? currentTerrain;

  @override
  void initState() {
    super.initState();
    currentMachine = widget.controller.cursorTile.machine;
    currentTerrain = widget.controller.cursorTile.terrain;
    widget.controller.attach(this);
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
                  fontSize: theme.textTheme.headline6?.fontSize,
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
                  fontSize: theme.textTheme.headline6?.fontSize,
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
  void update(ObserverEvent event) {
    if (event is CursorEvent) {
      setState(() {
        currentTerrain = event.tile.terrain;
        currentMachine = event.tile.machine;
      });
    }
  }
}

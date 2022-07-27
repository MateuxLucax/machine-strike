import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

import '../../../config/machine_from_config.dart';
import '../../../enum/player.dart';
import '../../../model/machine.dart';
import '../../../model/tile_position.dart';
import '../imachine_adapter.dart';

class XmlMachineAdapter implements IMachineAdapter {
  Future<XmlDocument> _getDocument(String file) async {
    return XmlDocument.parse(await rootBundle.loadString(file));
  }

  @override
  Future<Machine> getMachine(String file) async {
    final XmlDocument document = await _getDocument(file);
    final root = document.rootElement;

    final info = MachineInfo(
      combatPower: int.parse(root.getElement('combatPower')?.text ?? '0'),
      health: int.parse(root.getElement('health')?.text ?? '0'),
      movementRange: int.parse(root.getElement('movementRange')?.text ?? '0'),
      victoryPoints: int.parse(root.getElement('victoryPoints')?.text ?? '0'),
      attackRange: int.parse(root.getElement('attackRange')?.text ?? '0'),
      player: Player.fromId(int.parse(root.getElement('player')?.text ?? '0')),
      position: TilePosition(
        int.parse(root.getElement('row')?.text ?? '0'),
        int.parse(root.getElement('col')?.text ?? '0'),
      ),
    );

    return MachineFromConfig(root.getElement('name')?.text ?? '').get(info);
  }
}

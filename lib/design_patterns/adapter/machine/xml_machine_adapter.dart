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

    final info = MachineInfo(
        combatPower: document.getElement('combatPower')?.text as int? ?? 0,
        health: document.getElement('health')?.text as int? ?? 0,
        movementRange: document.getElement('movementRange')?.text as int? ?? 0,
        player: Player.fromId(document.getElement('player')?.text as int? ?? 0),
        position: TilePosition(
          document.getElement('row')?.text as int? ?? 0,
          document.getElement('col')?.text as int? ?? 0,
        ));

    return MachineFromConfig(document.getElement('name')?.text ?? '').get(info);
  }
}

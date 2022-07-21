import 'package:flutter/widgets.dart';

import '../model/machine.dart';

class Machines {
  static Image _fromAsset(String asset) {
    return Image.asset(
      asset,
      fit: BoxFit.fill,
    );
  }

  static final bristleback = Machine(_fromAsset(MachineAssets.bristleback));
  static final burrower = Machine(_fromAsset(MachineAssets.burrower));
  static final charger = Machine(_fromAsset(MachineAssets.charger));
  static final grazer = Machine(_fromAsset(MachineAssets.grazer));
  static final lancehorn = Machine(_fromAsset(MachineAssets.lancehorn));
  static final longleg = Machine(_fromAsset(MachineAssets.longleg));
  static final plowhorn = Machine(_fromAsset(MachineAssets.plowhorn));
  static final mountain = Machine(_fromAsset(MachineAssets.mountain));
  static final scrapper = Machine(_fromAsset(MachineAssets.scrapper));
  static final skydrifter = Machine(_fromAsset(MachineAssets.skydrifter));
}

class MachineAssets {
  static const folder = 'assets/images/machines';
  static const bristleback = '$folder/bristleback.png';
  static const burrower = '$folder/burrower.png';
  static const charger = '$folder/charger.png';
  static const grazer = '$folder/grazer.png';
  static const lancehorn = '$folder/lancehorn.png';
  static const longleg = '$folder/longleg.png';
  static const plowhorn = '$folder/plowhorn.png';
  static const mountain = '$folder/mountain.png';
  static const scrapper = '$folder/scrapper.png';
  static const skydrifter = '$folder/skydrifter.png';
}

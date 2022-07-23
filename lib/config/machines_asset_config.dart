import 'package:flutter/widgets.dart';

class MachineFromAsset {
  static Image _fromAsset(String asset) {
    return Image.asset(
      asset,
      key: Key(asset),
      fit: BoxFit.fill,
    );
  }

  static final bristleback = _fromAsset(MachineAssets.bristleback);
  static final burrower = _fromAsset(MachineAssets.burrower);
  static final charger = _fromAsset(MachineAssets.charger);
  static final grazer = _fromAsset(MachineAssets.grazer);
  static final lancehorn = _fromAsset(MachineAssets.lancehorn);
  static final longleg = _fromAsset(MachineAssets.longleg);
  static final plowhorn = _fromAsset(MachineAssets.plowhorn);
  static final scrapper = _fromAsset(MachineAssets.scrapper);
  static final skydrifter = _fromAsset(MachineAssets.skydrifter);
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
  static const scrapper = '$folder/scrapper.png';
  static const skydrifter = '$folder/skydrifter.png';
}

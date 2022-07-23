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
  static const _folder = 'assets/images/machines';
  static const bristleback = '$_folder/bristleback.png';
  static const burrower = '$_folder/burrower.png';
  static const charger = '$_folder/charger.png';
  static const grazer = '$_folder/grazer.png';
  static const lancehorn = '$_folder/lancehorn.png';
  static const longleg = '$_folder/longleg.png';
  static const plowhorn = '$_folder/plowhorn.png';
  static const scrapper = '$_folder/scrapper.png';
  static const skydrifter = '$_folder/skydrifter.png';
}

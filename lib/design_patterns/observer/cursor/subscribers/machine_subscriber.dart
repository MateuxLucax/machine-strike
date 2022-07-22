import '../../../abstract_factory/imachine_factory.dart';
import '../default_subscriber.dart';

class MachineSubscriber extends DefaultSubscriber<IMachineFactory> {
  @override
  void update(IMachineFactory observed) {
    streamController.add(observed);
  }
}

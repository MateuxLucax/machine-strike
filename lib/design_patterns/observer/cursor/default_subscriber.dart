import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class DefaultSubscriber<T> {
  late T observed;

  @protected
  final StreamController<T> streamController = StreamController.broadcast();

  Stream<T> get stream => streamController.stream;

  void update(T observed);
}

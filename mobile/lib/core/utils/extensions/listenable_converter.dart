import 'dart:async';
import 'package:flutter/foundation.dart';

extension ListenableStreamConverter<T> on ValueListenable<T> {
  Stream<T> get asStream  {
    final controller = StreamController<T>();
    controller.addStream(Stream.value(value));
      void listener() {
        controller.add(value);
      }

      void start() {
        addListener(listener);
      }

      void end() {
        removeListener(listener);
      }

      controller
        ..onListen = start
        ..onCancel = end
        ..onResume = start
        ..onPause = end;

      return controller.stream.asBroadcastStream();
    }
  }
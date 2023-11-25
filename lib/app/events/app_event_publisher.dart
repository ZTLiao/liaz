import 'dart:async';

import 'package:liaz/app/events/app_event.dart';
import 'package:liaz/app/events/app_event_listener.dart';
import 'package:liaz/app/logger/log.dart';

class AppEventPublisher {
  static AppEventPublisher? _instance;

  static AppEventPublisher get instance {
    _instance ??= AppEventPublisher();
    return _instance!;
  }

  final Map<String, StreamController<AppEvent>> _streams = {};

  final Map<int, StreamSubscription<AppEvent>> _subscriptions = {};

  void publishEvent(AppEvent event) {
    var name = event.runtimeType.toString();
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    Log.i("publishEvent : $name\r\nsource : ${event.source}\r\ntimestamp : ${event.timestamp}");
    _streams[name]!.add(event);
  }

  void addListener(AppEventListener? listener) {
    if (listener == null) {
      return;
    }
    var name = listener.name;
    if (!_streams.containsKey(name)) {
      _streams.addAll({name: StreamController.broadcast()});
    }
    _subscriptions.addAll({
      listener.hashCode:
          _streams[name]!.stream.listen((event) => listener.onEvent(event))
    });
  }

  void removeListener(AppEventListener? listener) {
    if (listener == null) {
      return;
    }
    var name = listener.name;
    var key = listener.hashCode;
    if (!_subscriptions.containsKey(key)) {
      return;
    }
    _subscriptions[key]!.cancel();
    _subscriptions.remove(key);
    if (!_streams.containsKey(name)) {
      _streams.remove(name);
    }
  }
}

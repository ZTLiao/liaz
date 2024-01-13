import 'dart:async';

import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/app/logger/log.dart';

class EventBus {
  static EventBus? _instance;

  static EventBus get instance {
    _instance ??= EventBus();
    return _instance!;
  }

  final Map<String, StreamController<Event>> _streams = {};

  final Map<String, StreamSubscription<Event>> _subscriptions = {};

  void publish(String topic, [dynamic source]) {
    if (!_streams.containsKey(topic)) {
      _streams.addAll({topic: StreamController.broadcast()});
    }
    var event = Event(
      source: source,
    );
    Log.i(
        "publish event topic : $topic\r\nsource : ${event.source}\r\ntimestamp : ${event.timestamp}");
    _streams[topic]!.add(event);
  }

  void subscribe(String topic, EventListener listener) {
    if (!_streams.containsKey(topic)) {
      _streams.addAll({topic: StreamController.broadcast()});
    }
    _subscriptions.addAll({
      topic: _streams[topic]!.stream.listen((event) => listener.onListen(event))
    });
  }

  void unSubscribe(String topic) {
    _subscriptions.forEach((key, value) {
      if (key == topic) {
        _subscriptions[key]!.cancel();
      }
    });
    if (_streams.containsKey(topic)) {
      _streams.remove(topic);
    }
  }
}

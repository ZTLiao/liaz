import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';

class NovelHistoryListener extends EventListener {
  final void Function(int) onConsume;

  NovelHistoryListener(this.onConsume);

  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    onConsume(source as int);
  }
}

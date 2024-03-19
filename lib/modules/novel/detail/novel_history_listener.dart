import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/models/dto/history_model.dart';

class NovelHistoryListener extends EventListener {
  final void Function(HistoryModel) onConsume;

  NovelHistoryListener(this.onConsume);

  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    onConsume(source as HistoryModel);
  }
}

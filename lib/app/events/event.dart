class Event {
  dynamic source;
  int timestamp;

  Event({this.source}) : timestamp = DateTime.now().millisecondsSinceEpoch;
}

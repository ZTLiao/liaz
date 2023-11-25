abstract class AppEvent<T> {
  T? source;
  int? timestamp;

  AppEvent(this.source) : timestamp = DateTime.now().millisecondsSinceEpoch;
}

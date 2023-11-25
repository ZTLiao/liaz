import 'app_event.dart';

abstract class AppEventListener<E extends AppEvent> {

  final E _event;

  AppEventListener(this._event);

  String get name {
    return this._event.runtimeType.toString();
  }

  void onEvent(E event);
}

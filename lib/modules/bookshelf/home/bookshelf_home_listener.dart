import 'package:liaz/app/enums/app_index_enum.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/services/user_service.dart';

class BookshelfHomeListener extends EventListener {
  @override
  void onListen(Event event) {
    if (event.source is! int ||
        (event.source as int) != AppIndexEnum.kBookshelf.index) {
      return;
    }
    UserService.instance.check();
  }
}

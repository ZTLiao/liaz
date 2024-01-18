import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/models/db/search.dart';
import 'package:path_provider/path_provider.dart';

class SearchService extends GetxService {
  static SearchService get instance {
    if (Get.isRegistered<SearchService>()) {
      return Get.find<SearchService>();
    }
    return Get.put(SearchService());
  }

  late Box<Search> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.search,
      path: appDir.path,
    );
  }

  Future<void> put(Search search) async {
    if (search.key.isEmpty) {
      return;
    }
    await box.put(search.key, search);
  }

  List<Search> list() {
    return box.values.toList().reversed.toList();
  }

  void clear() async {
    var keys = list().map((e) => e.key).toList();
    if (keys.isNotEmpty) {
      box.deleteAll(keys);
    }
  }
}

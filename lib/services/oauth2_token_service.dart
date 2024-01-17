import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/models/db/oauth2_token.dart';
import 'package:path_provider/path_provider.dart';

class OAuth2TokenService extends GetxService {
  static OAuth2TokenService get instance => Get.find<OAuth2TokenService>();
  Box<OAuth2Token>? box;

  Future<void> init() async {
    if (box == null) {
      var appDir = await getApplicationSupportDirectory();
      box = await Hive.openBox(
        Db.oauth2Token,
        path: appDir.path,
      );
    }
  }

  Future<void> put(OAuth2Token oauth2Token) async {
    await box!.put(oauth2Token.userId, oauth2Token);
  }

  Future<OAuth2Token?> get() async {
    await init();
    return box!.values.firstOrNull;
  }
}

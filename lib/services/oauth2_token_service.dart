import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/models/db/oauth2_token.dart';
import 'package:liaz/requests/oauth2_token_request.dart';
import 'package:path_provider/path_provider.dart';


class OAuth2TokenService extends GetxService {
  static OAuth2TokenService get instance => Get.find<OAuth2TokenService>();
  late Box<OAuth2Token> box;

  final _oauth2TokenRequest = OAuth2TokenRequest();

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "oauth2Token",
      path: appDir.path,
    );
    var oauth2Token = get();
    if (oauth2Token != null) {
      _oauth2TokenRequest.refreshToken(oauth2Token.refreshToken).then((value) {
        if (value != null) {
          put(value);
        }
      });
    }
  }

  Future<void> put(OAuth2Token oauth2Token) async {
    await box.put(oauth2Token.userId, oauth2Token);
  }

  OAuth2Token? get() {
    return box.values.firstOrNull;
  }
}

import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/decrypt_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/client/client_init_model.dart';

class AppRequest {
  Future<ClientInitModel> clientInit() async {
    dynamic result = await Request.instance.get('/client/init');
    if (result is Map) {
      Map<String, dynamic> json = result as Map<String, dynamic>;
      var keyJson = json['key'] as Map<String, dynamic>;
      if (keyJson.isNotEmpty) {
        var key = KeyConfig.fromJson(keyJson);
        var k1 = key.k1;
        var k2 = key.k2;
        if (k1.isNotEmpty) {
          Global.signKey = DecryptUtil.decryptKey(k1);
        }
        if (k2.isNotEmpty) {
          Global.publicKey = DecryptUtil.decryptKey(k2);
        }
      }
      var appEncrypt = json['app'] as String;
      if (!(appEncrypt.startsWith(StrUtil.delimStart) &&
          appEncrypt.endsWith(StrUtil.delimEnd))) {
        json['app'] = DecryptUtil.decryptRSA(appEncrypt, Global.publicKey);
      }
      return ClientInitModel.fromJson(json);
    }
    return ClientInitModel();
  }
}

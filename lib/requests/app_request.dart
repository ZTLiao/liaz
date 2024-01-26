import 'dart:convert';

import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/decrypt_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/client/client_init_model.dart';
import 'package:liaz/models/db/app_config.dart';

class AppRequest {
  Future<ClientInitModel> clientInit() async {
    var model = ClientInitModel();
    try {
      dynamic result = await Request.instance.get('/api/client/init');
      if (result != null && result is Map) {
        Map<String, dynamic> json = result as Map<String, dynamic>;
        var keyJson = json['key'] as Map<String, dynamic>;
        if (keyJson.isNotEmpty) {
          model.key = KeyConfig.fromJson(keyJson);
        }
        var appEncrypt = json['app'] as String;
        if (appEncrypt.isNotEmpty) {
          var publicKey = StrUtil.empty;
          if (model.key != null) {
            publicKey = DecryptUtil.decryptKey(model.key!.k2);
          }
          if (!(appEncrypt.startsWith(StrUtil.delimStart) &&
              appEncrypt.endsWith(StrUtil.delimEnd))) {
            json['app'] = DecryptUtil.decryptRSA(appEncrypt, publicKey);
          }
          var app = AppConfig.fromJson(jsonDecode(json['app']));
          if (model.key != null) {
            app.signKey = model.key!.k1;
            app.publicKey = model.key!.k2;
          }
          model.app = app;
        }
      }
    } catch (e) {
      Log.logPrint(e);
    }
    return model;
  }
}

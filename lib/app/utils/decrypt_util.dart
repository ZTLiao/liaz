import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

class DecryptUtil {
  static String decryptKey(String encryptText) {
    var step = 8;
    var encryptArray = utf8.encode(encryptText);
    var length = encryptArray.length / step;
    var decryptArray = <int>[];
    for (int i = 0; i < length; i++) {
      decryptArray.add(0);
      for (int j = 0; j < step; j++) {
        decryptArray[i] |= encryptArray[i * step + j] & (128 >> j);
      }
    }
    return String.fromCharCodes(decryptArray);
  }

  //公钥分段解密
  static String decryptRSA(String encryptText, String key) {
    //创建公钥对象
    RSAPublicKey publicKey = RSAKeyParser().parse(key) as RSAPublicKey;
    AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
    cipher.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    //原始数据
    List<int> sourceBytes =
        base64Decode(String.fromCharCodes(decodeHexString(encryptText)));
    //数据长度
    int inputLength = sourceBytes.length;
    int maxDecryptBlock = 256;
    // 缓存数组
    List<int> cache = [];
    // 分段解密
    for (var i = 0; i < inputLength; i += maxDecryptBlock) {
      //剩余长度
      int size = inputLength - i;
      List<int> b;
      if (size > maxDecryptBlock) {
        b = sourceBytes.sublist(i, i + maxDecryptBlock);
      } else {
        b = sourceBytes.sublist(i, i + size);
      }
      //解密后放到数组缓存
      cache.addAll(cipher.process(Uint8List.fromList(b)));
    }
    return utf8.decode(cache);
  }
}

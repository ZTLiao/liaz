import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptUtil {
  //公钥分段加密
  static String encryptRSA(String plainText, String key) {
    //创建公钥对象
    RSAPublicKey publicKey = RSAKeyParser().parse(key) as RSAPublicKey;
    //创建加密器
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    //分段加密
    // 原始字符串转成字节数组
    List<int> sourceBytes = utf8.encode(plainText);
    //数据长度
    int inputLength = sourceBytes.length;
    int maxEncryptBlock = 245;
    // 缓存数组
    List<int> cache = [];
    // 分段加密 步长为MAX_ENCRYPT_BLOCK
    for (int i = 0; i < inputLength; i += maxEncryptBlock) {
      //剩余长度
      int endLen = inputLength - i;
      List<int> item;
      if (endLen > maxEncryptBlock) {
        item = sourceBytes.sublist(i, i + maxEncryptBlock);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      // 加密后对象转换成数组存放到缓存
      cache.addAll(encrypter.encryptBytes(item).bytes);
    }
    return Encrypted(utf8.encode(base64Encode(cache))).base16;
  }
}

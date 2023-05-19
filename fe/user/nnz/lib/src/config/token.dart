import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nnz/src/services/user_provider.dart';

class Token {
  //accesToken 읽기
  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');
    return token;
  }

  //refreshToken 읽기
  static Future<String?> getRefreshToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'refreshToken');
    return token;
  }

  //accessToken 저장
  static Future<void> saveAccessToken(String accessToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'accessToken', value: accessToken);
  }

  //refreshToken 저장
  static Future<void> saveRefreshToken(String refreshToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  //accessToken 재발급
  static Future<void> refreshAccessToken() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    //데이터 베이스 접근
    final response = await UserProvider()
        .refreshToken(accessToken: accessToken!, refreshToken: refreshToken!);
    if (response.statusCode == 200) {
      final storage = FlutterSecureStorage();
      final newToken = response.body['accessToken'];
      await storage.delete(key: 'accessToken');
      saveAccessToken(newToken);
    }
  }
}

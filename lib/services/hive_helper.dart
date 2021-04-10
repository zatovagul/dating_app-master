import 'package:hive/hive.dart';

class HiveHelper {
  //
  static Box<String> tokenBox;

  static String get refreshToken => tokenBox.get('refresh_token');
  static String get token => tokenBox.get('token');
  static Future<void> deleteRefreshToken() async => await tokenBox.delete('refresh_token');
  static Future<void> addToken(String token) async => await tokenBox.put('token', token);
  static Future<void> addRefreshToken(String refreshToken) async => await tokenBox.put('refresh_token', refreshToken);
  //
}

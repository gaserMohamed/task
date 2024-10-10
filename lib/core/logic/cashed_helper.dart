// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';


class CachedHelper {
  static late SharedPreferences _prefs;


  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return _prefs.clear();
  }

  static Future<void> saveData({required String token, required String id, required String refreshToken}) async {
    await _prefs.setString('token', token);
    await _prefs.setString('id', id);
    await _prefs.setString('refresh_token', refreshToken);
  }

  static String getToken() => _prefs.getString('token') ?? '';
  static String getId() => _prefs.getString('id') ?? '';
  static String getRefreshToken() => _prefs.getString('refresh_token') ?? '';

  static bool isAuth() {
    return getToken().isEmpty;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<String> getAuth() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('auth') ?? '';
  }

  static Future<String> getEndpoint() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('endpoint') ?? '';
  }

  static Future<String> getPassword() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('password') ?? '';
  }

  static Future<String> getUsername() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getString('username') ?? '';
  }

  static Future<void> setAuth(String auth) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString('auth', auth);
  }

  static Future<void> setEndpoint(String endpoint) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString('endpoint', endpoint);
  }

  static Future<void> setPassword(String password) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString('password', password);
  }

  static Future<void> setUsername(String username) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setString('username', username);
  }
}

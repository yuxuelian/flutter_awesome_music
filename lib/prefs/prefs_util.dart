import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  PrefsUtil._();

  static const TOKEN = 'token';

  static PrefsUtil _instance;

  static PrefsUtil getInstance() {
    if (_instance == null) {
      _instance = PrefsUtil._();
    }
    return _instance;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    return (await _prefs).getString(TOKEN) ?? '';
  }

  Future<bool> saveToken(String value) async {
    return (await _prefs).setString(TOKEN, value);
  }
}

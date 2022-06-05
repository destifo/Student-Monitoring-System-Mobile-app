import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  void saveToken(String token) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('token', token);
  }

  void addKeyValuePair(String key, String value) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(key, value);
  }

  Future<String> getValueOf(String key) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String value = sharedPrefs.getString(key)!;
    return value;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? token = sharedPrefs.getString('token')!;
    return token;
  }

  void removeToken() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.remove('token');
  }
}

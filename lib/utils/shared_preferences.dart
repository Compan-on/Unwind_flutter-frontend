import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  static const _key = 'localStorage';

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static Future storeUsername(String username) async {
    await _preferences!.setString(_key, username);
  }

  static Future storeProfileURL(String profileURL) async {
    await _preferences!.setString(_key, profileURL);
  }

}
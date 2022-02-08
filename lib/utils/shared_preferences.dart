import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _key = 'localStorage';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future storeUsername(String username) async {
    await _preferences!.setString("name", username);
  }

  static Future storeProfileURL(String profileURL) async {
    await _preferences!.setString("profileImage", profileURL);
  }

  static Future removeUserInfo() async {
    await _preferences!.remove('name');
    await _preferences!.remove('profileImage');
  }
}

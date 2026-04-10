import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

//security store better! no sharePref

abstract class SessionKeyDataLevelKeys {
  static const _apiKeyToSP = 'apiKey';
}

class SessionKeyDataLevel {
  final Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();

  Future<String?> getDataApiKey() async {
    return (await _sharedPref).getString(SessionKeyDataLevelKeys._apiKeyToSP);
  }

  Future<void> saveDataApiKey(String apiKey) async {
    (await _sharedPref).setString(SessionKeyDataLevelKeys._apiKeyToSP, apiKey);
    // remove?
  }

  Future<void> clearDataApiKey() async {
    (await _sharedPref).remove(SessionKeyDataLevelKeys._apiKeyToSP);
  }
}

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

//security store better! no sharePref

abstract class SessionKeyDataLevelKeys {
  static const _apiKeyToSP = 'apiKey';
}

class SessionKeyDataLevel {
  final Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  Future<String?> loadData() async {
    return (await sharedPref).getString(SessionKeyDataLevelKeys._apiKeyToSP);
  }

  Future<void> saveData(String apiKey) async {
    (await sharedPref).setString(SessionKeyDataLevelKeys._apiKeyToSP, apiKey);
  }
}

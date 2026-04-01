import 'package:architecture_training/MVVMarch/domainLevel/entity/user.dart'
    show User;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class UserDataLevel {
  final Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  Future<User> loadData() async {
    final ageU = (await sharedPref).getInt('intAgeUser') ?? 0;
    return User(age: ageU);
  }

  Future<void> saveData(User user) async {
    (await sharedPref).setInt('intAgeUser', user.age);
  }
}

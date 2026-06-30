import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class UserDataLevelBloc {
  final Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  Future<UserEntityBl> loadData() async {
    final ageU = (await sharedPref).getInt('intBlocUser') ?? 0;
    return UserEntityBl(age: ageU);
  }

  Future<void> saveData(UserEntityBl user) async {
    (await sharedPref).setInt('intBlocUser', user.age);
  }
}

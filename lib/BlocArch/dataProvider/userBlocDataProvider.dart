import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class UserDataLevelBloc {
  final Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  // var counterInt = 0;

  Future<UserEntityBl> loadData() async {
    final ageU = (await sharedPref).getInt('intBlocUser') ?? 0;
    return UserEntityBl(age: ageU);
  }

  Future<void> saveData(UserEntityBl user) async {
    //при быстром нажатии (клац клац клац) наблюдается гонка состояний. не вседа сохраняется и отображается корректно
    // при блокЛиб баг сохраняется

    // counterInt = counterInt + 1;
    // if (counterInt % 2 == 0) {
    //   await Future.delayed(Duration(seconds: 1));
    // }
    print(user.age);
    (await sharedPref).setInt('intBlocUser', user.age);
  }
}

import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;

class UsersServiceBloc {
  final _userDataLevel = UserDataLevelBloc();
  var _user = UserEntityBl(age: 0);
  UserEntityBl get user => _user;
  Future<void> initializeDataBloc() async {
    _user = await _userDataLevel.loadData();
  }

  void incrementAge() {
    _user = user.copyWith(age: user.age + 1);
    _userDataLevel.saveData(_user);
  }

  void decrementAge() {
    _user = user.copyWith(age: max(_user.age - 1, 0));
    _userDataLevel.saveData(_user);
  }
}

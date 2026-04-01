import 'dart:math' show max;

import 'package:architecture_training/MVVMarch/domainLevel/dataProvider/userData.dart'
    show UserDataLevel;
import 'package:architecture_training/MVVMarch/domainLevel/entity/user.dart'
    show User;

class UserRepository {
  final UserDataLevel _userDataLevel = UserDataLevel();
  var _user = User(age: 0);
  User get user => _user;

  Future<void> initialized() async {
    _user = await _userDataLevel.loadData();
  }

  void inctementAge() async {
    _user = user.copyWith(age: user.age + 1);
    _userDataLevel.saveData(_user);
  }

  void decrementAge() async {
    _user = user.copyWith(age: max(user.age - 1, 0));
    _userDataLevel.saveData(_user);
  }
}

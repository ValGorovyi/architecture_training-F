import 'dart:async';

import 'package:architecture_training/mvvmDataLoadingDemo/entity/userEntity.dart'
    show UserEntity;
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  var _user = UserEntity(age: 0);
  UserEntity get user => _user;

  Timer? _timer;
  void openConect() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      _user = _user.copyWith(age: user.age + 1);
      notifyListeners();
    });
  }

  void closeConect() {
    _timer?.cancel();
    _timer = null;
  }
}

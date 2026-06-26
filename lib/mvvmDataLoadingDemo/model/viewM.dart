import 'dart:async';

import 'package:architecture_training/mvvmDataLoadingDemo/entity/userEntity.dart';
import 'package:architecture_training/mvvmDataLoadingDemo/setvices/serviceUser.dart'
    show UserService;
import 'package:flutter/material.dart';

class ViewMState {
  final String ageTitle;
  ViewMState({required this.ageTitle});
}

class ViewM extends ChangeNotifier {
  final _userService = UserService();
  var _state = ViewMState(ageTitle: '');
  ViewMState get state => _state;
  StreamSubscription<UserEntity>? userSubscription;

  ViewM() {
    _state = ViewMState(ageTitle: _userService.user.age.toString());
    userSubscription = _userService.userStream.listen((UserEntity user) {
      _state = ViewMState(ageTitle: _userService.user.age.toString());
      notifyListeners();
    });
    _userService.startListenUserStream();
  }

  @override
  void dispose() {
    userSubscription?.cancel();
    _userService.stopListenUserStream();
    super.dispose();
  }
}

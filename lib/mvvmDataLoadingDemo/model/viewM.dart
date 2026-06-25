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

  ViewM() {
    _userService.startListenUser((user) {
      _state = ViewMState(ageTitle: user.age.toString());
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userService.stopListenUser();
    super.dispose();
  }
}

import 'dart:ui';

import 'package:architecture_training/mvvmDataLoadingDemo/entity/userEntity.dart';
import 'package:architecture_training/mvvmDataLoadingDemo/server/serverDemoLoading.dart'
    show UserDataProvider;

typedef UserServiceOnUpdate = void Function(UserEntity);

class UserService {
  final _userDataProvider = UserDataProvider();
  VoidCallback? _currentOnUpdate;

  void startListenUser(UserServiceOnUpdate onUpdate) {
    final currentOnUpdate = () {
      onUpdate(_userDataProvider.user);
    };
    _currentOnUpdate = currentOnUpdate;
    _userDataProvider.addListener(currentOnUpdate);
    onUpdate(_userDataProvider.user);
    _userDataProvider.openConect();
  }

  void stopListenUser() {
    final currentOnUpdate = _currentOnUpdate;
    if (currentOnUpdate != null) {
      _userDataProvider.removeListener(currentOnUpdate);
    }
  }
}

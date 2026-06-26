import 'dart:ui';

import 'package:architecture_training/mvvmDataLoadingDemo/entity/userEntity.dart';
import 'package:architecture_training/mvvmDataLoadingDemo/server/serverDemoLoading.dart'
    show UserDataProvider;

typedef UserServiceOnUpdate = void Function(UserEntity);

class UserService {
  final _userDataProvider = UserDataProvider();
  VoidCallback? _currentOnUpdate;
  UserEntity get user => _userDataProvider.user;
  Stream<UserEntity> get userStream => _userDataProvider.userStream;
  void startListenUserStream() => _userDataProvider.openConect();

  void stopListenUserStream() => _userDataProvider.closeConect();
}

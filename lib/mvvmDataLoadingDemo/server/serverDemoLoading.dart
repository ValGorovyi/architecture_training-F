import 'dart:async';

import 'package:architecture_training/mvvmDataLoadingDemo/entity/userEntity.dart'
    show UserEntity;

class UserDataProvider {
  var _user = UserEntity(age: 0);
  UserEntity get user => _user;
  final _controller = StreamController<UserEntity>();
  Stream<UserEntity> get userStream => _controller.stream.asBroadcastStream();

  Timer? _timer;
  void openConect() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _user = _user.copyWith(age: user.age + 1);
      _controller.add(_user);
    });
  }

  void closeConect() {
    _timer?.cancel();
    _timer = null;
  }
}

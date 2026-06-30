import 'dart:async';
import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;

class UsersBlocState {
  final UserEntityBl currentUser;
  UsersBlocState({required this.currentUser});

  UsersBlocState copyWith({UserEntityBl? currentUser}) {
    return UsersBlocState(currentUser: currentUser ?? this.currentUser);
  }

  @override
  String toString() => 'UsersBlocState(currentUser: $currentUser)';

  @override
  bool operator ==(covariant UsersBlocState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UsersBloc {
  final _userDataLevelBloc = UserDataLevelBloc();
  var _userState = UsersBlocState(currentUser: UserEntityBl(age: 0));

  UsersBlocState get userState => _userState;
  final _stateStreamController = StreamController<UsersBlocState>.broadcast();
  Stream<UsersBlocState> get stateStream => _stateStreamController.stream;
  Future<void> _initializeDataBloc() async {
    final user = await _userDataLevelBloc.loadData();
    _userState = _userState.copyWith(currentUser: user);
    updateState(_userState);
  }

  void incrementAge() {
    var user = _userState.currentUser;
    user = user.copyWith(age: user.age + 1);
    updateUser(user);
    updateState(_userState.copyWith(currentUser: user));
  }

  void decrementAge() {
    var user = _userState.currentUser;
    user = user.copyWith(age: max(user.age - 1, 0));
    updateUser(user);
    updateState(_userState.copyWith(currentUser: user));
  }

  void updateState(UsersBlocState state) {
    _userState = state;
    _stateStreamController.add(state);
  }

  void updateUser(UserEntityBl user) {
    _userState = _userState.copyWith(currentUser: user);
    _userDataLevelBloc.saveData(user);
  }

  UsersBloc() {
    _initializeDataBloc();
  }
}

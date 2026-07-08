import 'dart:async';
import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;

abstract class UsersEventsBloc {}

class UsersIncrementEventBloc implements UsersEventsBloc {}

class UsersDecrementEventBloc implements UsersEventsBloc {}

class UsersInitializedEventBloc implements UsersEventsBloc {}

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

  final _stateStreamController = StreamController<UsersEventsBloc>.broadcast();

  late final Stream<UsersBlocState> _streamOfState;

  Stream<UsersBlocState> get stateStream => _streamOfState;

  Stream<UsersBlocState> _mapEventToStateBl(UsersEventsBloc event) async* {
    if (event is UsersInitializedEventBloc) {
      final user = await _userDataLevelBloc.loadData();
      yield UsersBlocState(currentUser: user);
    } else if (event is UsersIncrementEventBloc) {
      var user = _userState.currentUser;
      user = user.copyWith(age: user.age + 1);
      await _userDataLevelBloc.saveData(user);
      yield UsersBlocState(currentUser: user);
    } else if (event is UsersDecrementEventBloc) {
      var user = _userState.currentUser;
      user = user.copyWith(age: max(user.age - 1, 0));
      await _userDataLevelBloc.saveData(user);
      yield UsersBlocState(currentUser: user);
    }
  }

  Stream<UsersBlocState> _updateState(UsersBlocState newState) async* {
    if (_userState == newState) return;
    _userState = newState;
    yield newState;
  }

  void dispatchUserEventBloc(UsersEventsBloc event) {
    _stateStreamController.add(event);
  }

  UsersBloc() {
    _streamOfState = _stateStreamController.stream
        .asyncExpand<UsersBlocState>(_mapEventToStateBl)
        .asyncExpand(_updateState)
        .asBroadcastStream();
    _streamOfState.listen((state) {});
    dispatchUserEventBloc(UsersInitializedEventBloc());
  }
}

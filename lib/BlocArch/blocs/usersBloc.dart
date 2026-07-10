import 'dart:async';
import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UsersEventsBloc {}

class UsersIncrementEventBloc implements UsersEventsBloc {}

class UsersDecrementEventBloc implements UsersEventsBloc {}

class UsersInitializedEventBloc implements UsersEventsBloc {}

class UsersCubitBlState {
  final UserEntityBl currentUser;
  UsersCubitBlState({required this.currentUser});

  UsersCubitBlState copyWith({UserEntityBl? currentUser}) {
    return UsersCubitBlState(currentUser: currentUser ?? this.currentUser);
  }

  @override
  String toString() => 'UsersBlocState(currentUser: $currentUser)';

  @override
  bool operator ==(covariant UsersCubitBlState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UserCubitBl extends Cubit<UsersCubitBlState> {
  final _userDataLevelBloc = UserDataLevelBloc();
  UserCubitBl() : super(UsersCubitBlState(currentUser: UserEntityBl(age: 0))) {
    _initialize();
  }
  Future<void> _initialize() async {
    final user = await _userDataLevelBloc.loadData();
    final newState = state.copyWith(currentUser: user);
    emit(newState);
  }

  void incrementAge() {
    var user = state.currentUser;
    user = user.copyWith(age: user.age + 1);
    emit(state.copyWith(currentUser: user));
    _userDataLevelBloc.saveData(user);
  }

  void decrementAge() {
    var user = state.currentUser;
    user = user.copyWith(age: max(user.age - 1, 0));
    emit(state.copyWith(currentUser: user));
    _userDataLevelBloc.saveData(user);
  }
  /*
  var _userState = UsersCubitBlState(currentUser: UserEntityBl(age: 0));

  UsersCubitBlState get userState => _userState;

  final _stateStreamController = StreamController<UsersEventsBloc>.broadcast();

  late final Stream<UsersCubitBlState> _streamOfState;

  Stream<UsersCubitBlState> get stateStream => _streamOfState;
  Stream<UsersCubitBlState> _updateState(UsersCubitBlState newState) async* {
    if (_userState == newState) return;
    _userState = newState;
    yield newState;
  }
  */
  // Stream<UsersCubitBlState> _mapEventToStateBl(UsersEventsBloc event) async* {
  //   if (event is UsersInitializedEventBloc) {
  //     final user = await _userDataLevelBloc.loadData();
  //     yield UsersCubitBlState(currentUser: user);
  //   } else if (event is UsersIncrementEventBloc) {
  //     var user = _userState.currentUser;
  //     user = user.copyWith(age: user.age + 1);
  //     await _userDataLevelBloc.saveData(user);
  //     yield UsersCubitBlState(currentUser: user);
  //   } else if (event is UsersDecrementEventBloc) {
  //     var user = _userState.currentUser;
  //     user = user.copyWith(age: max(user.age - 1, 0));
  //     await _userDataLevelBloc.saveData(user);
  //     yield UsersCubitBlState(currentUser: user);
  //   }
  // }

  // void dispatchUserEventBloc(UsersEventsBloc event) {
  //   _stateStreamController.add(event);
  // }

  // UserCubitBl() : super(UsersCubitBlState(currentUser: UserEntityBl(age: 0))) {
  //   _streamOfState = _stateStreamController.stream
  //       .asyncExpand<UsersCubitBlState>(_mapEventToStateBl)
  //       .asyncExpand(_updateState)
  //       .asBroadcastStream();
  //   _streamOfState.listen((state) {});
  //   dispatchUserEventBloc(UsersInitializedEventBloc());
  // }

  // void closeConnect() {
  //   _stateStreamController.close();
  // }
}

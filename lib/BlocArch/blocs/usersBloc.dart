import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;
import 'package:bloc/bloc.dart';

abstract class UsersEventsBloc {}

class UserIncrementEventBloc implements UsersEventsBloc {}

class UserDecrementEventBloc implements UsersEventsBloc {}

class UsersInitializedEventBloc implements UsersEventsBloc {}

class UsersBlocLibState {
  final UserEntityBl currentUser;
  UsersBlocLibState({required this.currentUser});

  UsersBlocLibState copyWith({UserEntityBl? currentUser}) {
    return UsersBlocLibState(currentUser: currentUser ?? this.currentUser);
  }

  @override
  String toString() => 'UsersBlocState(currentUser: $currentUser)';

  @override
  bool operator ==(covariant UsersBlocLibState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UserBlocLib extends Bloc<UsersEventsBloc, UsersBlocLibState> {
  final _userDataLevelBloc = UserDataLevelBloc();
  UserBlocLib() : super(UsersBlocLibState(currentUser: UserEntityBl(age: 0))) {
    on<UsersInitializedEventBloc>((event, emit) async {
      final user = await _userDataLevelBloc.loadData();
      emit(UsersBlocLibState(currentUser: user));
    });
    on<UserIncrementEventBloc>((event, emit) async {
      var user = state.currentUser;
      user = user.copyWith(age: user.age + 1);
      await _userDataLevelBloc.saveData(user);

      emit(UsersBlocLibState(currentUser: user));
    });
    on<UserDecrementEventBloc>((event, emit) async {
      var user = state.currentUser;
      user = user.copyWith(age: max(user.age - 1, 0));
      await _userDataLevelBloc.saveData(user);

      emit(UsersBlocLibState(currentUser: user));
    });
    // stream.listen((state) {});
  }

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

  /*
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

*/
}

import 'dart:math' show max;

import 'package:architecture_training/BlocArch/dataProvider/userBlocDataProvider.dart'
    show UserDataLevelBloc;
import 'package:architecture_training/BlocArch/entity/userBlocEntity.dart'
    show UserEntityBl;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

abstract class UserEventsBloc {}

class UserIncrementEventBloc implements UserEventsBloc {}

class UserDecrementEventBloc implements UserEventsBloc {}

class UsersInitializedEventBloc implements UserEventsBloc {}

class UserBlocLibState {
  final UserEntityBl currentUser;
  UserBlocLibState({required this.currentUser});

  UserBlocLibState copyWith({UserEntityBl? currentUser}) {
    return UserBlocLibState(currentUser: currentUser ?? this.currentUser);
  }

  @override
  String toString() => 'UsersBlocState(currentUser: $currentUser)';

  @override
  bool operator ==(covariant UserBlocLibState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UserBlocLib extends Bloc<UserEventsBloc, UserBlocLibState> {
  final _userDataLevelBloc = UserDataLevelBloc();
  UserBlocLib() : super(UserBlocLibState(currentUser: UserEntityBl(age: 0))) {
    on<UserEventsBloc>(
      (event, emit) async {
        if (event is UsersInitializedEventBloc) {
          final user = await _userDataLevelBloc.loadData();
          emit(UserBlocLibState(currentUser: user));
        } else if (event is UserIncrementEventBloc) {
          var user = state.currentUser;
          user = user.copyWith(age: user.age + 1);
          await _userDataLevelBloc.saveData(user);
          emit(UserBlocLibState(currentUser: user));
        } else if (event is UserDecrementEventBloc) {
          var user = state.currentUser;
          user = user.copyWith(age: max(user.age - 1, 0));
          await _userDataLevelBloc.saveData(user);
          emit(UserBlocLibState(currentUser: user));
        }
      },
      transformer:
          sequential(), //фиксит гонку состояний, некккоректную обработку запросов
    );

    // on<UserIncrementEventBloc>((event, emit) async {
    //   if (event is UserIncrementEventBloc) {
    //     var user = state.currentUser;
    //     user = user.copyWith(age: user.age + 1);
    //     await _userDataLevelBloc.saveData(user);
    //     emit(UsersBlocLibState(currentUser: user));
    //   }
    // }, transformer: sequential());
    // on<UserDecrementEventBloc>((event, emit) async {
    //   if (event is UserDecrementEventBloc) {
    //     var user = state.currentUser;
    //     user = user.copyWith(age: user.age - 1);
    //     await _userDataLevelBloc.saveData(user);
    //     emit(UsersBlocLibState(currentUser: user));
    //   }
    // }, transformer: sequential());
    // on<UsersInitializedEventBloc>((event, emit) async {
    //   if (event is UsersInitializedEventBloc) {
    //     final user = await _userDataLevelBloc.loadData();
    //     emit(UsersBlocLibState(currentUser: user));
    //   }
    // }, transformer: sequential());
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

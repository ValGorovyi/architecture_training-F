import 'package:bloc/bloc.dart' show BlocObserver;
import 'package:bloc/src/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    print('onCreate blocObserver');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // приложение не падает, ошибка перехватывается
    //можно ловить ошибки всех бл

    super.onError(bloc, error, stackTrace);
    print(bloc);
    print(error);
  }
}

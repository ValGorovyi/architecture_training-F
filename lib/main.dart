import 'package:architecture_training/MVVMarch/mvvmLes.dart'
    show AppCounter, AppCounterWidget;
import 'package:architecture_training/MVVMlogin/appUiMvvmLogWidget.dart'
    show AppLoginWidget;
import 'package:architecture_training/MVVMlogin/domainLevel/repository/authRepository.dart'
    show AuthRepository;
import 'package:architecture_training/MVVMlogin/mvvmLogining.dart';
import 'package:architecture_training/loaderWidget.dart';
import 'package:architecture_training/navigationNames/mainNavigationNames.dart'
    show MainNavigationNames;
import 'package:architecture_training/prividerLesson/providerLesson.dart'
    show MyLessonAppProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final app = MainApp();
  runApp(app);
}
//////////////////////////////////////////////
///

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architecture ',
      home: LoaderWidget.create(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.cyanAccent),
      ),
      routes: <String, WidgetBuilder>{
        MainNavigationNames.authorizationAppAddress: (context) =>
            AppLoginWidget.create(),
        MainNavigationNames.counterAppAddress: (context) =>
            AppCounterWidget.create(),
        MainNavigationNames.loaderAddres: (_) => LoaderWidget.create(),
      },
    );
  }
}

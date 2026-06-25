import 'package:architecture_training/MVVMarch/mvvmLes.dart'
    show AppCounterWidget;
import 'package:architecture_training/MVVMlogin/appUiMvvmLogWidget.dart'
    show AppLoginWidget;

import 'package:architecture_training/loaderWidget.dart';
import 'package:architecture_training/mvvmDataLoadingDemo/dataLoadingDemoW.dart'
    show DataloadingDemoW;
import 'package:architecture_training/navigationNames/mainNavigationNames.dart'
    show MainNavigationNames;

import 'package:flutter/material.dart';

void main() {
  final app = MaterialApp(home: DataloadingDemoW());
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

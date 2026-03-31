import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  ViewModel() {
    loadData();
  }
  var _intAge = 0;
  get intAge => _intAge;

  Future<void> loadData() async {
    final sp = await SharedPreferences.getInstance();
    _intAge = sp.getInt('intAge') ?? 0;
    notifyListeners();
  }

  Future<void> inctementAge() async {
    _intAge += 1;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('intAge', _intAge);
    notifyListeners();
  }

  Future<void> decrementAge() async {
    _intAge = max(_intAge - 1, 0);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('intAge', _intAge);
    notifyListeners();
  }
}

class MyLessonAppMvvm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => ViewModel(),
        child: UpperWidget(),
      ),
    );
  }
}

class UpperWidget extends StatelessWidget {
  const UpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewModel>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              viewModel.inctementAge();
            },
            child: Text('++'),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.decrementAge();
            },
            child: Text('--'),
          ),
          Text('${viewModel.intAge}'),
        ],
      ),
    );
  }
}

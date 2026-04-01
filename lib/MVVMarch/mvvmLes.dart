// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int age;
  User({required this.age});

  User copyWith({int? age}) {
    return User(age: age ?? this.age);
  }
}

class UserRepository {
  var _user = User(age: 0);
  User get user => _user;

  Future<void> loadData() async {
    final sp = await SharedPreferences.getInstance();
    final ageU = sp.getInt('intAgeUser') ?? 0;
    _user = User(age: ageU);
  }

  Future<void> saveData() async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt('intAgeUser', _user.age);
  }

  void inctementAge() async {
    _user = _user.copyWith(age: _user.age + 1);
  }

  void decrementAge() async {
    _user = _user.copyWith(age: max(_user.age - 1, 0));
  }
}

class ViewModelState {
  final String ageTitle;
  ViewModelState({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userRepo = UserRepository();
  var _state = ViewModelState(ageTitle: '');
  ViewModelState get state => _state;

  ViewModel() {
    loadData();
  }

  void loadData() async {
    await _userRepo.loadData();
    _updateState();
  }

  Future<void> onIncrementButtonPressed() async {
    _userRepo.inctementAge();
    _updateState();
  }

  Future<void> onDecrementButtonPressed() async {
    _userRepo.decrementAge();
    _updateState();
  }

  void _updateState() {
    final user = _userRepo._user;
    _state = ViewModelState(ageTitle: user.age.toString());
    notifyListeners();
  }
}

class MyLessonAppMvvm extends StatelessWidget {
  const MyLessonAppMvvm({super.key});

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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          IncrementVievButton(),
          DecrementVievButton(),
          TextView(),
        ],
      ),
    );
  }
}

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

class IncrementVievButton extends StatelessWidget {
  const IncrementVievButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: model.onIncrementButtonPressed,
      child: Text('++'),
    );
  }
}

class DecrementVievButton extends StatelessWidget {
  const DecrementVievButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: model.onDecrementButtonPressed,
      child: Text('--'),
    );
  }
}

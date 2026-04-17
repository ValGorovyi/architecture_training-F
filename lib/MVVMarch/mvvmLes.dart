import 'package:architecture_training/MVVMarch/domainLevel/repository/userRepository.dart'
    show UserRepository;
import 'package:architecture_training/MVVMlogin/domainLevel/repository/authRepository.dart'
    show AuthRepository;
import 'package:architecture_training/navigationNames/mainNavigationNames.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String ageTitle;
  _ViewModelState({required this.ageTitle});
}

class _ViewModel extends ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();

  final _userRepo = UserRepository();
  var _state = _ViewModelState(ageTitle: '');
  _ViewModelState get state => _state;

  _ViewModel() {
    loadData();
  }

  void loadData() async {
    await _userRepo.initialized();
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
    final user = _userRepo.user;
    _state = _ViewModelState(ageTitle: user.age.toString());
    notifyListeners();
  }

  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await _authRepo.logOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationNames.loaderAddres,
      (route) => false,
    );
  }
}

// ui
// class AppCounter extends StatelessWidget {
//   const AppCounter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SafeArea(child: UpperWidget.create()));
//   }
// }

class AppCounterWidget extends StatelessWidget {
  const AppCounterWidget({super.key});
  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: const AppCounterWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => model.onLogoutButtonPressed(context),
            child: Icon(Icons.backspace),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            IncrementVievButton(),
            DecrementVievButton(),
            TextView(),
          ],
        ),
      ),
    );
  }
}

class TextView extends StatelessWidget {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((_ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

class IncrementVievButton extends StatelessWidget {
  const IncrementVievButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
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
    final model = context.read<_ViewModel>();
    return ElevatedButton(
      onPressed: model.onDecrementButtonPressed,
      child: Text('--'),
    );
  }
}

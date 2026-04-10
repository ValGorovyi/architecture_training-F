import 'package:architecture_training/MVVMarch/domainLevel/repository/userRepository.dart'
    show UserRepository;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String ageTitle;
  _ViewModelState({required this.ageTitle});
}

class _ViewModel extends ChangeNotifier {
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
}

// ui
class MyLessonAppMvvm extends StatelessWidget {
  const MyLessonAppMvvm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: UpperWidget.create()));
  }
}

class UpperWidget extends StatelessWidget {
  const UpperWidget({super.key});
  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: const UpperWidget(),
    );
  }

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

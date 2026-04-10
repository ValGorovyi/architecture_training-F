// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/authApiDataProvider.dart'
    show AuthIcorerectDataError;
import 'package:architecture_training/MVVMlogin/domainLevel/repository/authRepository.dart'
    show AuthRepository;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, ReadContext, SelectContext;

class _ViewModelStateLogining {
  final String authErrorTitle;
  final String currentLogin;
  final String currentPassword;
  final bool canSubmit;
  final bool isAuthProcess;

  _ViewModelStateLogining({
    this.authErrorTitle = '',
    this.currentLogin = '',
    this.currentPassword = '',
    this.canSubmit = false,
    this.isAuthProcess = false,
  });

  _ViewModelStateLogining copyWith({
    String? authErrorTitle,
    String? currentLogin,
    String? currentPassword,
    bool? canSubmit,
    bool? isAuthProcess,
  }) {
    return _ViewModelStateLogining(
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      currentLogin: currentLogin ?? this.currentLogin,
      currentPassword: currentPassword ?? this.currentPassword,
      canSubmit: canSubmit ?? this.canSubmit,
      isAuthProcess: isAuthProcess ?? this.isAuthProcess,
    );
  }
}

class _ViewModelToLogining extends ChangeNotifier {
  var _stateLogining = _ViewModelStateLogining();
  _ViewModelStateLogining get stateL => _stateLogining;

  final AuthRepository _authRepo = AuthRepository();

  void changeLoginText(String value) {
    if (_stateLogining.currentLogin == value) return;
    _stateLogining = _stateLogining.copyWith(currentLogin: value);
    notifyListeners();
  }

  void changePasswordText(String value) {
    if (_stateLogining.currentPassword == value) return;

    _stateLogining = _stateLogining.copyWith(currentPassword: value);
    notifyListeners();
  }

  Future<void> onLogInButtonPressed() async {
    final login = _stateLogining.currentLogin;
    final password = _stateLogining.currentPassword;
    if (login.isEmpty || password.isEmpty) return;
    try {
      _authRepo.logIn(login, password);
    } on AuthIcorerectDataError {
      _stateLogining = _stateLogining.copyWith(
        authErrorTitle: 'login or password error',
      );
      notifyListeners();
    } catch (exeption) {
      _stateLogining = _stateLogining.copyWith(
        authErrorTitle: 'oops. exeption... ',
      );
      notifyListeners();
    }
  }
}

class UpperLoginW extends StatelessWidget {
  const UpperLoginW({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModelToLogining(),
      child: const UpperLoginW(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LoginTextW(),
            _PasswordTextW(),
            _ErrorLoginingW(),
            _ButtonLoginW(),
          ],
        ),
      ),
    );
  }
}

class _LoginTextW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = context.read<_ViewModelToLogining>();
    return TextField(
      decoration: InputDecoration(
        labelText: 'Login',
        border: OutlineInputBorder(),
      ),
      onChanged: _model.changeLoginText,
    );
  }
}

class _PasswordTextW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = context.read<_ViewModelToLogining>();
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      onChanged: _model.changePasswordText,
    );
  }
}

class _ErrorLoginingW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final err = context.select(
      (_ViewModelToLogining model) => model.stateL.authErrorTitle,
    );
    return Text(err);
  }
}

class _ButtonLoginW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = context.read<_ViewModelToLogining>();
    return ElevatedButton(
      onPressed: _model.onLogInButtonPressed,
      child: Text('Log In'),
    );
  }
}

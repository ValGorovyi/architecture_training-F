// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/authApiDataProvider.dart'
    show AuthIcorerectDataError;
import 'package:architecture_training/MVVMlogin/domainLevel/repository/authRepository.dart'
    show AuthRepository;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, ReadContext, SelectContext;

enum _AuthButtonCanSubmitState { canSubmit, authProgres, disable }

class _ViewModelStateLogining {
  final String authErrorTitle;
  final String currentLogin;
  final String currentPassword;
  final bool isAuthProcess;
  _AuthButtonCanSubmitState get authButtonState {
    if (isAuthProcess) {
      return _AuthButtonCanSubmitState.authProgres;
    } else if (currentLogin.isNotEmpty && currentPassword.isNotEmpty) {
      return _AuthButtonCanSubmitState.canSubmit;
    } else {
      return _AuthButtonCanSubmitState.disable;
    }
  }

  _ViewModelStateLogining({
    this.authErrorTitle = '',
    this.currentLogin = '',
    this.currentPassword = '',
    this.isAuthProcess = false,
  });

  _ViewModelStateLogining copyWith({
    String? authErrorTitle,
    String? currentLogin,
    String? currentPassword,
    bool? isAuthProcess,
  }) {
    return _ViewModelStateLogining(
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      currentLogin: currentLogin ?? this.currentLogin,
      currentPassword: currentPassword ?? this.currentPassword,
      isAuthProcess: isAuthProcess ?? this.isAuthProcess,
    );
  }
}

class _ViewModelToLogining extends ChangeNotifier {
  var _stateLogining = _ViewModelStateLogining();
  _ViewModelStateLogining get stateLogining => _stateLogining;

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
    _stateLogining = _stateLogining.copyWith(
      authErrorTitle: '',
      isAuthProcess: true,
    );
    notifyListeners();
    try {
      await _authRepo.logIn(login, password);
      _stateLogining = _stateLogining.copyWith(
        isAuthProcess: false,
        authErrorTitle: 'Wellcome, logining ok!',

        ///
      );
      notifyListeners();
      await Future<void>.delayed(Duration(seconds: 3));

      ///
      _stateLogining = _stateLogining.copyWith(authErrorTitle: '');

      ///
      notifyListeners();

      ///
    } on AuthIcorerectDataError {
      _stateLogining = _stateLogining.copyWith(
        authErrorTitle: 'Login or password error',
        isAuthProcess: false,
      );
      notifyListeners();
    } catch (exeption) {
      _stateLogining = _stateLogining.copyWith(
        authErrorTitle: 'Oops. exeption... ',
        isAuthProcess: false,
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
            _ErrorLoginingW(),
            SizedBox(height: 12),
            _LoginTextW(),
            SizedBox(height: 12),
            _PasswordTextW(),
            SizedBox(height: 12),
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
      (_ViewModelToLogining model) => model.stateLogining.authErrorTitle,
    );
    return Text(err);
  }
}

class _ButtonLoginW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModelToLogining>();
    final buttonState = context.select((_ViewModelToLogining model) {
      return model.stateLogining.authButtonState;
    });
    final authButtonFunc = buttonState == _AuthButtonCanSubmitState.canSubmit
        ? model.onLogInButtonPressed
        : null;
    final authButtonChild = buttonState == _AuthButtonCanSubmitState.authProgres
        ? CircularProgressIndicator()
        : const Text('Log In');
    return ElevatedButton(onPressed: authButtonFunc, child: authButtonChild);
  }
}

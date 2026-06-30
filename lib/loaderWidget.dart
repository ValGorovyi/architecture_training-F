import 'package:architecture_training/MVVMlogin/domainLevel/repository/authRepository.dart'
    show AuthRepository;
import 'package:architecture_training/navigationNames/mainNavigationNames.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

class _LoaderWModel {
  final AuthRepository _authRepo = AuthRepository();
  BuildContext context;
  _LoaderWModel(this.context) {
    checkAuthInit();
  }
  void checkAuthInit() async {
    final isAuth = await _authRepo.checkCurrentSessionAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToAuthorizationScreen();
    }
  }

  void _goToAuthorizationScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationNames.authorizationAppAddress,
      (routes) => false,
    );
  }

  void _goToAppScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationNames.counterAppAddress,
      (routes) => false,
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  static Widget create() {
    return Provider(
      create: (context) => _LoaderWModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

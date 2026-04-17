import 'package:architecture_training/MVVMlogin/appUiMvvmLogWidget.dart'
    show AppLoginWidget;
import 'package:flutter/material.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppLoginWidget.create());
  }
}

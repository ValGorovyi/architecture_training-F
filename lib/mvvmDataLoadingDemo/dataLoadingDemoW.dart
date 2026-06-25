import 'package:architecture_training/mvvmDataLoadingDemo/model/viewM.dart'
    show ViewM;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataloadingDemoW extends StatelessWidget {
  const DataloadingDemoW({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ViewM>(
      create: (context) => ViewM(),
      builder: (context, child) => Scaffold(body: Center(child: _AppTitle())),
    );
  }
}

class _AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = context.select((ViewM model) => model.state.ageTitle);
    return Text(title);
  }
}

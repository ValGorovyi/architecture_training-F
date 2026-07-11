import 'package:architecture_training/BlocArch/blocs/usersBloc.dart'
    show
        UserBlocLib,
        UsersBlocLibState,
        UserIncrementEventBloc,
        UserDecrementEventBloc,
        UsersInitializedEventBloc;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataBlocW extends StatelessWidget {
  const DataBlocW({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          UserBlocLib()
            ..add(UsersInitializedEventBloc()), // загружает данные из хранилища
      builder: (context, child) =>
          Scaffold(body: Center(child: WidgetBuilderBloc())),
      dispose: (context, blocLibValue) => blocLibValue.close(),
    );
  }
}

class WidgetBuilderBloc extends StatelessWidget {
  const WidgetBuilderBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_AppTitle(), IncrementBlocButtonW(), DecrementBlocButtonW()],
      ),
    );
  }
}

class _AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocLib = context.read<UserBlocLib>();
    return StreamBuilder<UsersBlocLibState>(
      stream: blocLib.stream,
      initialData: blocLib.state,
      builder: (context, snapshot) {
        final age = snapshot.requireData.currentUser.age;
        return Text('$age');
      },
    );
  }
}

class IncrementBlocButtonW extends StatelessWidget {
  const IncrementBlocButtonW({super.key});

  @override
  Widget build(BuildContext context) {
    final blocLib = context.read<UserBlocLib>();

    return ElevatedButton(
      onPressed: () => blocLib.add(UserIncrementEventBloc()),
      child: Icon(Icons.plus_one_sharp),
    );
  }
}

class DecrementBlocButtonW extends StatelessWidget {
  const DecrementBlocButtonW({super.key});

  @override
  Widget build(BuildContext context) {
    final blocLib = context.read<UserBlocLib>();

    return ElevatedButton(
      onPressed: () => blocLib.add(UserDecrementEventBloc()),
      child: Icon(Icons.exposure_minus_1),
    );
  }
}

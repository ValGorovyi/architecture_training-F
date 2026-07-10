import 'package:architecture_training/BlocArch/blocs/usersBloc.dart'
    show
        UsersBloc,
        UsersBlocState,
        UsersIncrementEventBloc,
        UsersDecrementEventBloc;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataBlocW extends StatelessWidget {
  const DataBlocW({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => UsersBloc(),
      builder: (context, child) =>
          Scaffold(body: Center(child: WidgetBuilderBloc())),
      dispose: (context, blocValue) => blocValue.closeConnect(),
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
    final bloc = context.read<UsersBloc>();
    return StreamBuilder<UsersBlocState>(
      stream: bloc.stateStream,
      initialData: bloc.userState,
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
    final bloc = context.read<UsersBloc>();

    return ElevatedButton(
      onPressed: () => bloc.dispatchUserEventBloc(UsersIncrementEventBloc()),
      child: Icon(Icons.plus_one_sharp),
    );
  }
}

class DecrementBlocButtonW extends StatelessWidget {
  const DecrementBlocButtonW({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();

    return ElevatedButton(
      onPressed: () => bloc.dispatchUserEventBloc(UsersDecrementEventBloc()),
      child: Icon(Icons.exposure_minus_1),
    );
  }
}

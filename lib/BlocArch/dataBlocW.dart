import 'package:architecture_training/BlocArch/blocs/usersBloc.dart'
    show
        UserBlocLib,
        UserBlocLibState,
        UserIncrementEventBloc,
        UserDecrementEventBloc,
        UserInitializedEventBloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DataBlocW extends StatelessWidget {
  const DataBlocW({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBlocLib()
            ..add(UserInitializedEventBloc()), // загружает данные из хранилища
      child: Scaffold(body: Center(child: WidgetBuilderBloc())),
    );
  }
}

// BlocConsumer = BlocListener + BlocBuilder

class WidgetBuilderBloc extends StatelessWidget {
  const WidgetBuilderBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBlocLib, UserBlocLibState>(
      // listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        // didChangeDependence
        // просто позволяет слушать. стейтфул виджет
        print(state.currentUser.age);
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AppTitle(),
            IncrementBlocButtonW(),
            DecrementBlocButtonW(),
          ],
        ),
      ),
    );
  }
}

class _AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final age = context.select(
      (UserBlocLib bloc) => bloc.state.currentUser.age,
    );
    return Text('$age');
    //////////////////////////
    // return BlocBuilder<UserBlocLib, UsersBlocLibState>(
    // buildWhen: (previous, current) =>
    //     previous.currentUser.age > current.currentUser.age,
    // builder: (context, state) {
    //   final age = state.currentUser.age;
    //   return Text('$age');
    // },
    // );
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


//  final blocLib = context.read<UserBlocLib>();
//     return StreamBuilder<UsersBlocLibState>(
//       stream: blocLib.stream,
//       initialData: blocLib.state,
//       builder: (context, snapshot) {
//         final age = snapshot.requireData.currentUser.age;
//         return Text('$age');
//       },
//     );
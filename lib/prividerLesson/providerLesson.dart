import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLessonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StateFWWrap());
  }
}

class TestDataModel {
  var one = 0;
  var two = 0;
  void inc1() {
    one += 1;
  }

  void inc2() {
    two += 1;
  }
}

class StateFWWrap extends StatefulWidget {
  @override
  State<StateFWWrap> createState() => _StateFWWrapState();
}

class _StateFWWrapState extends State<StateFWWrap> {
  final model = TestDataModel();

  @override
  Widget build(BuildContext context) {
    return Provider(create: (context) => TestDataModel(), child: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TestDataModel>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: model.inc1, child: Text('Button 111')),
        ElevatedButton(onPressed: model.inc2, child: Text('Button 222')),
        ElevatedButton(onPressed: () {}, child: Text('Button 333')),
        ElevatedButton(onPressed: () {}, child: Text('Button 444')),

        //
        TextDemoW1(),
        TextDemoW2(),
      ],
    );
  }
}

class TextDemoW1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final valueFromM = context.select(
      (TestDataModel modelValue) =>
          modelValue.one, //работает только с Провайдером
    );
    return Text('$valueFromM');
  }
}

class TextDemoW2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final valueFromM = context.watch<TestDataModel>().two;
    final model = Provider.of<TestDataModel>(context, listen: true);
    final valueFromM = model.two;
    return Text('$valueFromM');
  }
}

// multiP(providers:[...])


// class TestDataModel extends ChangeNotifier {
//   var one = 0;
//   var two = 0;
//   void inc1() {
//     one += 1;
//     notifyListeners();
//   }

//   void inc2() {
//     two += 1;
//     notifyListeners();
//   }
// }

// class StateFWWrap extends StatefulWidget {
//   @override
//   State<StateFWWrap> createState() => _StateFWWrapState();
// }

// class _StateFWWrapState extends State<StateFWWrap> {
//   final model = TestDataModel();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: model,
//       child: App(),
//     ); // позволяет самому сделать диспоуз. иначе - эрор
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     model.dispose();
//     super.dispose();
//   }
// }

    // return ChangeNotifierProvider(
    //   create: (context) => TestDataModel(),
    //   child: App(),
    //   lazy:
    //       true, // модель создается при первом обращении. при первом рид или вотч
    // );

  // Provider.of<TestModel>(context, listen:true) // watch
  // Provider.of<TModel>(context, listen: false) // read


// при закрытии вызовит диспоуз
// перерисовывается все. сохраняется стейт. даже при стейтЛес при условии что модель не переменная, а => Модел(). changeNotifierProvider
// return ChangeNotifierProvider(
//       create: (context) => TestDataModel(),
//       child: App(),
//     );

// перерисовывается все. сохраняется стейт при хот релоад


// class TestDataModel extends ChangeNotifier {
//   var one = 0;
//   var two = 0;
//   void inc1() {
//     one += 1;
//     notifyListeners();
//   }

//   void inc2() {
//     two += 1;
//     notifyListeners();
//   }
// }

// class TestDataInherit extends InheritedNotifier {
//   final TestDataModel model;
//   const TestDataInherit({super.key, required this.model, required super.child})
//     : super(notifier: model);

//   static TestDataInherit? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<TestDataInherit>();
//   }

//   static TestDataInherit? read(BuildContext context) {
//     final w = context
//         .getElementForInheritedWidgetOfExactType<TestDataInherit>()
//         ?.widget;
//     return w is TestDataInherit ? w : null;
//   }
// }

// class StateFWWrap extends StatefulWidget {
//   @override
//   State<StateFWWrap> createState() => _StateFWWrapState();
// }

// class _StateFWWrapState extends State<StateFWWrap> {
//   final model = TestDataModel();

//   @override
//   Widget build(BuildContext context) {
//     return TestDataInherit(model: model, child: App());
//   }
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = TestDataInherit.read(context)!.model;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(onPressed: model.inc1, child: Text('Button 111')),
//         ElevatedButton(onPressed: model.inc2, child: Text('Button 222')),
//         ElevatedButton(onPressed: () {}, child: Text('Button 333')),
//         ElevatedButton(onPressed: () {}, child: Text('Button 444')),

//         //
//         TextDemoW1(),
//         TextDemoW2(),
//       ],
//     );
//   }
// }
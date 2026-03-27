// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyLessonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StateFWWrap());
  }
}

class TestDataModel extends ChangeNotifier {
  var one = 0;
  var two = 0;
  void inc1() {
    one += 1;
    notifyListeners();
  }

  void inc2() {
    two += 1;
    notifyListeners();
  }
}

class TestDataInherit extends InheritedNotifier {
  final TestDataModel model;
  const TestDataInherit({super.key, required this.model, required super.child})
    : super(notifier: model);

  static TestDataInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TestDataInherit>();
  }

  static TestDataInherit? read(BuildContext context) {
    final w = context
        .getElementForInheritedWidgetOfExactType<TestDataInherit>()
        ?.widget;
    return w is TestDataInherit ? w : null;
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
    return TestDataInherit(model: model, child: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TestDataInherit.read(context)!.model;
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
    final valueFromM = TestDataInherit.watch(context)!.model.one;
    return Text('$valueFromM');
  }
}

class TextDemoW2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final valueFromM = TestDataInherit.watch(context)!.model.two;
    return Text('$valueFromM');
  }
}


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
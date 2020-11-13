import 'package:book_flutter_7_1_setstate/count_repository.dart';
import 'package:flutter/material.dart';

import 'loading_widget0.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          // TODO それぞれのアーキテクチャ用の画面を追加していく
          ListTile(
            title: const Text("setStateの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage0(),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState Demo'),
      ),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  final repository = CountRepository();

  @override
  _HomePageState createState() => _HomePageState();
}

// 同期の場合は以下のクラスを利用していた
// class _HomePageState extends State<_HomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
// // 1 コンストラクタで_counter変数を渡している
//           _WidgetA(_counter),
//           _WidgetB(),
// // 2 コンストラクタで_incrementCounter関数を渡している _WidgetC(_incrementCounter),
//         ],
//       ),
//     );
//   }
// }

class _HomePageState extends State<_HomePage> {
  int _counter = 0;
  bool _isLoading = false;

// 1 このメソッドの可読性低下
  void _incrementCounter() async {
    setState(() {
      _isLoading = true;
    });
    widget.repository.fetch().then((increaseCount) {
      setState(() {
        _counter += increaseCount;
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _WidgetA(_counter),
            _WidgetB(),
            _WidgetC(_incrementCounter),
          ],
        ),
        LoadingWidget0(_isLoading),
      ],
    );
  }
}

class _WidgetA extends StatelessWidget {
  final int counter;

  _WidgetA(this.counter);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
      child: Text(
        '${counter}',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class _WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetB#build()");
    return const Text('I am a widget that will not be rebuilt.');
  }
}

class _WidgetC extends StatelessWidget {
  final void Function() incrementCounter;

  _WidgetC(this.incrementCounter);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    return RaisedButton(
      onPressed: () {
        incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}

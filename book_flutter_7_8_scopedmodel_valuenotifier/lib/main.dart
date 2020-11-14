import 'package:flutter/material.dart';

import 'count_repository.dart';
import 'counter_value.dart';
import 'loading_value.dart';
import 'loading_widget2.dart';

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
            title: const Text("Scoped Model(ValueNotifier)の場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage2_1(CountRepository(), LoadingValue()),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage2_1 extends StatelessWidget {
  final CountRepository repository;
  final LoadingValue loadingValue;

  TopPage2_1(this.repository, this.loadingValue);

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      repository: repository,
      loadingValue: loadingValue,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ValueNotifier Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WidgetA(),
            _WidgetB(),
            _WidgetC(),
          ],
        ),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  final CountRepository repository;
  final LoadingValue loadingValue;

  _HomePage({
    Key key,
    this.repository,
    this.loadingValue,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>()).data;
    }
    return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>().widget as _MyInheritedWidget).data;
  }
}

class _HomePageState extends State<_HomePage> {
// 1 Stateでロジックを保持
  CounterValue counter;

  @override
  void initState() {
    super.initState();
    counter = CounterValue(widget.repository, widget.loadingValue);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: Stack(
        children: <Widget>[
          widget.child,
          LoadingWidget2_1(widget.loadingValue),
        ],
      ),
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);
  final _HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
// 2 InheritedWidgetからStateクラスを取得。
// rebuild不要
    final state = _HomePage.of(context, rebuild: false);
    return Center(
// 3 ValueListenableBuilderでListen
      child: ValueListenableBuilder<int>(
        valueListenable: state.counter.valueNotifier,
        builder: (_context, count, _child) {
          return Text(
            '$count',
            style: Theme.of(context).textTheme.headline4,
          );
        },
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
  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    final state = _HomePage.of(context, rebuild: false);
    return RaisedButton(
      onPressed: () {
// 4 カウントアップ
        state.counter.incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

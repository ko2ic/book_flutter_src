import 'package:flutter/material.dart';

import 'count_repository.dart';
import 'counter_bloc.dart';
import 'loading_widget1.dart';

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
            title: const Text("BLoC+InheritedWidgetの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage3_1(CountRepository()),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage3_1 extends StatelessWidget {
  final CountRepository _repository;

  TopPage3_1(this._repository);

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      repository: _repository,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget BLoC Demo'),
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

  _HomePage({
    Key key,
    this.repository,
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
  CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc(widget.repository);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: Stack(
        children: <Widget>[
          widget.child,
          LoadingWidget1(counterBloc.isLoading),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    counterBloc.dispose();
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
    final state = _HomePage.of(context, rebuild: false);
    return Center(
        child: StreamBuilder(
      stream: state.counterBloc.value,
      builder: (context, snapshot) {
        return Text(
          '${snapshot.data}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    ));
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
        state.counterBloc.incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

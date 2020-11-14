import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            title: const Text("BLoC+providerの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage3_2(CountRepository()),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage3_2 extends StatelessWidget {
  final CountRepository _repository;

  TopPage3_2(this._repository);

  @override
  Widget build(BuildContext context) {
// 1 階層の上位にProviderがある
// BLoCのインスタンスもdisposeもProviderの関数内で呼び出される
    return Provider<CounterBloc>(
      create: (context) => CounterBloc(_repository),
      dispose: (_, bloc) => bloc.dispose(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('BLoC Demo'),
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
// 2 ConsumerでBLoCを取得できる
          Consumer<CounterBloc>(builder: (context, value, child) {
            return LoadingWidget1(value.isLoading);
          }),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
// 3 Provider.ofでBLoCを取得できる
    var bloc = Provider.of<CounterBloc>(context, listen: false);
    return Center(
      child: StreamBuilder<int>(
        stream: bloc.value,
        builder: (context, snapshot) {
          return Text(
            '${snapshot.data}',
            style: Theme.of(context).textTheme.display1,
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
    return RaisedButton(
      onPressed: () {
        Provider.of<CounterBloc>(context, listen: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'count_repository.dart';
import 'counter_model.dart';
import 'loading_model.dart';
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
            title: const Text("Scoped Modelの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage2(CountRepository(), LoadingModel()),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage2 extends StatelessWidget {
  final CountRepository _repository;
  final LoadingModel _loadingModel;

  TopPage2(this._repository, this._loadingModel);

  @override
  Widget build(BuildContext context) {
// 1 階層の上位にScopedModelをインスタンスし、Modelを設定する
    return ScopedModel<LoadingModel>(
      model: _loadingModel,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Scoped Model Demo'),
            ),
// 複数ある場合でもネスト可能
            body: ScopedModel<CounterModel>(
              model: CounterModel(_repository, _loadingModel),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _WidgetA(),
                  _WidgetB(),
                  _WidgetC(),
                ],
              ),
            ),
          ),
          const LoadingWidget2(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
// 2 ScopedModelDescendantを使ってlistenする
      child: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return Text(
            '${model.counter}',
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
    return RaisedButton(
      onPressed: () {
// 3 rebuildOnChangeをfalseにしているので取得だけ
        ScopedModel.of<CounterModel>(context, rebuildOnChange: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

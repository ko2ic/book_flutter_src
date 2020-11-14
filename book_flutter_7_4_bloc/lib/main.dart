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
            title: const Text("BLoCの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage3_0(),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage3_0 extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage3_0> {
  CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc(CountRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('BLoc Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WidgetA(counterBloc),
              _WidgetB(),
              _WidgetC(counterBloc),
            ],
          ),
        ),
        LoadingWidget1(counterBloc.isLoading),
      ],
    );
  }

  @override
  void dispose() {
// 5 メモリリークさせないため
    counterBloc.dispose();
    super.dispose();
  }
}

class _WidgetA extends StatelessWidget {
  final CounterBloc counterLogic;

  _WidgetA(this.counterLogic);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
// 4 ボタン押下でこのクラス以下だけが再構築される
        child: StreamBuilder(
// 3 Streamを渡す
      stream: counterLogic.value,
      builder: (context, snapshot) {
        return Text(
          '${snapshot.data}',
          style: Theme.of(context).textTheme.display1,
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
  final CounterBloc counterBloc;

  _WidgetC(this.counterBloc);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    return RaisedButton(
      onPressed: () {
        counterBloc.incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

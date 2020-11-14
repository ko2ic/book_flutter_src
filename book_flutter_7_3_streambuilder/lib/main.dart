import 'package:flutter/material.dart';

import 'counter_logic.dart';

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
            title: const Text("StreamBuilderの場合"),
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
  CounterLogic counterLogic;

  @override
  void initState() {
    super.initState();
    counterLogic = CounterLogic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoc Simple Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
// 1 Logicクラスのインスタンスを渡す
          _WidgetA(counterLogic),
          _WidgetB(),
// 2 Logicクラスのインスタンスを渡す
          _WidgetC(counterLogic),
        ],
      ),
    );
  }

  @override
  void dispose() {
// 5 メモリリークさせないため
    counterLogic.dispose();
    super.dispose();
  }
}

class _WidgetA extends StatelessWidget {
  final CounterLogic counterLogic;

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
  final CounterLogic counterLogic;

  _WidgetC(this.counterLogic);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    return RaisedButton(
      onPressed: () {
        counterLogic.incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'count_repository.dart';
import 'counter_value2.dart';
import 'loading_value2.dart';
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
            title: const Text("scopedmodel+providerの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage2_2(CountRepository()),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage2_2 extends StatelessWidget {
  final CountRepository _repository;

  TopPage2_2(this._repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
// 1 Providerの代わりにChangeNotifierProviderを使う // builderはChangeNotifier型を強要する
        ChangeNotifierProvider<LoadingValue2>(
          create: (_) => LoadingValue2(),
        ),
        ChangeNotifierProvider<CounterValue2>(
          create: (context) {
            var loading = Provider.of<LoadingValue2>(context, listen: false);
            return CounterValue2(_repository, loading);
          },
        ),
// CounterValueでChangeNotifierを使った場合は以下
//         ChangeNotifierProvider<LoadingValue3>(
//           create: (_) => LoadingValue3(),
//         ),
//         ChangeNotifierProvider<CounterValue3>(
//           create: (context) {
//             var loading = Provider.of<LoadingValue3>(context, listen: false);
//             return CounterValue3(_repository, loading);
//           },
//         ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('ValueNotifier+Provider Demo'),
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
          const LoadingWidget2_2(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
// 2 ValueListenableBuilderを使うのでlistenはfalseにする
    var logic = Provider.of<CounterValue2>(context, listen: false);
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: logic,
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

// CounterValueでChangeNotifierを使った場合は以下
// class _WidgetA extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("called _WidgetA#build()");
//     var logic = Provider.of<CounterValue3>(context, listen: true);
//     return Center(
//       child: Text(
//         '${logic.counter}',
//         style: Theme.of(context).textTheme.headline4,
//       ),
//     );
//   }
// }

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
        Provider.of<CounterValue2>(context, listen: false).incrementCounter();
      },
      child: const Icon(Icons.add),
    );
  }
}

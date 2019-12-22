import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountPage(),
    );
  }
}

class CountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('isolate Demo'),
      ),
      body: Provider<CounterBloc>(
        create: (_) => CounterBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DisplayWidget(),
            CountUpWidget(),
          ],
        ),
      ),
    );
  }
}

class DisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

class CountUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Provider.of<CounterBloc>(context, listen: false).incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}

class CounterBloc {
  int _counter = 0;

  CounterBloc() {
    _valueController.sink.add(_counter);
  }

  final _valueController = StreamController<int>();

  Stream<int> get value => _valueController.stream;

  void incrementCounter() async {
    // ここが遅い
    //fib(42);
    await compute(fib, 42);
    _valueController.sink.add(++_counter);
  }

  static int fib(int n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
  }

  void dispose() {
    _valueController.close();
  }
}

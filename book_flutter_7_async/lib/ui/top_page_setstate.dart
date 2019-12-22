import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/loading_widget_setstate.dart';

class TopPage0 extends StatefulWidget {
  final CountRepository repository;

  TopPage0(this.repository);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage0> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() {
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
        Scaffold(
          appBar: AppBar(
            title: const Text('setState Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WidgetA(_counter),
              _WidgetB(),
              _WidgetC(_incrementCounter),
            ],
          ),
        ),
        LoadingWidget0(isLoading: _isLoading),
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
        '$counter',
        key: const Key("Text of setState"),
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
      key: const Key("Button of setState"),
      onPressed: incrementCounter,
      child: Icon(Icons.add),
    );
  }
}

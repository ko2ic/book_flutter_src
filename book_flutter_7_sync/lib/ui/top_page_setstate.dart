import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _WidgetA(_counter),
          _WidgetB(),
          _WidgetC(_incrementCounter),
        ],
      ),
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
      onPressed: incrementCounter,
      child: Icon(Icons.add),
    );
  }
}

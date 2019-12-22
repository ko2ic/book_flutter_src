import 'dart:async';

class CounterBloc {
  int _counter = 0;

  CounterBloc() {
    _valueController.sink.add(_counter);
  }

  final _valueController = StreamController<int>();

  Stream<int> get value => _valueController.stream;

  void incrementCounter() async {
    _valueController.sink.add(++_counter);
  }

  void dispose() {
    _valueController.close();
  }
}

import 'dart:async';

class CounterLogic {
  final _valueController = StreamController<int>();

  Stream<int> get value => _valueController.stream;
  int _counter = 0;

  CounterLogic() {
    _valueController.sink.add(_counter);
  }

  void incrementCounter() async {
    _valueController.sink.add(++_counter);
  }

  void dispose() {
    _valueController.close();
  }
}

import 'dart:async';

import 'count_repository.dart';

class CounterBloc {
  final CountRepository _repository;
  final _valueController = StreamController<int>();
  final _loadingController = StreamController<bool>();

  Stream<int> get value => _valueController.stream;

  Stream<bool> get isLoading => _loadingController.stream;
  int _counter = 0;

  CounterBloc(this._repository) {
    _valueController.sink.add(_counter);
    _loadingController.sink.add(false);
  }

  void incrementCounter() async {
    _loadingController.sink.add(true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingController.sink.add(false);
    });
    _counter += increaseCount;
    _valueController.sink.add(_counter);
  }

  void dispose() {
    _valueController.close();
    _loadingController.close();
  }
}

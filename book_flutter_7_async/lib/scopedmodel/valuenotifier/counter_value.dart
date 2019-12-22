import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter/foundation.dart';

import 'loading_value.dart';

class CounterValue {
  final CountRepository _repository;
  final LoadingValue _loadingValue;

  CounterValue(this._repository, this._loadingValue);

  final valueNotifier = ValueNotifier<int>(0);

  void incrementCounter() async {
    _loadingValue.loading(isLoading: true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingValue.loading(isLoading: false);
    });
    valueNotifier.value += increaseCount;
  }
}

class CounterValue2 extends ValueNotifier<int> {
  final CountRepository _repository;
  final LoadingValue2 _loadingValue;

  CounterValue2(this._repository, this._loadingValue) : super(0);

  void incrementCounter() async {
    _loadingValue.loading(isLoading: true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingValue.loading(isLoading: false);
    });
    super.value += increaseCount;
  }
}

class CounterValue3 with ChangeNotifier {
  final CountRepository _repository;
  final LoadingValue3 _loadingValue;

  CounterValue3(this._repository, this._loadingValue);

  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() async {
    _loadingValue.loading(isLoading: true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingValue.loading(isLoading: false);
    });
    _counter += increaseCount;
    notifyListeners();
  }
}

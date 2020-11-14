import 'package:flutter/material.dart';

import 'count_repository.dart';
import 'loading_value.dart';

class CounterValue {
  final CountRepository _repository;
  final LoadingValue _loadingValue;

  CounterValue(this._repository, this._loadingValue);

// 1
  final valueNotifier = ValueNotifier<int>(0);

  void incrementCounter() async {
    _loadingValue.loading(true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingValue.loading(false);
    });
// 2
    valueNotifier.value += increaseCount;
  }
}

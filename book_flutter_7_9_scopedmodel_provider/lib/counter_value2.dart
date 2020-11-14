import 'package:flutter/material.dart';

import 'count_repository.dart';
import 'loading_value2.dart';

class CounterValue2 extends ValueNotifier<int> {
  final CountRepository _repository;
  final LoadingValue2 _loadingValue;

  CounterValue2(this._repository, this._loadingValue) : super(0);

  void incrementCounter() async {
    _loadingValue.loading(true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingValue.loading(false);
    });
    super.value += increaseCount;
  }
}

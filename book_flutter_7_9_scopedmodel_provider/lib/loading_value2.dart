import 'package:flutter/material.dart';

class LoadingValue2 extends ValueNotifier<bool> {
  LoadingValue2() : super(false);

  loading(bool isLoading) {
    super.value = isLoading;
  }
}

class LoadingValue3 with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  loading({bool isLoading = false}) {
    _isLoading = isLoading;
    notifyListeners();
  }
}

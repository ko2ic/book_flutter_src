import 'package:flutter/foundation.dart';

class LoadingValue {
  final isLoading = ValueNotifier<bool>(false);

  loading({bool isLoading = false}) {
    this.isLoading.value = isLoading;
  }
}

// ValueListenableProviderの場合
class LoadingValue2 extends ValueNotifier<bool> {
  LoadingValue2() : super(false);

  loading({bool isLoading = false}) {
    super.value = isLoading;
  }
}

// ChangeNotifierProviderの場合
class LoadingValue3 with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  loading({bool isLoading = false}) {
    _isLoading = isLoading;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class LoadingValue2 extends ValueNotifier<bool> {
  LoadingValue2() : super(false);

  loading(bool isLoading) {
    super.value = isLoading;
  }
}

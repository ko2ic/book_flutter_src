import 'package:flutter/material.dart';

class LoadingValue {
  final isLoading = ValueNotifier<bool>(false);

  loading(bool isLoading) {
    this.isLoading.value = isLoading;
  }
}

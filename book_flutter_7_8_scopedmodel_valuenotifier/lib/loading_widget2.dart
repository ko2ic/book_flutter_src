import 'package:flutter/material.dart';

import 'loading_value.dart';

class LoadingWidget2_1 extends StatelessWidget {
  final LoadingValue value;

  const LoadingWidget2_1(this.value);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: value.isLoading,
      builder: (_context, isLoading, _child) {
        return (isLoading)
            ? const DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0x44000000),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

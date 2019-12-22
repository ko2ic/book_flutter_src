import 'package:book_flutter_7_async/scopedmodel/valuenotifier/loading_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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

class LoadingWidget2_2 extends StatelessWidget {
  const LoadingWidget2_2();

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<LoadingValue2>(context);
    return (logic.value)
        ? const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0x44000000),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox.shrink();
  }
}

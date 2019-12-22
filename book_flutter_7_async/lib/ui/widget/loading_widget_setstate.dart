import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget0 extends StatelessWidget {
  final bool isLoading;

  const LoadingWidget0({this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
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

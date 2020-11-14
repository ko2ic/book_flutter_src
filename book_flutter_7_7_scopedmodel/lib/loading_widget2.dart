import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'loading_model.dart';

class LoadingWidget2 extends StatelessWidget {
  const LoadingWidget2();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, LoadingModel model) {
        return (model.value)
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

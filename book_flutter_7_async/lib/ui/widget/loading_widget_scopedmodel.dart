import 'package:book_flutter_7_async/scopedmodel/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

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

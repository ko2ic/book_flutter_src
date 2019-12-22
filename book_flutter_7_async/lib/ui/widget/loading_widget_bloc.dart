import 'package:book_flutter_7_async/bloc/loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoadingWidget3 extends StatelessWidget {
  const LoadingWidget3();

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<LoadingBloc>(context);
    return StreamBuilder<bool>(
        initialData: false,
        stream: bloc.value,
        builder: (context, snapshot) {
          return (snapshot.data)
              ? const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0x44000000),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        });
  }
}

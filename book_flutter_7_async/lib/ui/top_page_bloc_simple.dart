import 'package:book_flutter_7_async/bloc/counter_bloc.dart';
import 'package:book_flutter_7_async/bloc/loading_bloc.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/loading_widget_streambuilder.dart';

class TopPage3_0 extends StatefulWidget {
  final CountRepository repository;

  TopPage3_0(this.repository);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage3_0> {
  LoadingBloc loadingBloc;
  CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    loadingBloc = LoadingBloc();
    counterBloc = CounterBloc(widget.repository, loadingBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text('BLoc Simple Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WidgetA(counterBloc),
              _WidgetB(),
              _WidgetC(counterBloc),
            ],
          ),
        ),
        LoadingWidget1(loadingBloc.value),
      ],
    );
  }
}

class _WidgetA extends StatelessWidget {
  final CounterBloc counterBloc;

  _WidgetA(this.counterBloc);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
        child: StreamBuilder(
      stream: counterBloc.value,
      builder: (context, snapshot) {
        return Text(
          '${snapshot.data}',
          style: Theme.of(context).textTheme.display1,
        );
      },
    ));
  }
}

class _WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetB#build()");
    return const Text('I am a widget that will not be rebuilt.');
  }
}

class _WidgetC extends StatelessWidget {
  final CounterBloc counterBloc;

  _WidgetC(this.counterBloc);

  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    return RaisedButton(
      onPressed: counterBloc.incrementCounter,
      child: Icon(Icons.add),
    );
  }
}

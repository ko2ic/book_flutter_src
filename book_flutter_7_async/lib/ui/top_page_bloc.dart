import 'package:book_flutter_7_async/bloc/counter_bloc.dart';
import 'package:book_flutter_7_async/bloc/loading_bloc.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'widget/loading_widget_bloc.dart';

class TopPage3 extends StatelessWidget {
  final CountRepository _repository;

  TopPage3(this._repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoadingBloc>(
          create: (_) => LoadingBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<CounterBloc>(
          create: (context) {
            var bloc = Provider.of<LoadingBloc>(context, listen: false);
            return CounterBloc(_repository, bloc);
          },
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('BLoC Demo'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _WidgetA(),
                _WidgetB(),
                _WidgetC(),
              ],
            ),
          ),
          const LoadingWidget3(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    var bloc = Provider.of<CounterBloc>(context, listen: false);
    return Center(
      child: StreamBuilder<int>(
        initialData: 0,
        stream: bloc.value,
        builder: (context, snapshot) {
          return Text(
            '${snapshot.data}',
            style: Theme.of(context).textTheme.headline4,
          );
        },
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    print("called _WidgetC#build()");
    return RaisedButton(
      onPressed: () {
        Provider.of<CounterBloc>(context, listen: false).incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}

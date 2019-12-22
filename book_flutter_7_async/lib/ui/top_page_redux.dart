import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:book_flutter_7_async/redux/middleware/counter_middleware.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';

import '../redux/action/actions.dart';
import '../redux/reducer/app_state_reducer.dart';
import '../redux/state/app_state.dart';
import 'widget/loading_widget_redux.dart';

@immutable
class TopPage4 extends StatelessWidget {
  final CountRepository _repository;

  final Store<AppState> store;

  TopPage4(this._repository)
      : store = Store<AppState>(
          appStateReducer,
          initialState: const AppState(),
          middleware: counterMiddleware(_repository),
        );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Redux Demo'),
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
          const LoadingWidget4(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
      child: StoreConnector<AppState, int>(
        converter: (store) => store.state.counter,
        builder: (context, counter) {
          return Text(
            '$counter',
            style: Theme.of(context).textTheme.display1,
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
        var store = StoreProvider.of<AppState>(context);
        store.dispatch(CountUpAction(store.state.counter));
      },
      child: Icon(Icons.add),
    );
  }
}

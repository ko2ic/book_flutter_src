import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/action/count_up_action.dart';
import '../redux/reducer/app_state_reducer.dart';
import '../redux/state/app_state.dart';

@immutable
class TopPage4 extends StatelessWidget {
  final store = Store<AppState>(
    appStateReducer,
    initialState: const AppState(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redux Demo'),
      ),
      body: StoreProvider(
        store: store,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WidgetA(),
            _WidgetB(),
            _WidgetC(),
          ],
        ),
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

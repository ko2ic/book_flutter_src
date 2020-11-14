import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'action/actions.dart';
import 'loading_widget4.dart';
import 'middleware/counter_middleware.dart';
import 'reducer/app_state_reducer.dart';
import 'repository/count_repository.dart';
import 'state/app_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CountRepository _repository = CountRepository();

  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Reduxの場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage4(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

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
        var store = StoreProvider.of<AppState>(context);
        store.dispatch(CountUpAction(store.state.counter));
      },
      child: const Icon(Icons.add),
    );
  }
}

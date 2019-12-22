import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:book_flutter_7_async/scopedmodel/counter_model.dart';
import 'package:book_flutter_7_async/scopedmodel/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'widget/loading_widget_scopedmodel.dart';

class TopPage2 extends StatelessWidget {
  final CountRepository _repository;
  final LoadingModel _loadingModel;

  TopPage2(this._repository, this._loadingModel);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _loadingModel,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Scoped Model Demo'),
            ),
            body: ScopedModel(
              model: CounterModel(_repository, _loadingModel),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _WidgetA(),
                  _WidgetB(),
                  _WidgetC(),
                ],
              ),
            ),
          ),
          const LoadingWidget2(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");

// こっちの書き方だとbuildメソッドがリビルドさせる
//    var model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
//    return Center(
//      child: Text(
//        '${model.counter}',
//        style: Theme.of(context).textTheme.display1,
//      ),
//    );

    // こっちは、builderの中だけリビルドされる
    return Center(
      child: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return Text(
            '${model.counter}',
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
    // この場合は、リビルドする必要がないのでこの書き方の方がシンプル
    return RaisedButton(
      onPressed: () {
        ScopedModel.of<CounterModel>(context, rebuildOnChange: false).incrementCounter();
      },
      child: Icon(Icons.add),
    );

//    return ScopedModelDescendant<CounterModel>(
//      rebuildOnChange: false,
//      builder: (context, child, model) {
//        return RaisedButton(
//          onPressed: () {
//            model.incrementCounter();
//          },
//          child: Icon(Icons.add),
//        );
//      },
//    );
  }
}

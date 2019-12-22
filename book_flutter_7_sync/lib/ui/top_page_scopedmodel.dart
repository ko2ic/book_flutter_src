import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:book_flutter_7_sync/scopedmodel/counter_model.dart';

class TopPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoped Model Demo'),
      ),
      body: ScopedModel(
        model: CounterModel(),
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

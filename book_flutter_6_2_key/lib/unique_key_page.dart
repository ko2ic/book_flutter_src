import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UniqueKeySamplePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UniqueKeySamplePageState();
  }
}

class UniqueKeySamplePageState extends State<UniqueKeySamplePage> {
// StatelessWidgetの場合 => 一度だけしかインスタンスされないので成功
//  List<Widget> titles = [
//    StatelessRandomTitle(),
//    StatelessRandomTitle(),
//  ];

// StatefulWidgetの場合 => 同じウィジェットと判断され入れ替えがされない
//  List<Widget> titles = [
//    StatefulRandomTitle(),
//    StatefulRandomTitle(),
//  ];

// StatefulWidgetでもKeyが違う場合 => 入れ替え処理成功
  List<Widget> titles = [
    StatefulRandomTitle(key: const Key("1")),
    StatefulRandomTitle(key: const Key("2")),
  ];

// Keyの指定場所が間違っている場合 => 再構築される。ランダム値が再度生成されてしまう
//  List<Widget> titles = [
//    Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: StatefulRandomTitle(key: UniqueKey()),
//    ),
//    Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: StatefulRandomTitle(key: UniqueKey()),
//    ),
//  ];

// Keyの指定場所が正しいので成功
//  List<Widget> titles = [
//    Padding(
//      key: UniqueKey(),
//      padding: const EdgeInsets.all(8.0),
//      child: StatefulRandomTitle(),
//    ),
//    Padding(
//      key: UniqueKey(),
//      padding: const EdgeInsets.all(8.0),
//      child: StatefulRandomTitle(),
//    ),
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Unique Key Sample"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(child: const Text("入れ替える"), onPressed: swapTitles),
            Column(children: titles),
          ],
        ));
  }

  swapTitles() {
    setState(() {
      titles.insert(1, titles.removeAt(0));
    });
  }
}

class StatefulRandomTitle extends StatefulWidget {
  StatefulRandomTitle({Key key}) : super(key: key);

  @override
  StatefulRandomTitleState createState() => StatefulRandomTitleState();
}

class StatefulRandomTitleState extends State<StatefulRandomTitle> {
  int random;

  @override
  void initState() {
    super.initState();
    random = Random().nextInt(1000);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(random.toString()),
    );
  }
}

// statelessの場合は以下

class StatelessRandomTitle extends StatelessWidget {
  final random = Random().nextInt(1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(random.toString()),
        ),
        const Divider(),
      ],
    );
  }
}

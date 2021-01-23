import 'dart:math';

import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isSuccessful = false;

  final _random = Random();

  final _colors = [
    Colors.green,
    Colors.yellow,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    var _color = _colors[_random.nextInt(3)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('緑だけドロップ可能'),
            Draggable<Color>(
                // この値がDragTargetに渡される
                data: _color,
                // ドラッグ前のウィジェットを指定
                child: FlutterLogo(
                  size: 100.0,
                  style: FlutterLogoStyle.stacked,
                  textColor: _color,
                ),
                // ドラッグ中に移動するウィジェットを指定
                feedback: FlutterLogo(
                  size: 150.0,
                  textColor: _color,
                ),
                // ドラッグ中に元の場所に表示するウィジェット
                childWhenDragging: const FlutterLogo(
                  size: 100.0,
                  style: FlutterLogoStyle.stacked,
                  textColor: Colors.grey,
                ),
                // ドロップできなかった場合の処理
                onDraggableCanceled: (
                  Velocity velocity,
                  Offset offset,
                ) {
                  setState(() {
                    isSuccessful = false;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            DragTarget(
              // DragTargetのウィジェットを指定
              builder: (
                context,
                List<Color> candidateData,
                rejectedData,
              ) {
                return Center(
                  child: isSuccessful
                      ? Container(
                          color: Colors.black,
                          height: 100.0,
                          width: 100.0,
                          child: const Center(
                            child: FlutterLogo(
                              size: 100.0,
                              style: FlutterLogoStyle.stacked,
                              textColor: Colors.green,
                            ),
                          ),
                        )
                      : Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.black,
                        ),
                );
              },
              // 受け取り可能かを判断
              onWillAccept: (Color data) {
                return data == Colors.green;
              },
              // 受け取り成功した時の処理
              onAccept: (Color data) {
                setState(() {
                  isSuccessful = true;
                });
              },
              // DraggableがDragTarget上に乗ってから外れた場合
              onLeave: print,
            ),
          ],
        ),
      ),
    );
  }
}

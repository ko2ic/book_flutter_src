import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SampleWidget(
        // (1) ここを変更してホットリロード
        center: false,
        child: MyText('Sample'),
      ),
    );
  }
}

class SampleWidget extends StatefulWidget {
  const SampleWidget({Key key, this.center, this.child}) : super(key: key);

  final Widget child;
  final bool center;

  @override
  _SampleWidgetState createState() => _SampleWidgetState();
}

class _SampleWidgetState extends State<SampleWidget> {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // (2-1) GlobalKeyを使わない場合は(3)が呼ばれる
    final child = widget.child;
    // (2-2) GlobalKeyを使う場合は(3)が呼ばれない
    //final child = KeyedSubtree(key: key, child: widget.child);

    if (widget.center) {
      return Center(child: child);
    }
    return child;
  }
}

class MyText extends Text {
  MyText(String data) : super(data);

  @override
  StatelessElement createElement() {
    // (3) Keyを使わないと変更->ホットリロードのたびに呼ばれる
    // Debug用にオーバーライドしてるだけ
    print('called MyText#createElement()');
    return super.createElement();
  }
}

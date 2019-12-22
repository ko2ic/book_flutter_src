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
      home: MyHomePage(title: 'ReorderableListView'),
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
  final _items = Iterable.generate(20).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > _items.length) {
                newIndex = _items.length;
              }
              if (oldIndex < newIndex) {
                newIndex--;
              }
              var item = _items[oldIndex];
              _items.remove(item);
              _items.insert(newIndex, item);
            });
          },
          header: const Text('ReorderableListViewのサンプル'),
          children: <Widget>[
            for (var item in _items)
              ListTile(
                key: ValueKey(item),
                title: Text(item.toString()),
              ),
          ],
        ),
      ),
    );
  }
}

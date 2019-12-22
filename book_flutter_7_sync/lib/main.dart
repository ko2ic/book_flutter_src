import 'package:book_flutter_7_sync/ui/top_page_bloc.dart';
import 'package:book_flutter_7_sync/ui/top_page_inheritedwidget.dart';
import 'package:book_flutter_7_sync/ui/top_page_redux.dart';
import 'package:book_flutter_7_sync/ui/top_page_scopedmodel.dart';
import 'package:book_flutter_7_sync/ui/top_page_setstate.dart';
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

class MyHomePage extends StatelessWidget {
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
            title: const Text("setStateの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage0(),
                    fullscreenDialog: true,
                  ));
            },
          ),
          ListTile(
            title: const Text("InheritedWidgetの場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage1(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Sceoped Modelの場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage2(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoCの場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage3(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Reduxの場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage4(),
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

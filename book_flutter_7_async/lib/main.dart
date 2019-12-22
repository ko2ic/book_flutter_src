import 'package:book_flutter_7_async/scopedmodel/valuenotifier/loading_value.dart';
import 'package:book_flutter_7_async/ui/top_page_bloc.dart';
import 'package:book_flutter_7_async/ui/top_page_inheritedwidget.dart';
import 'package:book_flutter_7_async/ui/top_page_redux.dart';
import 'package:book_flutter_7_async/ui/top_page_scopedmodel.dart';
import 'package:book_flutter_7_async/ui/top_page_scopedmodel_provider.dart';
import 'package:book_flutter_7_async/ui/top_page_setstate.dart';
import 'package:book_flutter_7_async/ui/top_page_valuenotifier.dart';
import 'package:flutter/material.dart';

import 'repository/count_repository.dart';
import 'scopedmodel/loading_model.dart';
import 'ui/top_page_bloc_inheritedwidget.dart';
import 'ui/top_page_bloc_simple.dart';

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

  final LoadingModel _loadingModel = LoadingModel();

  final _loadingValue = LoadingValue();

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
            key: const Key("in case of setState"),
            title: const Text("setStateの場合"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage0(_repository),
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
                  builder: (context) => TopPage1(_repository),
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
                  builder: (context) => TopPage2(_repository, _loadingModel),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Scoped Model(ValueNotifier+InheritedWidget)の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage2_1(_repository, _loadingValue),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Sceoped Model(Provider)の場合"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage2_2(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoCの場合(Provider利用)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage3(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoCの場合(blocをコンストラクタで渡すパターン)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage3_0(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("BLoCの場合(InheritedWidgetでのパターン)"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage3_1(_repository),
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

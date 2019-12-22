// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

enum IndicatorType { overscroll, refresh }

class ListsPage extends StatefulWidget {
  const ListsPage({Key key}) : super(key: key);

  static const String routeName = '/material/overscroll';

  @override
  ListsPageState createState() => ListsPageState();
}

class ListsPageState extends State<ListsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  static final List<String> _items = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N'];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: kMaterialListPadding,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _items[index];
          return ListTile(
            isThreeLine: true,
            leading: CircleAvatar(child: Text(item)),
            title: Text('This item represents $item.'),
            subtitle: const Text('Even more additional list item information appears on line three.'),
          );
        },
      ),
    );
  }

  Future<void> _handleRefresh() {
    final completer = Completer<void>();
    Timer(const Duration(seconds: 3), completer.complete);
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              leading: CupertinoButton(
                child: Icon(
                  Icons.add_alarm,
                ),
                onPressed: () {},
              ),
              largeTitle: Text(
                "Title",
                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                      color: Colors.white,
                    ),
              ),
              trailing: CupertinoButton(
                  child: Icon(
                    Icons.title,
                  ),
                  onPressed: () {}),
              backgroundColor: Colors.blue,
              actionsForegroundColor: Colors.white,
            ),
            SliverFillRemaining(child: Container()),
          ],
        ),
      ),
    );
  }
}

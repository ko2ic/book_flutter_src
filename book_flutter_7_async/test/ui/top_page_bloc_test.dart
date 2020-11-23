import 'package:book_flutter_7_async/ui/top_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_stub/count_repository_stub.dart';

void main() {
  testWidgets('BLoCのカウントアップ画面のテスト', (WidgetTester tester) async {
    var _repository = CountRepositoryStub();
// 1 引数のWidgetをレンダリングする
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
// 2 TopPage3単体では、MaterialAppが親にいないのでここで指定する
// 本番コードではMyAppから遷移してくるので存在している
          return MaterialApp(
            home: TopPage3(_repository),
          );
        },
      ),
    );
// 3 Widgetを再ビルドする
// counterの初期値の0を表示させるため
// 4 テキストの0が1つあり、10がないことを検証
    expect(find.text('0'), findsOneWidget);
    expect(find.text('10'), findsNothing);
// 5 Icons.addをtapする
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
// 6 tap後を検証
    expect(find.text('0'), findsNothing);
    expect(find.text('10'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('10'), findsNothing);
    expect(find.text('20'), findsOneWidget);
  });
}

import 'package:book_flutter_7_async/ui/top_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_stub/count_repository_stub.dart';

void main() {
  testWidgets('BLoCのカウントアップ画面のテスト', (WidgetTester tester) async {
    var _repository = CountRepositoryStub();

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: TopPage3(_repository),
          );
        },
      ),
    );

    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('10'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('10'), findsNothing);
    expect(find.text('20'), findsOneWidget);
  });
}

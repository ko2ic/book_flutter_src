import 'package:book_flutter_7_async/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePageのテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: MyHomePage(
              title: "Test Page Title",
            ),
          );
        },
      ),
    );
// 1 KeyでWidgetを取得している
    await tester.tap(find.byKey(const Key("in case of setState")));
// 2 画面遷移のアニメーションが終わるのを待つ
    await tester.pumpAndSettle();
// 3 次の画面に遷移したことを検証
    expect(find.text('setState Demo'), findsOneWidget);
    expect(find.text('Test Page Title'), findsNothing);
// 4 元の画面に戻るため、「setState Demo」画面のcloseアイコンをタップ
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
// 5 元の画面(テスト対象の画面)に戻ったことを検証
    expect(find.text('Test Page Title'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_flutter_7_async/main.dart';

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

    await tester.tap(find.byKey(const Key("in case of setState")));
    await tester.pumpAndSettle();

    expect(find.text('setState Demo'), findsOneWidget);
    expect(find.text('Test Page Title'), findsNothing);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('Test Page Title'), findsOneWidget);
  });
}

import 'package:book_flutter_7_async/ui/widget/loading_widget_setstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('isLoadingがtrueの場合', (WidgetTester tester) async {
    final target = const LoadingWidget0(isLoading: true);
// 1 pumpWidgetに対象のWidgetを設定するだけ
    await tester.pumpWidget(target);
    expect(find.byWidget(target), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('isLoadingがfalseの場合', (WidgetTester tester) async {
    final target = const LoadingWidget0(isLoading: false);
    await tester.pumpWidget(target);
    expect(find.byWidget(target), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

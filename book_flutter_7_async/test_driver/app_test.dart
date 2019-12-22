import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final listTitleFinder = find.byValueKey('in case of setState');
    final counterTextFinder = find.byValueKey('Text of setState');

    final buttonFinder = find.byValueKey('Button of setState');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final health = await driver.checkHealth();
      if (health.status == HealthStatus.bad) {
        fail("Flutter Driver extension disabled");
      }
      await Directory('./test_driver/screenshots').create();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('setState画面に遷移する', () async {
      await _screenshot(driver, "MyHomePage.png");
      await driver.tap(listTitleFinder);
      await _screenshot(driver, "TopPage0.png");
    });

    test('最初のカウントは0', () async {
      expect(await driver.getText(counterTextFinder), "0");
      await _screenshot(driver, "TopPage0_before_countup.png");
    });

    test('ボタンを押下してカウントアップ', () async {
      final timeline = await driver.traceAction(() async {
        await driver.tap(buttonFinder);
        expect(await driver.getText(counterTextFinder), "1");
      });

      final summary = TimelineSummary.summarize(timeline);
      await summary.writeSummaryToFile('tap_summary', pretty: true);
      await summary.writeTimelineToFile('tap_summary', pretty: true);

      await _screenshot(driver, "TopPage0_after_countup.png");
    });
  });
}

Future<void> _screenshot(FlutterDriver driver, String fileName) async {
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final file = File("./test_driver/screenshots/$fileName");
  await file.writeAsBytes(pixels);
}

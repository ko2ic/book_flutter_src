import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
// 1 操作・検証したいWidgetを取得する。
// SerializableFinderクラスが戻り値
    final listTitleFinder = find.byValueKey('in case of setState');
    final counterTextFinder = find.byValueKey('Text of setState');
    final buttonFinder = find.byValueKey('Button of setState');
    FlutterDriver driver;
    setUpAll(() async {
// 2 テストをする前にアプリに接続
      driver = await FlutterDriver.connect();
// 3 enableFlutterDriverExtension()が呼ばれているかの検証
      final health = await driver.checkHealth();
      if (health.status == HealthStatus.bad) {
        fail("Flutter Driver extension disabled");
      }
// 4 スクリーンショット画像を保存するディレクトリ
      await Directory('./test_driver/screenshots').create();
    });
    tearDownAll(() async {
// 5 テスト終了後に切断
      if (driver != null) {
        driver.close();
      }
    });
// 6 以下順番に実行される
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
      await driver.tap(buttonFinder);
      expect(await driver.getText(counterTextFinder), "1");
      await _screenshot(driver, "TopPage0_after_countup.png");

      // プロファイル出力の場合以下
// // 1 プロファイリングしたい処理をtraceAction()の引数に渡す
//       final timeline = await driver.traceAction(() async { await driver.tap(buttonFinder);
//       expect(await driver.getText(counterTextFinder), "1");
//       });
// // 2 結果を確認するためにTimelineSummaryに変換
//       final summary = TimelineSummary.summarize(timeline);
// // 3 tap_summary.timeline_summary.jsonとして保存
//       await summary.writeSummaryToFile('tap_summary', pretty: true);
// // 4 tap_summary.timeline.jsonとして保存
// // chrome://tracingでloadできるjson
//       await summary.writeTimelineToFile('tap_summary', pretty: true);
//       await _screenshot(driver, "TopPage0_after_countup.png");
    });
  });
}

// 7 スクリーンショット画像を保存する処理
Future<void> _screenshot(FlutterDriver driver, String fileName) async {
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final file = File("./test_driver/screenshots/$fileName");
  await file.writeAsBytes(pixels);
}

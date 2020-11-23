import 'package:book_flutter_8_test_tips/counter.dart';
import 'package:test/test.dart';

void main() {
// 1 test関数でtestを記述
  test('Counter value should be incremented', () {
    final counter = Counter();
    counter.increment();
// 2 expect関数で検証
    expect(counter.value, 1);
  });
}

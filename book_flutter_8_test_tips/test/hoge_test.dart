import 'package:book_flutter_8_test_tips/hoge.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHoge1 extends Mock implements Hoge1 {}

class MockHoge2 extends Mock implements Hoge2 {}

class MockHoge3 extends Mock implements Hoge3 {}

main() {
  test('fuga1()', () {
    var mockHoge = MockHoge1();
    var target = Fuga1(mockHoge);
    when(mockHoge.doNothing()).thenReturn(null);
    target.fuga1();

    verify(mockHoge.doNothing());
  });

  test('fuga2()', () {
    var mockHoge = MockHoge2();
    var target = Fuga2(mockHoge);

    when(mockHoge.methodA(nameA: anyNamed("nameA"))).thenReturn("1");

    target.fuga2();

    verify(mockHoge.methodA(
      nameA: argThat(equals("fuga"), named: "nameA"),
    ));
  });

  test('fuga3()', () {
    var mockHoge = MockHoge3();
    var target = Fuga3(mockHoge);

    when(mockHoge.methodB(any)).thenAnswer((Invocation invocation) {
      var func = invocation.positionalArguments.first;
      return func();
    });

    // テスト対象
    var actual = target.fuga3();

    expect(actual, 1);
  });
}

import 'package:book_flutter_7_async/redux/action/actions.dart';
import 'package:book_flutter_7_async/redux/reducer/app_state_reducer.dart';
import 'package:book_flutter_7_async/redux/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

main() {
  group('counterReducerのテスト', () {
    test('Stateのcounterが1の状態で、' 'ActionのincreaseCountが1の場合', () async {
// 1 counterの値が10の状態にする
      final store = Store<AppState>(
        appStateReducer,
        initialState: const AppState(counter: 10),
      );
      const increaseCount = 1;
// 2 increaseCountは1を渡す
      store.dispatch(const CountUpSucceededAction(increaseCount));
// 3 計算した結果がstateに格納されていることを検証
      expect(store.state.counter, 11);
    });
  });
}

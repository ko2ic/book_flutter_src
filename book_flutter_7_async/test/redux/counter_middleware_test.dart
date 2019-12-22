import 'package:book_flutter_7_async/redux/action/actions.dart';
import 'package:book_flutter_7_async/redux/middleware/counter_middleware.dart';
import 'package:book_flutter_7_async/redux/reducer/app_state_reducer.dart';
import 'package:book_flutter_7_async/redux/state/app_state.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class _MockCountRepository extends Mock implements CountRepository {}

class _MockMiddleware extends Mock implements MiddlewareClass<AppState> {}

main() {
  group('counterMiddlewareのテスト', () {
    test('fetch()が成功の場合', () async {
      var repository = _MockCountRepository();
      var captor = _MockMiddleware();

      final store = Store<AppState>(
        appStateReducer,
        initialState: const AppState(),
        middleware: counterMiddleware(repository)..add(captor),
      );

      const increaseCount = 1;
      when(repository.fetch()).thenAnswer((_) => Future.value(increaseCount));

      store.dispatch(const CountUpAction(increaseCount));

      verify(repository.fetch());

      verify(captor.call(store, predicate((action) {
        return (action is CountUpAction);
      }), any));

      verify(captor.call(store, predicate((action) {
        return (action is LoadingAction);
      }), any));

      await untilCalled(store.dispatch(isA<CountUpSucceededAction>()));

      verify(captor.call(store, predicate((action) {
        if (action is CountUpSucceededAction) {
          return action.increaseCount == increaseCount;
        }
        return false;
      }), any));

      verify(captor.call(store, predicate((action) {
        return (action is LoadCompleteAction);
      }), any));
    });
  });
}

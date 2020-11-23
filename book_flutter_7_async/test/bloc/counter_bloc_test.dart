import 'package:book_flutter_7_async/bloc/counter_bloc.dart';
import 'package:book_flutter_7_async/bloc/loading_bloc.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _MockCountRepository extends Mock implements CountRepository {}

class _MockLoadingBloc extends Mock implements LoadingBloc {}

main() {
  group('incrementCounter()のテスト', () {
    test('fetch()の戻りが1の場合', () async {
      var repository = _MockCountRepository();
      var loadingBloc = _MockLoadingBloc();
      var target = CounterBloc(repository, loadingBloc);
      when(loadingBloc.loading(isLoading: true)).thenReturn(null);
// 1 fetch()の戻り値はFuture。その場合は、thenAnswer()を使う
      when(repository.fetch()).thenAnswer((_) => Future.value(1));
      when(loadingBloc.loading(isLoading: false)).thenReturn(null);
      target.incrementCounter();
// 2 非同期処理が終わるのを待つ
      await untilCalled(loadingBloc.loading(isLoading: false));
// 3 listenの結果を検証するためにexpectAsync1を使う // この場合は、Streamは、[0,1]という2回呼ばれる
      target.value.listen(
        expectAsync1(
          (actual) {
            expect(actual, inInclusiveRange(0, 1));
          },
          count: 2,
        ),
      );
// 4 順序が大事な場合はverifyInOrderを使う
      verifyInOrder([
        loadingBloc.loading(isLoading: true),
        repository.fetch(),
        loadingBloc.loading(isLoading: false),
      ]);
    });
  });
}

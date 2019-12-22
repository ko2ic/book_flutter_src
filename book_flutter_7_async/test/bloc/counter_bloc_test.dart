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
      when(repository.fetch()).thenAnswer((_) => Future.value(1));
      when(loadingBloc.loading(isLoading: false)).thenReturn(null);

      target.incrementCounter();

      await untilCalled(loadingBloc.loading(isLoading: false));

      target.value.listen(
        expectAsync1(
          (actual) {
            expect(actual, inInclusiveRange(0, 1));
          },
          count: 2,
        ),
      );

      verifyInOrder([
        loadingBloc.loading(isLoading: true),
        repository.fetch(),
        loadingBloc.loading(isLoading: false),
      ]);
    });
  });
}

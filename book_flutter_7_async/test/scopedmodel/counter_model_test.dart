import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:book_flutter_7_async/scopedmodel/counter_model.dart';
import 'package:book_flutter_7_async/scopedmodel/loading_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _MockCountRepository extends Mock implements CountRepository {}

class _MockLoadingModel extends Mock implements LoadingModel {}

main() {
  group('incrementCounter()のテスト', () {
    test('fetch()の戻りが1の場合', () async {
      var repository = _MockCountRepository();
      var loadingModel = _MockLoadingModel();
      var target = CounterModel(repository, loadingModel);
      when(loadingModel.loading(isLoading: true)).thenReturn(null);
      when(repository.fetch()).thenAnswer((_) => Future.value(1));
      when(loadingModel.loading(isLoading: false)).thenReturn(null);
      target.incrementCounter();
      await untilCalled(loadingModel.loading(isLoading: false));
// 1 listenerCalledはlistenerが呼ばれたかを検証するため
      var listenerCalled = false;
      void listener() {
        expect(target.counter, 1);
        listenerCalled = true;
      }

      target.addListener(listener);
// 2 listenerが呼ばれるまで待つ
      await untilCalled(listener);
// 3 listenerが呼ばれた後の値を検証する
      expect(listenerCalled, true);
      verifyInOrder([
        loadingModel.loading(isLoading: true),
        repository.fetch(),
        loadingModel.loading(isLoading: false),
      ]);
    });
  });
}

import 'package:scoped_model/scoped_model.dart';

import 'count_repository.dart';
import 'loading_model.dart';

// Modelを継承
class CounterModel extends Model {
  final CountRepository _repository;
  final LoadingModel _loadingModel;
  int _counter = 0;

  int get counter => _counter;

  CounterModel(this._repository, this._loadingModel);

  void incrementCounter() async {
    _loadingModel.loading(true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingModel.loading(false);
    });
    _counter += increaseCount;
// 通知をウィジェットに伝える時に呼び出す
    notifyListeners();
  }
}

import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import 'loading_model.dart';

class CounterModel extends Model {
  final CountRepository _repository;
  final LoadingModel _loadingModel;
  int _counter = 0;

  int get counter => _counter;

  CounterModel(this._repository, this._loadingModel);

  void incrementCounter() async {
    _loadingModel.loading(isLoading: true);
    var increaseCount = await _repository.fetch().whenComplete(() {
      _loadingModel.loading(isLoading: false);
    });
    _counter += increaseCount;
    notifyListeners();
  }
}

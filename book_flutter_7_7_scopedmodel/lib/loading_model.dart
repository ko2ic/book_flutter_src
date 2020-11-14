import 'package:scoped_model/scoped_model.dart';

class LoadingModel extends Model {
  LoadingModel() {
    loading(false);
  }

  bool value = false;

  loading(bool isLoading) {
    value = isLoading;
    notifyListeners();
  }
}

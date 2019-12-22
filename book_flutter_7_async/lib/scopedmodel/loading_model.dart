import 'package:scoped_model/scoped_model.dart';

class LoadingModel extends Model {
  LoadingModel() {
    loading(isLoading: false);
  }

  bool value = false;

  loading({bool isLoading = false}) {
    value = isLoading;

    notifyListeners();
  }
}

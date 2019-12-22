import 'dart:async';

class LoadingBloc {
  LoadingBloc() {
    loading(isLoading: false);
  }

  final _valueController = StreamController<bool>();

  Stream<bool> get value => _valueController.stream;

  loading({bool isLoading = false}) {
    _valueController.sink.add(isLoading);
  }

  void dispose() {
    _valueController.close();
  }
}

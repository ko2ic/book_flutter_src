import 'dart:async';

import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';
import 'package:book_flutter_5_3_graphql/domains/repositories/sample_repository.dart';

import 'loading_bloc.dart';

class SampleBloc {
  final SampleRepository _repository;
  final LoadingBloc _loadingBloc;

  SampleBloc(this._repository, this._loadingBloc) {
    fetch('flutter');
  }

  final _valueController = StreamController<SampleResultDto>();

  Stream<SampleResultDto> get value => _valueController.stream;

  void fetch(String freeWord) {
    _loadingBloc.loading(isLoading: true);
    var stream = _repository.fetch(freeWord).whenComplete(() {
      _loadingBloc.loading(isLoading: false);
    }).asStream();

    _valueController.sink.addStream(stream);
  }

  void dispose() {
    _valueController.close();
  }
}

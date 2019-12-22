import 'package:book_flutter_7_async/repository/count_repository.dart';

class CountRepositoryStub implements CountRepository {
  @override
  Future<int> fetch() {
    return Future.value(10);
  }
}

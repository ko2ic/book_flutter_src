class CountRepository {
  CountRepository() {
    print("");
  }

  Future<int> fetch() {
    return Future.delayed(const Duration(seconds: 1)).then((_) {
      return 1;
    });
  }
}

/// モックにしたいクラス
class Hoge1 {
  void doNothing() {}
}

/// テスト対象のクラス
class Fuga1 {
  final Hoge1 hoge;

  Fuga1(this.hoge);

  void fuga1() {
    hoge.doNothing();
  }
}

/// モックにしたいクラス
class Hoge2 {
  String methodA({String nameA}) {
    return "A";
  }
}

/// テスト対象のクラス
class Fuga2 {
  final Hoge2 hoge;

  Fuga2(this.hoge);

  void fuga2() {
    hoge.methodA(nameA: "fuga");
  }
}

/// モックにしたいクラス
class Hoge3 {
  int methodB(int Function() hogeFunc) {
    return hogeFunc();
  }
}

/// テスト対象のクラス
class Fuga3 {
  final Hoge3 hoge;

  Fuga3(this.hoge);

  int fuga3() {
    return hoge.methodB(() {
      return 1;
    });
  }
}

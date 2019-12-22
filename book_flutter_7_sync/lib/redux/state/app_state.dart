import 'package:meta/meta.dart';

@immutable
class AppState {
  final int counter;

  const AppState({
    this.counter = 0,
  });

  AppState copyWith({
    int counter,
  }) {
    return AppState(
      counter: counter ?? this.counter,
    );
  }

  @override
  int get hashCode => counter.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppState && runtimeType == other.runtimeType && counter == other.counter;

  @override
  String toString() {
    return 'AppState{counter: $counter,';
  }
}

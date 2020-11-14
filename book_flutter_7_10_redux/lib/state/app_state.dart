import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final int counter;

  const AppState({
    this.isLoading = false,
    this.counter = 0,
  });

  AppState copyWith({
    bool isLoading,
    int counter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
    );
  }

  @override
  int get hashCode => isLoading.hashCode ^ counter.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppState && runtimeType == other.runtimeType && isLoading == other.isLoading && counter == other.counter;

  @override
  String toString() {
    return 'AppState{counter: $isLoading, $counter,';
  }
}

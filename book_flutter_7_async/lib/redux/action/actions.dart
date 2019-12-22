class LoadingAction {}

class LoadCompleteAction {}

class CountUpAction {
  final int counter;

  const CountUpAction(this.counter);
}

class CountUpSucceededAction {
  final int increaseCount;

  const CountUpSucceededAction(this.increaseCount);
}

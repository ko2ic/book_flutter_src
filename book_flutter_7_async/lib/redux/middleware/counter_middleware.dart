import 'package:book_flutter_7_async/redux/action/actions.dart';
import 'package:book_flutter_7_async/redux/state/app_state.dart';
import 'package:book_flutter_7_async/repository/count_repository.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> counterMiddleware(
  CountRepository repository,
) {
  return [
    TypedMiddleware<AppState, CountUpAction>(_fetch(repository)),
  ];
}

void Function(
  Store<AppState> store,
  CountUpAction action,
  NextDispatcher next,
) _fetch(
  CountRepository repository,
) {
  return (store, action, next) {
    next(action);
    next(LoadingAction());
    repository
        .fetch()
        .then((increaseCount) {
          store.dispatch(CountUpSucceededAction(increaseCount));
        })
        .catchError(print)
        .whenComplete(() {
          next(LoadCompleteAction());
        });
  };
}

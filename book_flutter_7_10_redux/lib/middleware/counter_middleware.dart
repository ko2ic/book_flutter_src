import 'package:book_flutter_7_10_redux/action/actions.dart';
import 'package:book_flutter_7_10_redux/repository/count_repository.dart';
import 'package:book_flutter_7_10_redux/state/app_state.dart';
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
    repository.fetch().then((increaseCount) {
      store.dispatch(CountUpSucceededAction(increaseCount));
    }).catchError((error) {
      print(error);
    }).whenComplete(() {
      next(LoadCompleteAction());
    });
  };
}

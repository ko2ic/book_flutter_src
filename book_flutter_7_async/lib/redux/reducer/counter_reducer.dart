import 'package:book_flutter_7_async/redux/action/actions.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpSucceededAction>((state, action) {
    final increaseCount = action.increaseCount;
    return state + increaseCount;
  }),
]);

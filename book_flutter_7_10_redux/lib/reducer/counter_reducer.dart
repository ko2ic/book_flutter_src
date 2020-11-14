import 'package:book_flutter_7_10_redux/action/actions.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpSucceededAction>((state, action) {
    int increaseCount = action.increaseCount;
    return state + increaseCount;
  }),
]);

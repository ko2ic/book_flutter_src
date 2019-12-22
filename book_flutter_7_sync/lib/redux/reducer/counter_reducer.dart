import 'package:book_flutter_7_sync/redux/action/count_up_action.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpAction>((state, action) {
    var current = action.counter;
    return ++current;
  }),
]);

import 'package:book_flutter_7_10_redux/action/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadingAction>((state, action) => true),
  TypedReducer<bool, LoadCompleteAction>((state, action) => false),
]);

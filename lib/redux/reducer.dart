import 'package:redux_example/model/data.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';

AppState bookReducer(AppState appState, dynamic action) {
  if (action is AddBook) {
    final List<Book> book = [...appState.book];
    book.add(action.book);
    return AppState(book: book);
  } else if (action is DeleteBook) {
    final List<Book> book = [...appState.book];
    book.removeWhere((e) => e.id == action.id);
    return AppState(book: book);
  } else if (action is UpdateBook) {
    List<Book> book = [...appState.book];
    book[book.indexWhere((element) => element.id == action.id)] = action.book;
    return AppState(book: book);
  }
  return appState;
}

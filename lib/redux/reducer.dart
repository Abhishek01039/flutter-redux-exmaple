import 'dart:convert';

import 'package:redux_example/model/data.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

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
  } else if (action is Loading) {
    return AppState(isLoading: true);
  } else if (action is LoadingSucess) {
    return AppState(data: action.data);
  } else if (action is LoadingFailed) {
    return AppState(isError: true);
  }
  return appState;
}

ThunkAction<AppState> waitAndDispatch() {
  return (Store<AppState> store) async {
    store.dispatch(Loading());
    try {
      var response = await http
          .get('https://www.googleapis.com/books/v1/volumes?q={http}');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var itemCount = jsonResponse['totalItems'];
        print('Number of books about http: $itemCount.');
        store.dispatch(LoadingSucess(jsonResponse['totalItems']));
      } else {
        print('Request failed with status: ${response.statusCode}.');
        store.dispatch(LoadingFailed());
      }
    } catch (e) {
      print(e);
      store.dispatch(LoadingFailed());
    }
  };
}

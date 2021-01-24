import 'package:flutter/widgets.dart';
import 'package:redux_example/model/data.dart';

@immutable
class AppState {
  const AppState({this.book = bookData});
  final List<Book> book;
}

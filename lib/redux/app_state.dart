import 'package:flutter/widgets.dart';
import 'package:redux_example/model/data.dart';

@immutable
class AppState {
  const AppState(
      {this.book = bookData,
      this.isError = false,
      this.isLoading = false,
      this.data});

  final List<Book> book;
  final bool isError;
  final bool isLoading;
  final dynamic data;
}

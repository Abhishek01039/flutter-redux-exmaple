import 'package:redux_example/model/data.dart';

class AddBook {
  const AddBook(this.book);
  final Book book;
}

class UpdateBook {
  const UpdateBook(this.book, this.id);
  final Book book;
  final int id;
}

class DeleteBook {
  const DeleteBook(this.id);
  final int id;
}

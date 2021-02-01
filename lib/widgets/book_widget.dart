import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:redux_example/screens/book_screen.dart';
import 'package:redux/redux.dart';

class BookWidget extends StatelessWidget {
  final Store? state;

  const BookWidget({Key? key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state?.state.book.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            state?.state.book[index].name,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookScreen(
                      id: state?.state.book[index].id,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    DeleteBook(
                      state?.state.book[index].id,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

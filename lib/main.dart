import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_example/model/data.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:redux_example/redux/reducer.dart';
import 'package:redux_example/screens/book_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store(bookReducer, initialState: AppState(book: bookData));
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redux"),
      ),
      body: StoreBuilder<AppState>(
        builder: (context, Store<AppState> state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.state.book[index].name,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookScreen(
                            id: state.state.book[index].id,
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
                            state.state.book[index].id,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: state.state.book.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

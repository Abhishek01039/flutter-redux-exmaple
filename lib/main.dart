import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_example/model/data.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';
import 'package:redux_example/redux/reducer.dart';
import 'package:redux_example/screens/book_screen.dart';
import 'package:redux_example/widgets/book_widget.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store(
    bookReducer,
    initialState: AppState(book: bookData),
    middleware: [thunkMiddleware],
  );
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.green,
              ),
            ),
            onPressed: () => StoreProvider.of<AppState>(context).dispatch(
              waitAndDispatch(),
            ),
            child: Text('API CALL'),
          )
        ],
      ),
      body: StoreBuilder<AppState>(
        builder: (context, Store<AppState> state) {
          if (state.state.isError) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else if (state.state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('This data is coming from API'),
                      Text(state.state.data.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: BookWidget(
                      state: state,
                    ),
                  ),
                ],
              ),
            );
          }
          return BookWidget(
            state: state,
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

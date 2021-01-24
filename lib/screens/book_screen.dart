import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/model/data.dart';
import 'package:redux_example/redux/action.dart';
import 'package:redux_example/redux/app_state.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key key, this.id}) : super(key: key);

  final int id;
  final TextEditingController authorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      for (var item in StoreProvider.of<AppState>(context).state.book) {
        if (item.id == id) {
          authorController.text = item.author;
          nameController.text = item.name;
          priceController.text = item.price.toString();
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (id == null) {
                StoreProvider.of<AppState>(context).dispatch(
                  AddBook(
                    Book(
                      author: authorController.text,
                      name: nameController.text,
                      price: int.tryParse(priceController.text),
                    ),
                  ),
                );
              } else {
                StoreProvider.of<AppState>(context).dispatch(
                  UpdateBook(
                    Book(
                      author: authorController.text,
                      name: nameController.text,
                      price: int.tryParse(priceController.text),
                    ),
                    id,
                  ),
                );
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Book Name'),
            ),
            TextFormField(
              controller: authorController,
              decoration: InputDecoration(labelText: 'Author Name'),
            ),
            TextFormField(
              controller: priceController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
          ],
        ),
      ),
    );
  }
}

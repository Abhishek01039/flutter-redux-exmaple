class Book {
  const Book({this.id, this.name, this.author, this.price});
  final int? id;
  final String? name;
  final String? author;
  final int? price;
}

const List<Book> bookData = [
  Book(
    id: 1,
    author: 'A.C. Bhaktivedant swami',
    name: 'Shrimad Bhagwat Geeta',
    price: 120,
  ),
  Book(
    id: 2,
    author: 'A.C. Bhaktivedant swami',
    name: 'Shrimad Bhagvtam',
    price: 150,
  ),
  Book(
    id: 3,
    author: 'A.C. Bhaktivedant swami',
    name: 'Attitude is everything',
    price: 120,
  )
];

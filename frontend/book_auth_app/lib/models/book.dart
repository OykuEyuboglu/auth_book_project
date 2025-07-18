class Book {
  final int id;
  final String title;
  final String author;
  final double price;

  Book({required this.id, required this.title, required this.author, required this.price});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
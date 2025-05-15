// Defines the data structure for a book.
class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String coverImageUrl; // URL for the book cover image
  final String genre; // Genre of the book

  // Constructor for the Book class.
  // All fields are required.
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.coverImageUrl,
    required this.genre,
  });
  
    factory Book.fromJson(Map<String, dynamic> json) { // <<<< Definition of fromJson
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      coverImageUrl: json['coverImageUrl'] as String,
      genre: json['genre'] as String,
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'price': price,
      'coverImageUrl': coverImageUrl,
      'genre': genre,
    };
  }
}

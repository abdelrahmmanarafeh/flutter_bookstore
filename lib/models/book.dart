// Defines the data structure for a book.
class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String coverImageUrl; // URL for the book cover image
  final String genre;       // Genre of the book

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

  // Optional: Factory constructor for creating a Book from a Map (e.g., JSON)
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(), // Handle potential int/double
      coverImageUrl: json['coverImageUrl'] as String,
      genre: json['genre'] as String,
    );
  }

   // Optional: Method to convert a Book instance to a Map
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

  // Override toString for better debugging representation
  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author)';
  }

  // Override == and hashCode for comparing Book objects, especially useful
  // if using Sets or Maps with Book objects as keys/values.
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
      other.id == id; // Simple equality check based on ID
  }

  @override
  int get hashCode => id.hashCode;
}

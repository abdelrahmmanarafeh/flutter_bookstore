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
}
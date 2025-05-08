import 'package:flutter/material.dart';
import '../../models/book.dart'; // Import the Book model

// Displays the details of a single book.
// StatelessWidget because the displayed book data doesn't change within this page.
class BookDetailPage extends StatelessWidget {
  final Book book; // The book to display
  final Function(Book) onAddToCart; // Callback to add the book to the cart

  const BookDetailPage({
    super.key,
    required this.book,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title), // Show book title in the AppBar
      ),
      body: SingleChildScrollView( // Allows content to scroll if it overflows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            // Book Cover Image
            Center(
              child: Hero( // Optional: Add Hero animation for smoother transition
                tag: 'bookCover_${book.id}', // Unique tag for the Hero animation
                child: Image.network(
                  book.coverImageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                  // Error handling for the image
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.book, size: 50, color: Colors.grey)),
                    );
                  },
                   // Loading indicator while the image loads
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child; // Image loaded
                    return Container(
                       height: 300,
                       color: Colors.grey[300],
                       child: Center(
                         child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                       ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing

            // Book Title
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Author
            Text(
              'by ${book.author}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16.0),

            // Price
            Text(
              '\$${book.price.toStringAsFixed(2)}', // Format price to 2 decimal places
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

             // Genre
            Chip(
              label: Text(book.genre),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 20.0),

            // Description Title
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Book Description
            Text(
              book.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30.0), // Spacing before the button

            // Add to Cart Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  backgroundColor: Theme.of(context).primaryColor, // Use theme's primary color
                  foregroundColor: Colors.white, // Text color for the button
                ),
                onPressed: () {
                  // Call the onAddToCart callback function passed from the parent
                  onAddToCart(book);
                  // Optional: Navigate back or show confirmation
                  // Navigator.pop(context); // Go back after adding
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

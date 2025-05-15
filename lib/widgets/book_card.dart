import 'package:flutter/material.dart';
import '../models/book.dart'; // Import Book model
// Import mock data


// A reusable widget to display book information in a card format.
class BookCard extends StatelessWidget {
  final Book book; // The book data to display
  final VoidCallback? onTap; // Optional callback when the card is tapped

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Card(
      // Add elevation for a shadow effect
      elevation: 3,
      // Clip content that overflows the card's rounded corners
      clipBehavior: Clip.antiAlias, // Improves rendering of rounded corners with images
      // Make the card tappable if onTap callback is provided
      child: InkWell(
        onTap: onTap, // Trigger the callback on tap
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            // Book Cover Image Section
            Expanded( // Allow image to take available vertical space
              flex: 3, // Give more space to the image
              child: Hero( // Optional: Hero animation for image transition
                tag: 'bookCover_${book.id}', // Must match the tag in BookDetailPage
                child: Image.asset(
                  book.coverImageUrl,
                  // Make image cover the available width and height within its bounds
                  width: double.infinity, // Take full width of the card
                  fit: BoxFit.cover,
                  // Error placeholder
                  errorBuilder: (context, error, stackTrace) {
                    return Container( 
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.book, color: Colors.grey, size: 40),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Book Info Section (Title, Author, Price)
            Expanded( // Allow text section to take remaining space
              flex: 2, // Give less space compared to the image
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Prevent text overflow by using maxLines and overflow properties
                  children: [
                    // Book Title
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // Limit title to 2 lines
                      overflow: TextOverflow.ellipsis, // Show '...' if text overflows
                    ),
                    const SizedBox(height: 4), // Small spacing

                    // Author
                    Text(
                      book.author,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(), // Pushes price to the bottom

                    // Price
                    Text(
                      '\$${book.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.yellow[200]
                            : Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

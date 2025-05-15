import 'package:flutter/material.dart';
import '../../models/book.dart';         // Import Book model
import '../../data/mock_data.dart';     // Import mock data
import '../book_detail/book_detail_page.dart'; // Import detail page
import '../../widgets/book_card.dart';   // Import reusable book card widget

// HomePage displays featured books and categories.
// It's a StatelessWidget as its content is based on the initial data
// and doesn't change internally based on user interaction on this page itself.
class HomePage extends StatelessWidget {
  // Callback function to add a book to the cart (passed from MainNavigator)
  final Function(Book) onAddToCart;

  const HomePage({super.key, required this.onAddToCart});

  // Function to navigate to the BookDetailPage
  void _navigateToBookDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book, onAddToCart: onAddToCart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter some books to be "featured" (e.g., first 3 books)
    final List<Book> featuredBooks = mockBooks.take(3).toList();
    // Get the list of categories
    final List<String> categories = mockCategories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookstore Home',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView( // Use ListView for scrollable content
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section Title: Featured Books
          Text(
            'Featured Books',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0), // Spacing

          // Horizontal list for featured books
          SizedBox(
            height: 280, // Adjust height as needed for BookCard size + padding
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredBooks.length,
              itemBuilder: (context, index) {
                final book = featuredBooks[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0), // Spacing between cards
                  child: SizedBox(
                     width: 160, // Fixed width for horizontal cards
                     child: BookCard(
                       book: book,
                       onTap: () => _navigateToBookDetail(context, book),
                     ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24.0), // Spacing

          // Section Title: Categories
          Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0), // Spacing

          // Grid or Wrap for categories
          Wrap(
            spacing: 12.0, // Horizontal spacing between chips
            runSpacing: 8.0, // Vertical spacing between lines
            children: categories.map((category) {
              return Chip(
                label: Text(category),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blue.shade900 // Darker background in dark mode
                    : Colors.blue.shade50, // Light background for chips
                side: BorderSide(color: Colors.blue.shade200), // Subtle border
                // Optional: Add onTap to navigate to a category-specific page
                // onTap: () {
                //   print('Category $category tapped');
                //   // Navigate to a page showing books in this category
                // },
              );
            }).toList(),
          ),

           const SizedBox(height: 24.0), // Spacing

           // Section Title: All Books (Example)
          Text(
            'All Books',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0), // Spacing

          // Display all books using a GridView for better space utilization
          GridView.builder(
            shrinkWrap: true, // Important inside a ListView
            physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 16.0, // Horizontal space between cards
              mainAxisSpacing: 16.0, // Vertical space between cards
              childAspectRatio: 0.6, // Adjust aspect ratio (width / height)
            ),
            itemCount: mockBooks.length,
            itemBuilder: (context, index) {
              final book = mockBooks[index];
              return BookCard(
                book: book,
                onTap: () => _navigateToBookDetail(context, book),
              );
            },
          ),
        ],
      ),
    );
  }
}

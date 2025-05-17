import 'package:flutter/material.dart';
import '../../models/book.dart';         // Import Book model
import '../../data/mock_data.dart';     // Import mock data (for searching)
import '../book_detail/book_detail_page.dart'; // Import detail page
import '../../widgets/book_card.dart'; // Import reusable book card

// SearchPage allows users to search for books.
// It's a StatefulWidget because the list of displayed results changes
// based on the user's search query input.
class SearchPage extends StatefulWidget {
   // Callback function to add a book to the cart (passed from MainNavigator)
  final Function(Book) onAddToCart;

  const SearchPage({super.key, required this.onAddToCart});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Controller to manage the text input in the search field.
  final TextEditingController _searchController = TextEditingController();
  // List to hold the search results.
  List<Book> _searchResults = [];
  // The current search query.
  String _query = '';

  @override
  void initState() {
    super.initState();
    // Initialize search results with all books initially or leave empty
    // _searchResults = mockBooks; // Uncomment to show all books initially
    // Add a listener to the search controller to update search results in real-time.
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  // Function to filter books based on the current query.
  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _query = query; // Store the query
      if (query.isEmpty) {
        _searchResults = []; // Clear results if query is empty
        // _searchResults = mockBooks; // Or show all books if query is empty
      } else {
        // Filter the mockBooks list based on title, author, or genre containing the query.
        _searchResults = mockBooks.where((book) {
          final titleMatch = book.title.toLowerCase().contains(query);
          final authorMatch = book.author.toLowerCase().contains(query);
          final genreMatch = book.genre.toLowerCase().contains(query);
          return titleMatch || authorMatch || genreMatch;
        }).toList();
      }
    });
  }

   // Function to navigate to the BookDetailPage
  void _navigateToBookDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // Pass the book and the addToCart callback to the detail page
        builder: (context) => BookDetailPage(book: book, onAddToCart: widget.onAddToCart),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          // Search Input Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by title, author, or genre',
                hintText: 'Enter search term...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // Add a clear button to the search field
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear(); // Clears the text field
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Results List / Grid
          Expanded( // Allows the list/grid to take remaining space
            child: _searchResults.isEmpty && _query.isNotEmpty
                ? Center(child: Text('No books found for "$_query"')) // Message when no results
                : _searchResults.isEmpty && _query.isEmpty
                    ? const Center(child: Text('Enter a search term to find books.')) // Initial prompt
                    : GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Adjust number of columns for responsiveness
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.6, // Adjust aspect ratio
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final book = _searchResults[index];
                          // Use the reusable BookCard widget
                          return BookCard(
                            book: book,
                            onTap: () => _navigateToBookDetail(context, book),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

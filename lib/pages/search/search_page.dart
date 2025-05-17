import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../data/mock_data.dart';
import '../book_detail/book_detail_page.dart';
import '../../widgets/book_card.dart';


class SearchPage extends StatefulWidget {
  final Function(Book) onAddToCart;

  const SearchPage({super.key, required this.onAddToCart});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _query = query;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = mockBooks.where((book) {
          final titleMatch = book.title.toLowerCase().contains(query);
          final authorMatch = book.author.toLowerCase().contains(query);
          final genreMatch = book.genre.toLowerCase().contains(query);
          return titleMatch || authorMatch || genreMatch;
        }).toList();
      }
    });
  }

  void _navigateToBookDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
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
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),

          Expanded(
            child: _searchResults.isEmpty && _query.isNotEmpty
                ? Center(child: Text('No books found for "$_query"'))
                : _searchResults.isEmpty && _query.isEmpty
                    ? const Center(child: Text('Enter a search term to find books.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final book = _searchResults[index];
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

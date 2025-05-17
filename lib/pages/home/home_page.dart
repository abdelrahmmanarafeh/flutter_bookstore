import 'package:flutter/material.dart';
import '../../models/book.dart';    
import '../../data/mock_data.dart';   
import '../book_detail/book_detail_page.dart';
import '../../widgets/book_card.dart';


class HomePage extends StatelessWidget {
  final Function(Book) onAddToCart;

  const HomePage({super.key, required this.onAddToCart});

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
    final List<Book> featuredBooks = mockBooks.take(3).toList();
    final List<String> categories = mockCategories;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookstore Home',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Text(
            'Featured Books',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),

          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredBooks.length,
              itemBuilder: (context, index) {
                final book = featuredBooks[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                     width: 160,
                     child: BookCard(
                       book: book,
                       onTap: () => _navigateToBookDetail(context, book),
                     ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24.0),

          const Text(
            'Categories',
          ),
          const SizedBox(height: 16.0),

          Wrap(
            spacing: 12.0,
            runSpacing: 8.0,
            children: categories.map((category) {
              return Chip(
                label: Text(category),
                backgroundColor: Colors.blue.shade50,
                side: BorderSide(color: Colors.blue.shade200),
              );
            }).toList(),
          ),

           const SizedBox(height: 24.0),

          const Text(
            'All Books',
          ),
          const SizedBox(height: 16.0),

          GridView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.6,
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

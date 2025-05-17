import 'package:flutter/material.dart';
import '../../models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book; 
  final Function(Book) onAddToCart;

  const BookDetailPage({
    super.key,
    required this.book,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero( 
                tag: 'bookCover_${book.id}',
                child: Image.asset(
                  book.coverImageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.book, size: 50, color: Colors.grey)),
                    );
                  },

                ),
              ),
            ),
            const SizedBox(height: 20.0),

            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            Text(
              'by ${book.author}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16.0),

            Text(
              '\$${book.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            Chip(
              label: Text(book.genre),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 20.0),

            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            Text(
              book.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30.0),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  onAddToCart(book);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

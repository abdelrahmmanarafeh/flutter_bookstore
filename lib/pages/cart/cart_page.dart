import 'package:flutter/material.dart';
import '../../models/book.dart';


class CartPage extends StatelessWidget {
  final List<Book> cartItems;
  final Function(Book) onRemoveFromCart;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
 required this.onCheckout,
    required this.onRemoveFromCart,
  });

  double get _totalPrice => cartItems.fold(0.0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${cartItems.length})'),
      ),
      body: Column(
        children: [
          Expanded( 
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final book = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        child: ListTile(
                          leading: Image.asset(
                            book.coverImageUrl,
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${book.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                tooltip: 'Remove from cart',
                                onPressed: () {
                                  onRemoveFromCart(book);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card( 
                 elevation: 4,
                 child: Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Total:',
                             style: Theme.of(context).textTheme.titleLarge,
                           ),
                           Text(
                             '\$${_totalPrice.toStringAsFixed(2)}',
                             style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                           ),
                         ],
                       ),
                       const SizedBox(height: 16.0),
                       SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             padding: const EdgeInsets.symmetric(vertical: 15.0),
                             backgroundColor: Theme.of(context).primaryColor,
                             foregroundColor: Colors.white,
                             textStyle: Theme.of(context).textTheme.titleMedium,
                           ),
                           onPressed: () {
                             onCheckout();                         },
                           child: const Text('Proceed to Checkout'),
                         ),
                       ),
                     ],
                   ),
                 ),
              ),
            ),
        ],
      ),
    );
  }
}

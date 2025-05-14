import 'package:flutter/material.dart';
import '../../models/book.dart'; // Import Book model

// CartPage displays items added to the shopping cart.
// It could be StatelessWidget if cart state is managed externally (like in MainNavigator).
// If managing cart state locally, it would need to be StatefulWidget.
// Here, it receives cart data and callbacks, so StatelessWidget is suitable.
class CartPage extends StatelessWidget {
  // List of books currently in the cart (passed from MainNavigator)
  final List<Book> cartItems;
  // Callback function to remove an item from the cart (passed from MainNavigator)
  final Function(Book) onRemoveFromCart;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
 required this.onCheckout,
    required this.onRemoveFromCart,
  });

  // Calculate the total price of items in the cart
  double get _totalPrice => cartItems.fold(0.0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${cartItems.length})'), // Show item count in title
      ),
      body: Column(
        children: [
          // List of Cart Items
          Expanded( // Make the list scrollable and take available space
            child: cartItems.isEmpty
                ? const Center( // Show message if cart is empty
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final book = cartItems[index];
                      return Card( // Use Card for better visual separation
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        child: ListTile(
                          // Book Cover Image (small)
                          leading: Image.asset(
                            book.coverImageUrl,
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                          // Book Title and Author
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          // Price and Remove Button
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min, // Keep row tight
                            children: [
                              Text(
                                '\$${book.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                tooltip: 'Remove from cart',
                                onPressed: () {
                                  // Call the callback function to remove the item
                                  onRemoveFromCart(book);
                                },
                              ),
                            ],
                          ),
                          // Optional: Navigate to detail page on tap
                          // onTap: () { /* Navigate to BookDetailPage if needed */ },
                        ),
                      );
                    },
                  ),
          ),

          // Total Price and Checkout Button (only show if cart is not empty)
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card( // Card for summary section
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
                       SizedBox( // Make button full width
                         width: double.infinity,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             padding: const EdgeInsets.symmetric(vertical: 15.0),
                             backgroundColor: Theme.of(context).brightness == Brightness.dark
                                 ? Colors.green.shade700 // Lighter color in dark mode
                                 : Theme.of(context).primaryColor, // Primary color in light mode
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

import 'package:flutter/material.dart';
import '../models/book.dart'; // Import Book model
import 'home/home_page.dart';
import 'search/search_page.dart';
import 'cart/cart_page.dart';
import 'profile/profile_page.dart';

// This StatefulWidget manages the main navigation (BottomNavigationBar)
// and holds the state for the currently selected page and the shopping cart.
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  // Index of the currently selected tab in the bottom navigation bar.
  int _selectedIndex = 0;

  // List to hold the books added to the shopping cart.
  // In a real app, use a more robust state management solution (Provider, Riverpod, etc.)
  final List<Book> _cartItems = [];

  // Callback function to add a book to the cart.
  // This function is passed down to pages that need to add items (e.g., BookDetailPage).
  void _addToCart(Book book) {
    setState(() {
      // Check if the book is already in the cart to avoid duplicates
      if (!_cartItems.any((item) => item.id == book.id)) {
        _cartItems.add(book);
        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${book.title} added to cart'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
         // Optionally show a message if the item is already in the cart
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${book.title} is already in the cart'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  // Callback function to remove a book from the cart.
  // This function is passed down to the CartPage.
  void _removeFromCart(Book book) {
    setState(() {
      _cartItems.removeWhere((item) => item.id == book.id);
       // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${book.title} removed from cart'),
            duration: const Duration(seconds: 2),
          ),
        );
    });
  }

  // List of the main pages corresponding to the bottom navigation bar items.
  // Note: We pass the necessary callbacks and data down to the pages.
  late final List<Widget> _pages;

   @override
  void initState() {
    super.initState();
    // Initialize the pages list here, after _addToCart and _removeFromCart are available.
    _pages = <Widget>[
      HomePage(onAddToCart: _addToCart), // Pass addToCart callback
      SearchPage(onAddToCart: _addToCart), // Pass addToCart callback
      CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart), // Pass cart items and remove callback
      const ProfilePage(), // Profile page is currently stateless
    ];
  }


  // Function called when a bottom navigation bar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body displays the currently selected page from the _pages list.
      body: IndexedStack( // Use IndexedStack to keep page state alive
         index: _selectedIndex,
         children: _pages,
      ),
      // Bottom navigation bar for switching between main pages.
      bottomNavigationBar: BottomNavigationBar(
        // List of items in the navigation bar.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // The index of the currently selected item.
        currentIndex: _selectedIndex,
        // Color for selected item icons and labels.
        selectedItemColor: Theme.of(context).primaryColor,
        // Color for unselected item icons and labels.
        unselectedItemColor: Colors.grey,
        // Ensures labels are always shown
        showUnselectedLabels: true,
        // Type fixed ensures the background color is applied correctly
        type: BottomNavigationBarType.fixed,
        // Callback function when an item is tapped.
        onTap: _onItemTapped,
      ),
    );
  }
}

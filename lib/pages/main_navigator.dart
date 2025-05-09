import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
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

  // List to hold purchase history (list of lists of books)
  final List<List<Book>> _purchaseHistory = [];

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
        _onItemTapped(2); // Navigate to and rebuild the cart page
    });
  }

  // Method to handle the checkout process
  void _checkout(List<Book> itemsToCheckout) {
    setState(() {
      _purchaseHistory.add(List.from(itemsToCheckout)); // Save a copy of the current cart
      _onItemTapped(2); // Navigate to and rebuild the cart page
      _cartItems.clear(); // Clear the cart
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
      CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems)), // Pass cart items, remove callback, and checkout callback
      ProfilePage(purchaseHistory: _purchaseHistory), // Pass purchase history to ProfilePage
    ];
  }


  // Function called when a bottom navigation bar item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
      // When navigating to the cart tab, update the CartPage with the current cart items
      if (index == 2) {
        _pages[index] = CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems));
      } else if (index == 3) {
        // When navigating to the profile tab, update ProfilePage with the current purchase history
         _pages[index] = ProfilePage(purchaseHistory: _purchaseHistory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.amberAccent // Bright color in dark mode
                : Theme.of(context).primaryColor, // Primary color in light mode
            // Color for unselected item icons and labels.
            unselectedItemColor: Colors.grey,
            // Ensures labels are always shown
            showUnselectedLabels: true,
            // Type fixed ensures the background color is applied correctly
            type: BottomNavigationBarType.fixed,
            // Callback function when an item is tapped.
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
            child: const Icon(Icons.brightness_6),
          ),
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'dart:convert'; // Import dart:convert for JSON encoding/decoding

import '../models/book.dart'; // Import Book model
import 'home/home_page.dart';
import 'search/search_page.dart';
import 'cart/cart_page.dart';
import 'profile/profile_page.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
  List<Book> _cartItems = [];
  List<List<Book>> _purchaseHistory = [];

  // Keys for SharedPreferences
  static const String _kCartItemsKey = 'cart_items';
  static const String _kPurchaseHistoryKey = 'purchase_history';

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the widget is initialized
    _pages = <Widget>[
      HomePage(onAddToCart: _addToCart),
      SearchPage(onAddToCart: _addToCart),
      CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems)),
      ProfilePage(purchaseHistory: _purchaseHistory),
    ];
  }

  // Load data from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load cart items
      final String? cartItemsString = prefs.getString(_kCartItemsKey);
      if (cartItemsString != null) {
        final List<dynamic> cartJson = jsonDecode(cartItemsString);
        _cartItems = cartJson.map((jsonItem) => Book.fromJson(jsonItem as Map<String, dynamic>)).toList();
      }

      // Load purchase history
      final String? purchaseHistoryString = prefs.getString(_kPurchaseHistoryKey);
      if (purchaseHistoryString != null) {
        final List<dynamic> historyJson = jsonDecode(purchaseHistoryString);
        _purchaseHistory = historyJson.map((purchaseJson) {
          final List<dynamic> itemsJson = purchaseJson as List<dynamic>;
          return itemsJson.map((itemJson) => Book.fromJson(itemJson as Map<String, dynamic>)).toList();
        }).toList();
      }
      // Update pages after loading data
      _updatePages();
    });
  }

  // Save cart items to SharedPreferences
  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartItemsString = jsonEncode(_cartItems.map((book) => book.toJson()).toList());
    await prefs.setString(_kCartItemsKey, cartItemsString);
  }

  // Save purchase history to SharedPreferences
  Future<void> _savePurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String purchaseHistoryString = jsonEncode(
        _purchaseHistory.map((purchase) => purchase.map((book) => book.toJson()).toList()).toList());
    await prefs.setString(_kPurchaseHistoryKey, purchaseHistoryString);
  }

  void _addToCart(Book book) {
    setState(() {
      if (!_cartItems.any((item) => item.id == book.id)) {
        _cartItems.add(book);
        _saveCartItems(); // Save after adding
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${book.title} added to cart'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${book.title} is already in the cart'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      _updatePages(); // Update cart page
    });
  }

  void _removeFromCart(Book book) {
    setState(() {
      _cartItems.removeWhere((item) => item.id == book.id);
      _saveCartItems(); // Save after removing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${book.title} removed from cart'),
          duration: const Duration(seconds: 2),
        ),
      );
      _onItemTapped(2); // Navigate to and rebuild the cart page
    });
  }

  void _checkout(List<Book> itemsToCheckout) {
    setState(() {
      _purchaseHistory.add(List.from(itemsToCheckout));
      _cartItems.clear();
      _savePurchaseHistory(); // Save purchase history
      _saveCartItems(); // Save (empty) cart
      _onItemTapped(2); // Navigate to and rebuild the cart page
    });
  }
  
  // Helper method to update page instances with current data
  void _updatePages() {
     _pages[2] = CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems));
     _pages[3] = ProfilePage(purchaseHistory: _purchaseHistory);
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updatePages(); // Ensure pages have the latest data when tab is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: IndexedStack(
             index: _selectedIndex,
             children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
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
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 147, 27, 174),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            child: const Icon(Icons.brightness_6),
          ),
        );
  }
}
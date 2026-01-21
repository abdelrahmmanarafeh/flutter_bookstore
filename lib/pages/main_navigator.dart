import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/book.dart';
import 'home/home_page.dart';
import 'search/search_page.dart';
import 'cart/cart_page.dart';
import 'profile/profile_page.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
  //The state class (_MainNavigatorState) — this holds mutable state and logic
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
  List<Book> _cartItems = [];
  List<List<Book>> _purchaseHistory = [];

  static const String _kCartItemsKey = 'cart_items';
  static const String _kPurchaseHistoryKey = 'purchase_history';

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _loadData();
    _pages = <Widget>[
      HomePage(onAddToCart: _addToCart),
      SearchPage(onAddToCart: _addToCart),
      CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems)),
      ProfilePage(purchaseHistory: _purchaseHistory),
    ];
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final String? cartItemsString = prefs.getString(_kCartItemsKey);
      if (cartItemsString != null) {
        final List<dynamic> cartJson = jsonDecode(cartItemsString);
        _cartItems = cartJson.map((jsonItem) => Book.fromJson(jsonItem as Map<String, dynamic>)).toList();
      }

      final String? purchaseHistoryString = prefs.getString(_kPurchaseHistoryKey);
      if (purchaseHistoryString != null) {
        final List<dynamic> historyJson = jsonDecode(purchaseHistoryString);
        _purchaseHistory = historyJson.map((purchaseJson) {
          final List<dynamic> itemsJson = purchaseJson as List<dynamic>;
          return itemsJson.map((itemJson) => Book.fromJson(itemJson as Map<String, dynamic>)).toList();
        }).toList();
      }
      _updatePages();
    });
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartItemsString = jsonEncode(_cartItems.map((book) => book.toJson()).toList());
    await prefs.setString(_kCartItemsKey, cartItemsString);
  }

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
        _saveCartItems();
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
      _updatePages();
    });
  }

  void _removeFromCart(Book book) {
    setState(() {
      _cartItems.removeWhere((item) => item.id == book.id);
      _saveCartItems();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${book.title} removed from cart'),
          duration: const Duration(seconds: 2),
        ),
      );
      _onItemTapped(2);
    });
  }

  void _checkout(List<Book> itemsToCheckout) {
    setState(() {
      _purchaseHistory.add(List.from(itemsToCheckout));
      _cartItems.clear();
      _savePurchaseHistory();
      _saveCartItems();
      _onItemTapped(2);
    });
  }
  
  void _updatePages() {
     _pages[2] = CartPage(cartItems: _cartItems, onRemoveFromCart: _removeFromCart, onCheckout: () => _checkout(_cartItems));
     _pages[3] = ProfilePage(purchaseHistory: _purchaseHistory);
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updatePages();
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
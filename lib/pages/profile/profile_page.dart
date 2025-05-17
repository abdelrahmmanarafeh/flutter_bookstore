import 'package:flutter/material.dart';
import '../../models/book.dart'; // Import Book model

// ProfilePage displays user information and potentially purchase history.
// Currently a placeholder StatelessWidget. Could become StatefulWidget
// if profile data needs to be fetched or updated dynamically.
class ProfilePage extends StatelessWidget {
  final List<List<Book>> purchaseHistory; // List of past purchases

  const ProfilePage({
    super.key,
    required this.purchaseHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'), // Set title
      ),
      body: ListView( // Use ListView for potentially long content
        padding: const EdgeInsets.all(20.0),
        children: [
          // Profile Header Section
          const Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('images/profile.jpg'),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eyad Alshareef', // Placeholder user name
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'eyadsd@just.edu.jo', // Placeholder user email
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Divider(), // Separator

          // Menu Options using ListTile
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Purchase History'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Show a dialog with purchase history
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Purchase History'),
                    content: purchaseHistory.isEmpty
                        ? const Text('You have no past purchases.')
                        : SingleChildScrollView( // Allow scrolling if history is long
                            child: ListBody(
                              children: purchaseHistory.asMap().entries.map((entry) {
                                  int purchaseIndex = entry.key;
                                  List<Book> purchase = entry.value;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Purchase ${purchaseIndex + 1}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ...purchase.map((book) => Text('- ${book.title}')), // List book titles in this purchase
                                    const SizedBox(height: 10), // Spacing between purchases
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {

            },
          ),
          const Divider(),
           ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: Text('Logout', style: TextStyle(color: Colors.red.shade700)),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}

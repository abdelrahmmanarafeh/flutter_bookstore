import 'package:flutter/material.dart';
import '../../models/book.dart';


class ProfilePage extends StatelessWidget {
  final List<List<Book>> purchaseHistory;
  const ProfilePage({
    super.key,
    required this.purchaseHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
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
                    'Eyad Alshareef',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'eyadsd@just.edu.jo',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Purchase History'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Purchase History'),
                    content: purchaseHistory.isEmpty
                        ? const Text('You have no past purchases.')
                        : SingleChildScrollView(
                            child: ListBody(
                              children: purchaseHistory.asMap().entries.map((entry) {
                                  int purchaseIndex = entry.key;
                                  List<Book> purchase = entry.value;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Purchase ${purchaseIndex + 1}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ...purchase.map((book) => Text('- ${book.title}')),
                                    const SizedBox(height: 10),
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

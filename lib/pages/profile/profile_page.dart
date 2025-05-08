import 'package:flutter/material.dart';

// ProfilePage displays user information and potentially purchase history.
// Currently a placeholder StatelessWidget. Could become StatefulWidget
// if profile data needs to be fetched or updated dynamically.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView( // Use ListView for potentially long content
        padding: const EdgeInsets.all(20.0),
        children: [
          // Profile Header Section
          const Row(
            children: [
              CircleAvatar(
                radius: 40,
                // Placeholder image - replace with user's actual avatar if available
                backgroundImage: NetworkImage('https://placehold.co/100x100/0077b6/ffffff?text=User'),
                child: Icon(Icons.person, size: 40, color: Colors.white70), // Fallback icon
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe', // Placeholder user name
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'john.doe@example.com', // Placeholder user email
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
              // Navigate to Purchase History page (not implemented)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase History page not implemented.')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to Settings page (not implemented)
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings page not implemented.')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to Help page (not implemented)
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help page not implemented.')),
              );
            },
          ),
          const Divider(),
           ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: Text('Logout', style: TextStyle(color: Colors.red.shade700)),
            onTap: () {
              // Handle Logout action
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout functionality not implemented.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

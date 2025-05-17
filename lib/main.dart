import 'package:flutter/material.dart';
import 'pages/main_navigator.dart'; // Import the main navigator


void main() {
  runApp(
    const MyApp()
  );
}

// The root widget of the application.
// It's a StatelessWidget because its own configuration doesn't change over time.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return const MaterialApp(
          // Title of the app (shown in task manager, etc.)
          title: 'Flutter Bookstore',
          debugShowCheckedModeBanner: false,
          home: MainNavigator(),
        );
      }
  }
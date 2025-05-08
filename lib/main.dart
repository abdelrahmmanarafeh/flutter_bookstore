import 'package:flutter/material.dart';
import 'pages/main_navigator.dart'; // Import the main navigator

void main() {
  runApp(const MyApp());
}

// The root widget of the application.
// It's a StatelessWidget because its own configuration doesn't change over time.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the app (shown in task manager, etc.)
      title: 'Flutter Bookstore',
      // Theme data defines the overall look and feel.
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.blue,
        // Use Material 3 design principles
        useMaterial3: true,
        // Define the visual density for UI components.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Hide the debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,
      // The home property sets the default route of the app.
      // We use MainNavigator to handle the main pages and bottom navigation.
      home: const MainNavigator(),
    );
  }
}
//hell

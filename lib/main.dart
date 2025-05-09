import 'package:flutter/material.dart';
import 'pages/main_navigator.dart'; // Import the main navigator
import 'package:provider/provider.dart';
import 'provider/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const MyApp()),
  );
}

// The root widget of the application.
// It's a StatelessWidget because its own configuration doesn't change over time.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const MainNavigator(),
        );
      },
    );
  }
}
//hell

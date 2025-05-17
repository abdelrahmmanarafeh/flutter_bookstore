import 'package:flutter/material.dart';
import 'pages/main_navigator.dart';


void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        return const MaterialApp(
          title: 'Flutter Bookstore',
          debugShowCheckedModeBanner: false,
          home: MainNavigator(),
        );
      }
  }
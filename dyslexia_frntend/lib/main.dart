// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyslexia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/register',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        // Define the home screen route after login
        // '/home': (context) => HomeScreen(),
      },
    );
  }
}
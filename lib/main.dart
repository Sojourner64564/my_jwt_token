import 'package:flutter/material.dart';
import 'package:my_jwt_token/feature/auth_screen/presentation/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthScreen(),
    );
  }
}


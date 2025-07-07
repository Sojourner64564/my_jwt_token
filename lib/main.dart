import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/email_screen/email_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  EmailScreen(),
    );
  }
}


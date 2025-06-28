import 'package:flutter/material.dart';
import 'package:my_jwt_token/feature/auth_screen/presentation/auth_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthPage(),
    );
  }
}

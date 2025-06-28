import 'package:flutter/material.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/main_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
    );
  }
}

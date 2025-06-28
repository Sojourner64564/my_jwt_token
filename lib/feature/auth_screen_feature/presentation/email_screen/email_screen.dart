import 'package:flutter/material.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/email_screen/email_page.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EmailPage(),
    );
  }
}

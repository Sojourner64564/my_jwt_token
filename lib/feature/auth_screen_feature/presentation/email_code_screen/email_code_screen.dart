import 'package:flutter/material.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/email_code_screen/email_code_page.dart';

class EmailCodeScreen extends StatelessWidget {
  const EmailCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EmailCodePage(),
    );
  }
}

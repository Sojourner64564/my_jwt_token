import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/main_page.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});

   final securityStorage = getIt<SecurityStorageClient>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
    );
  }
}

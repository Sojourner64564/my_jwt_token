import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/security_storage_repository.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/main_page.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
  final bruh = getIt<SecurityStorageRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        bruh.write(StorageKeys.jwtTokenKey, 'beeeebebeb');
      }),
    );
  }
}

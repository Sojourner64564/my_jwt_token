import 'package:flutter/material.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/main_page.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});

   final securityStorage = getIt<SecurityStorageClient>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              onPressed: (){
                securityStorage.write(StorageKeys.refreshTokenKey, "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnJaWGtpT2lKaVpUSmtObVJrT0MwM1pqZ3dMVFJtTldZdE9XWXhNeTFpTW1WbE56bGxZMkkwWVRBaUxDSjJZV3dpT2pFM05URTVNRGcxTmprMk5UTXNJbWxoZENJNk1UYzFNVGt3T0RVMk9YMC5wTWdEeHdfYTh5RjU1Q1NCZk5lTUpSTjN6MWdCc1htMGJWQnRUcElnRU1V");
              },
                child: Text('Enter jwt'),
    ),
          FloatingActionButton(
              onPressed: (){
                securityStorage.write(StorageKeys.jwtTokenKey, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiYmUyZDZkZDgtN2Y4MC00ZjVmLTlmMTMtYjJlZTc5ZWNiNGEwIiwiaWF0IjoxNzUxOTA4NTY5LCJleHAiOjE3NTE5MTIxNjl9.2rqmT-vF1iVHWXWs0Nl73GLz_VcwhHynBKacqktzT0k");
          },
            child: Text('Enter jwt'),
          ),

          FloatingActionButton(
              onPressed: (){
                securityStorage.write(StorageKeys.jwtTokenKey, '');
              },
            child: Text('Delete jwt'),
          ),
          FloatingActionButton(
            onPressed: (){
              securityStorage.write(StorageKeys.refreshTokenKey, '');
            },
            child: Text('Delete refresh'),
          ),
        ],
      ),
      body: MainPage(),
    );
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecurityStorageClient{
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
        encryptedSharedPreferences: true
    ),
  );

  Future<void> write(String key, String? value) async{
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async{
    return await storage.read(key: key);
  }

  Future<bool> contains(String key) async{
    return await storage.containsKey(key: key);
  }
}
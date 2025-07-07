import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule{
  Dio get dioClient => Dio(
    BaseOptions(
      validateStatus: (status) => [200, 400, 502].contains(status),
    ),
  );
}
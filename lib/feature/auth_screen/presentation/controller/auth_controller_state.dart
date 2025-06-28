part of 'auth_controller_cubit.dart';

abstract class AuthControllerState {}

class AuthControllerInitial extends AuthControllerState {}

class AuthControllerLoading extends AuthControllerState {}

class AuthControllerError extends AuthControllerState {
  final String error;

  AuthControllerError(this.error);
}

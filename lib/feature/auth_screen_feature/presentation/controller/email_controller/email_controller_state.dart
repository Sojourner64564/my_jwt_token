part of 'email_controller_cubit.dart';

abstract class EmailControllerState {}

class EmailControllerInitial extends EmailControllerState {}

class EmailControllerLoading extends EmailControllerState {}

class EmailControllerError extends EmailControllerState {
  final String error;

  EmailControllerError(this.error);
}

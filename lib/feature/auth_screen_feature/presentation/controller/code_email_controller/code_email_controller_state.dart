part of 'code_email_controller_cubit.dart';

abstract class CodeEmailControllerState {}

class CodeEmailControllerInitial extends CodeEmailControllerState {}
class CodeEmailControllerLoading extends CodeEmailControllerState {}
class CodeEmailControllerError extends CodeEmailControllerState {
  final String error;

  CodeEmailControllerError(this.error);
}

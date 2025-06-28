part of 'user_controller_cubit.dart';

abstract class UserControllerState {}

class UserControllerInitial extends UserControllerState {}
class UserControllerLoading extends UserControllerState {}
class UserControllerLoaded extends UserControllerState {
  final UserIdEntity userIdEntity;

  UserControllerLoaded(this.userIdEntity);
}
class UserControllerError extends UserControllerState {
  final String error;

  UserControllerError(this.error);
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_controller_state.dart';

class AuthControllerCubit extends Cubit<AuthControllerState> {
  AuthControllerCubit() : super(AuthControllerInitial());
}

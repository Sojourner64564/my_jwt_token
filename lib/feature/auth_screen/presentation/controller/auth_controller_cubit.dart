import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/feature/common_feature/domain/usecase/login_usecase.dart';

part 'auth_controller_state.dart';

@lazySingleton
class AuthControllerCubit extends Cubit<AuthControllerState> {
  AuthControllerCubit(this._loginUseCase) : super(AuthControllerInitial());

  final LoginUseCase _loginUseCase;

  Future<void> login(String email, Function navigationFunction) async{
    emit(AuthControllerLoading());

    await _loginUseCase.call(email.trim()).then((_){
      navigationFunction();
    }).catchError((error, stackTrace){
      if(error is NoInternetFailure){
        emit(AuthControllerError('Нет интернета'));
      }
      if(error is InvalidEmailFailure){
        emit(AuthControllerError("Неправильный Email"));
      }
      if(error is ServerFailure){
        emit(AuthControllerError("Ошибка сервера"));
      }
    });
  }
}

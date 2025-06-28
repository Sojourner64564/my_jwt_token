import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/controller/code_email_controller/code_email_controller_cubit.dart';
import 'package:my_jwt_token/feature/common_feature/domain/usecase/login_usecase.dart';

part 'email_controller_state.dart';

@lazySingleton
class EmailControllerCubit extends Cubit<EmailControllerState> {
  EmailControllerCubit(this._loginUseCase, this._codeEmailControllerCubit) : super(EmailControllerInitial());

  final LoginUseCase _loginUseCase;
  final CodeEmailControllerCubit _codeEmailControllerCubit;

  void login(String text, Function navigationFunction) {
    if(text.isEmpty) return;
    // Чтобы пропускало только паттерн qwerty@gmail.com и похожие email
    if(!text.contains(RegExp(r'^[a-zA-Z0-9_.]+@[a-zA-Z0-9-]+.[a-zA-Z]+$'))) {
      emit(EmailControllerError("Неформатный Email"));
      return;
    }

    emit(EmailControllerLoading());

    final email = text.trim();
     _loginUseCase.call(email).then((_){
      navigationFunction();
      _codeEmailControllerCubit.email = email;
    }).catchError((error, stackTrace){
      if(error is NoInternetFailure){
        emit(EmailControllerError('Нет интернета'));
      }
      if(error is InvalidEmailFailure){
        emit(EmailControllerError("Неправильный Email"));
      }
      if(error is ServerFailure){
        emit(EmailControllerError("Ошибка сервера"));
      }
    });
  }
}

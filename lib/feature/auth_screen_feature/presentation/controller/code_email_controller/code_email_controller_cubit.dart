import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/feature/common_feature/domain/usecase/confirm_code_usecase.dart';

part 'code_email_controller_state.dart';

@lazySingleton
class CodeEmailControllerCubit extends Cubit<CodeEmailControllerState> {
  CodeEmailControllerCubit(this._confirmCodeUseCase) : super(CodeEmailControllerInitial());

  final ConfirmCodeUseCase _confirmCodeUseCase;

  String email = '';

  void confirmCode(String code, Function navigationFunction) {
    emit(CodeEmailControllerLoading());

    _confirmCodeUseCase.call(ConfirmCodeParams(email, code)).then((_){
      navigationFunction();
    }).catchError((error, stackTrace){
      if(error is NoInternetFailure){
        emit(CodeEmailControllerError('Нет интернета'));
      }
      if(error is ExpiredEmailCodeFailure){
        emit(CodeEmailControllerError('Неправильный код'));
      }
      if(error is ServerFailure){
        emit(CodeEmailControllerError('Ошибка сервера'));
      }
    });
  }
}

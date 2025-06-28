import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/usecase/fetch_user_id_usecase.dart';

part 'user_controller_state.dart';

@lazySingleton
class UserControllerCubit extends Cubit<UserControllerState> {
  UserControllerCubit(this.fetchUserIdUseCase) : super(UserControllerInitial());

  final FetchUserIdUseCase fetchUserIdUseCase;

  Future<void> fetchUserId() async{
    emit(UserControllerLoading());

    await fetchUserIdUseCase.call().then((data){
      emit(UserControllerLoaded(data));
    }).catchError((error, stackTrace){
      if(error is NoInternetFailure){
        emit(UserControllerError('Нет интернета'));
      }
      if(error is ServerFailure){
        emit(UserControllerError('Ошибка сервера'));
      }
      if(error is AppFailure){
        emit(UserControllerError('Неожиданная ошибка'));
      }
    });
  }
}

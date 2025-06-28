// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../../feature/auth_screen_feature/presentation/controller/code_email_controller/code_email_controller_cubit.dart'
    as _i776;
import '../../feature/auth_screen_feature/presentation/controller/email_controller/email_controller_cubit.dart'
    as _i106;
import '../../feature/common_feature/data/data_source/local_ds/security_storage_client.dart'
    as _i703;
import '../../feature/common_feature/data/data_source/remote_ds/dio_client.dart'
    as _i399;
import '../../feature/common_feature/data/repository_impl/auth_repository_impl.dart'
    as _i358;
import '../../feature/common_feature/data/repository_impl/security_storage_repository_impl.dart'
    as _i696;
import '../../feature/common_feature/domain/repository/auth_repository.dart'
    as _i493;
import '../../feature/common_feature/domain/repository/security_storage_repository.dart'
    as _i428;
import '../../feature/common_feature/domain/usecase/confirm_code_usecase.dart'
    as _i219;
import '../../feature/common_feature/domain/usecase/login_usecase.dart'
    as _i378;
import '../../feature/main_screen_feature/data/repository_impl/user_repository_impl.dart'
    as _i934;
import '../../feature/main_screen_feature/domain/repository/user_repository.dart'
    as _i744;
import '../../feature/main_screen_feature/domain/usecase/fetch_user_id_usecase.dart'
    as _i688;
import '../../feature/main_screen_feature/presentation/controller/user_controller/user_controller_cubit.dart'
    as _i258;
import '../network/internet_connection_checker.dart' as _i657;
import '../network/network_info.dart' as _i932;
import '../network/network_info_impl.dart' as _i865;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModuleConnectionChecker = _$RegisterModuleConnectionChecker();
  gh.factory<_i973.InternetConnectionChecker>(
    () => registerModuleConnectionChecker.internetConnection,
  );
  gh.lazySingleton<_i703.SecurityStorageClient>(
    () => _i703.SecurityStorageClient(),
  );
  gh.lazySingleton<_i399.DioClient>(() => _i399.DioClient());
  gh.lazySingleton<_i428.SecurityStorageRepository>(
    () =>
        _i696.SecurityStorageRepositoryImpl(gh<_i703.SecurityStorageClient>()),
  );
  gh.lazySingleton<_i932.NetworkInfo>(
    () => _i865.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
  );
  gh.lazySingleton<_i493.AuthRepository>(
    () => _i358.AuthRepositoryImpl(
      gh<_i932.NetworkInfo>(),
      gh<_i399.DioClient>(),
      gh<_i703.SecurityStorageClient>(),
    ),
  );
  gh.lazySingleton<_i744.UserRepository>(
    () => _i934.UserRepositoryImpl(
      gh<_i932.NetworkInfo>(),
      gh<_i399.DioClient>(),
      gh<_i493.AuthRepository>(),
      gh<_i428.SecurityStorageRepository>(),
    ),
  );
  gh.lazySingleton<_i219.ConfirmCodeUseCase>(
    () => _i219.ConfirmCodeUseCase(gh<_i493.AuthRepository>()),
  );
  gh.lazySingleton<_i378.LoginUseCase>(
    () => _i378.LoginUseCase(gh<_i493.AuthRepository>()),
  );
  gh.lazySingleton<_i776.CodeEmailControllerCubit>(
    () => _i776.CodeEmailControllerCubit(gh<_i219.ConfirmCodeUseCase>()),
  );
  gh.lazySingleton<_i688.FetchUserIdUseCase>(
    () => _i688.FetchUserIdUseCase(gh<_i744.UserRepository>()),
  );
  gh.lazySingleton<_i106.EmailControllerCubit>(
    () => _i106.EmailControllerCubit(
      gh<_i378.LoginUseCase>(),
      gh<_i776.CodeEmailControllerCubit>(),
    ),
  );
  gh.lazySingleton<_i258.UserControllerCubit>(
    () => _i258.UserControllerCubit(gh<_i688.FetchUserIdUseCase>()),
  );
  return getIt;
}

class _$RegisterModuleConnectionChecker
    extends _i657.RegisterModuleConnectionChecker {}

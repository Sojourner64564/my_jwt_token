import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/injectable/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);
import 'package:flutter_application_1/domain/usecases/auth/sigin.dart';
import 'package:flutter_application_1/domain/usecases/auth/signup.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_application_1/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_application_1/domain/repository/auth/auth.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  // Register repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());
}

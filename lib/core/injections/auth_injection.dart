import 'package:rebuni/features/authentication/domain/use_cases/check_first_time_login_use_case.dart';
import 'package:rebuni/features/authentication/presentation/bloc/otp_bloc/otp_bloc_bloc.dart';

import '../../features/authentication/data/datasource/supabase_data_source.dart';
import '../../features/authentication/data/repository/user_repository.dart';
import '../../features/authentication/domain/repository/sign_is_repository.dart';
import '../../features/authentication/domain/use_cases/profile_usecase.dart';
import '../../features/authentication/domain/use_cases/provider_sign_in_usecase.dart';
import '../../features/authentication/domain/use_cases/sign_in_usecase.dart';
import '../../features/authentication/domain/use_cases/verify_otp_usecase.dart';
import '../../features/authentication/presentation/bloc/provider_sign_in/provider_sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'injection_container.dart';

Future<void> authInjectionInit() async {
  //!bloc
  getIt.registerFactory(() => SignInBloc(getIt()));
  getIt.registerFactory(() => OtpBlocBloc(getIt()));
  getIt.registerFactory(() => SignUpBloc(getIt()));
  getIt.registerFactory(() => ProviderSignInBloc(getIt()));

  //!usecase
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOTPUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => FirstTimeUseCase(getIt()));
  getIt.registerLazySingleton(() => ProviderSignInUseCase(getIt()));


  //!repository
  getIt
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt()));

  //!datasource
  getIt.registerLazySingleton<SupabaseDataSource>(
      () => SupabaseDataSourceImpl(getIt()));
}

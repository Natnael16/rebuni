import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/bloc/otp_bloc/otp_bloc_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import '../injections/injection_container.dart';

List<BlocProvider> getAllBlocProviders() {
  return [
    BlocProvider<SignInBloc>(create: (_) => getIt<SignInBloc>()),
    BlocProvider<OtpBlocBloc>(create: (_) => getIt<OtpBlocBloc>()),
    BlocProvider<SignUpBloc>(create: (_) => getIt<SignUpBloc>()),

    

  ];
}

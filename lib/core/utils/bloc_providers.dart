import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';

import '../../features/authentication/presentation/bloc/otp_bloc/otp_bloc_bloc.dart';
import '../../features/authentication/presentation/bloc/provider_sign_in/provider_sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../features/questions/presentation/bloc/image_picker_bloc/image_picker_bloc.dart';
import '../../features/questions/presentation/bloc/questions_bloc/questions_bloc.dart';
import '../injections/injection_container.dart';

List<BlocProvider> getAllBlocProviders() {
  return [
    BlocProvider<SignInBloc>(create: (_) => getIt<SignInBloc>()),
    BlocProvider<OtpBlocBloc>(create: (_) => getIt<OtpBlocBloc>()),
    BlocProvider<SignUpBloc>(create: (_) => getIt<SignUpBloc>()),
    BlocProvider<ProviderSignInBloc>(create: (_) => getIt<ProviderSignInBloc>()),
    BlocProvider<CategorySelectorBloc>(create: (_) => CategorySelectorBloc()),
    BlocProvider<ImagePickerBloc>(create: (_) => ImagePickerBloc()),

    //! Questions

    BlocProvider<QuestionsBloc>(create: (_) => getIt<QuestionsBloc>(),)
  ];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebuni/features/questions/presentation/bloc/categroy_selector_bloc/category_selector_bloc.dart';

import '../../features/authentication/presentation/bloc/otp_bloc/otp_bloc_bloc.dart';
import '../../features/authentication/presentation/bloc/provider_sign_in/provider_sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../features/questions/presentation/bloc/add_answer_bloc/add_answer_bloc.dart';
import '../../features/questions/presentation/bloc/add_discussion_bloc/add_discussion_bloc.dart';
import '../../features/questions/presentation/bloc/get_answers_bloc/get_answers_bloc.dart';
import '../../features/questions/presentation/bloc/get_discussions_bloc/get_discussions_bloc.dart';
import '../../features/questions/presentation/bloc/get_questions_bloc/get_questions_bloc.dart';
import '../../features/questions/presentation/bloc/get_replies_bloc/get_replies_bloc.dart';
import '../../features/questions/presentation/bloc/image_picker_bloc/image_picker_bloc.dart';
import '../../features/questions/presentation/bloc/post_question_bloc/questions_bloc.dart';
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

    BlocProvider<QuestionsBloc>(create: (_) => getIt<QuestionsBloc>()),
    BlocProvider<GetQuestionsBloc>(create: (_) => getIt<GetQuestionsBloc>()),
    BlocProvider<GetAnswersBloc>(create: (_) => getIt<GetAnswersBloc>()),
    BlocProvider<GetDiscussionsBloc>(create: (_) => getIt<GetDiscussionsBloc>()),
    BlocProvider<GetRepliesBloc>(create: (_) => getIt<GetRepliesBloc>()),
    BlocProvider<AddDiscussionBloc>(create: (_) => getIt<AddDiscussionBloc>()),
    BlocProvider<AddAnswerBloc>(create: (_) => getIt<AddAnswerBloc>()),

    
  ];
}

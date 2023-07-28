import '../../features/questions/data/datasource/questions_supabase_datasource.dart';
import '../../features/questions/data/repository/questions_repository_impl.dart';
import '../../features/questions/domain/repository/questions_repository.dart';
import '../../features/questions/domain/usecase/get_answers_usecase.dart';
import '../../features/questions/domain/usecase/get_discussions_usecase.dart';
import '../../features/questions/domain/usecase/get_questions_usecase.dart';
import '../../features/questions/domain/usecase/get_replies_usecase.dart';
import '../../features/questions/domain/usecase/post_question_usecase.dart';
import '../../features/questions/presentation/bloc/get_answers_bloc/get_answers_bloc.dart';
import '../../features/questions/presentation/bloc/get_discussions_bloc/get_discussions_bloc.dart';
import '../../features/questions/presentation/bloc/get_questions_bloc/get_questions_bloc.dart';
import '../../features/questions/presentation/bloc/get_replies_bloc/get_replies_bloc.dart';
import '../../features/questions/presentation/bloc/post_question_bloc/questions_bloc.dart';
import 'injection_container.dart';

Future<void> questionsInjectionInit() async {
  getIt.registerFactory(() => QuestionsBloc(getIt()));
  getIt.registerFactory(() => GetQuestionsBloc(getIt()));
  getIt.registerFactory(() => GetAnswersBloc(getIt()));
  getIt.registerFactory(() => GetDiscussionsBloc(getIt()));
  getIt.registerFactory(() => GetRepliesBloc(getIt()));

  getIt.registerLazySingleton(() => PostQuestionUseCase(getIt()));
  getIt.registerLazySingleton(() => GetQuestionsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAnswersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetDiscussionsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetRepliesUseCase(getIt()));

  getIt.registerLazySingleton<QuestionsRepository>(() => QuestionsRepositoryImpl(getIt()));

  getIt.registerLazySingleton<SupabaseQuestionsDataSource>(
      () => SupabaseQuestionsDataSourceImpl(getIt()));

}

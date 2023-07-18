import '../../features/questions/data/datasource/questions_supabase_datasource.dart';
import '../../features/questions/data/repository/questions_repository_impl.dart';
import '../../features/questions/domain/repository/questions_repository.dart';
import '../../features/questions/domain/usecase/post_question_usecase.dart';
import '../../features/questions/presentation/bloc/questions_bloc/questions_bloc.dart';
import 'injection_container.dart';

Future<void> questionsInjectionInit() async {
  getIt.registerFactory(() => QuestionsBloc(getIt()));

  getIt.registerLazySingleton(() => PostQuestionUseCase(getIt()));

  getIt.registerLazySingleton<QuestionsRepository>(() => QuestionsRepositoryImpl(getIt()));

  getIt.registerLazySingleton<SupabaseQuestionsDataSource>(
      () => SupabaseQuestionsDataSourceImpl(getIt()));


}

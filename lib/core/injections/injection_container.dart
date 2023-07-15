import 'package:get_it/get_it.dart';

import '../../main.dart';
import 'auth_injection.dart';

var getIt = GetIt.instance;

Future<void> injectionInit() async {
  await authInjectionInit();

  //! Common

  getIt.registerLazySingleton(() => supabase);
}

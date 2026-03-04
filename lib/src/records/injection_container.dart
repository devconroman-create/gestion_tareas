import 'package:gestion_tareas/src/domain/repositories/task_repository.dart';
import 'package:gestion_tareas/src/domain/repositories/task_respository_impl.dart';
import 'package:gestion_tareas/src/domain/use_case/get_tasks.dart';
import 'package:gestion_tareas/src/presentation/providers/task_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

Future<void> init(GetIt getIt) async {
  getIt.registerFactory(() => TaskProvider(getTasks: getIt()));

  getIt.registerLazySingleton(() => GetTasks(getIt()));

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRespositoryImpl(client: getIt()),
  );

  getIt.registerLazySingleton(() => http.Client());
}

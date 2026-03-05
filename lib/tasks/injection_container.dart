import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';
import 'package:gestion_tareas/tasks/domain/repositories/task_respository_impl.dart';
import 'package:gestion_tareas/tasks/domain/use_case/get_tasks.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_form_privider.dart'
    show TaskFormProvider;
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

Future<void> init(GetIt getIt) async {
  getIt.registerFactory(() => TaskProvider(getTasks: getIt()));
  getIt.registerFactory(() => TaskFormProvider());

  getIt.registerLazySingleton(() => GetTasks(getIt()));

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRespositoryImpl(client: getIt()),
  );

  getIt.registerLazySingleton(() => http.Client());
}

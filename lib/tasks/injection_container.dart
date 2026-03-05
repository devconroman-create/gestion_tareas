import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';
import 'package:gestion_tareas/tasks/domain/repositories/task_respository_impl.dart';
import 'package:gestion_tareas/tasks/domain/use_case/add_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/delete_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/get_tasks.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_form_privider.dart'
    show TaskFormProvider;
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

Future<void> init(GetIt getIt) async {
  //* provider
  getIt.registerFactory(
    () => TaskProvider(
      getTasks: getIt(),
      addTasks: getIt(),
      deleteTasks: getIt(),
    ),
  );
  getIt.registerFactory(() => TaskFormProvider());

  //*caso de uso
  getIt.registerLazySingleton(() => GetTasks(getIt()));
  getIt.registerLazySingleton(() => AddTasks(getIt()));
  getIt.registerLazySingleton(() => DeleteTasks(getIt()));

  //*Repositorios
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRespositoryImpl(client: getIt()),
  );

  getIt.registerLazySingleton(() => http.Client());
}

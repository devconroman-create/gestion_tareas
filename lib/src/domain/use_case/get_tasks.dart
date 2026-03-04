import 'package:gestion_tareas/src/domain/entities/tasks.dart';
import 'package:gestion_tareas/src/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  GetTasks(this.repository);

  Future<List<Tasks>> call() => repository.getTasks();
}

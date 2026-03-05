import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';
import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  GetTasks(this.repository);

  Future<List<Tasks>> call() => repository.getTasks();
}

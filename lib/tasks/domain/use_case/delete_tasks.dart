import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart'
    show TaskRepository;

class DeleteTasks {
  final TaskRepository repository;

  DeleteTasks(this.repository);

  Future<void> call(int idtasks) => repository.deleteTask(idtasks);
}

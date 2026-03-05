// get_task_by_id.dart — solo obtener por id
import 'package:gestion_tareas/tasks/domain/entities/task_detail.dart';
import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';

class GetTaskById {
  final TaskRepository repository;
  GetTaskById(this.repository);

  Future<TaskDetail> call(int idTask) => repository.getTasksById(idTask);
}

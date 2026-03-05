import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart';
import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';

class UpdateTasks {
  final TaskRepository repository;

  UpdateTasks(this.repository);

  Future<void> call(int idtasks, List<TasksDetailModel> tasks) =>
      repository.isCompletedTaskId(idtasks, tasks);
}

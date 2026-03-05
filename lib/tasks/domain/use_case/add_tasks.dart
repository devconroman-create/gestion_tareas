import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart'
    show TasksDetailModel;
import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';

class AddTasks {
  final TaskRepository repository;

  AddTasks(this.repository);

  Future<void> call(List<TasksDetailModel> tasks) => repository.addTask(tasks);
}

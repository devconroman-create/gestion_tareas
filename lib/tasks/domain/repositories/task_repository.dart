import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart'
    show TasksDetailModel;
import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';

abstract class TaskRepository {
  Future<List<Tasks>> getTasks();
  Future<dynamic> addTask(List<TasksDetailModel> tasks);
  Future<dynamic> deleteTask(int idtasks);
}

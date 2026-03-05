import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart'
    show TasksDetailModel;
import 'package:gestion_tareas/tasks/domain/entities/task_detail.dart';
import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';

abstract class TaskRepository {
  Future<List<Tasks>> getTasks();
  Future<dynamic> addTask(List<TasksDetailModel> tasks);
  Future<dynamic> deleteTask(int idtasks);
  Future<TaskDetail> getTasksById(int idtasks);
  Future<dynamic> isCompletedTaskId(int idtasks, List<TasksDetailModel> tasks);
}

import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';

abstract class TaskRepository {
  Future<List<Tasks>> getTasks();
  Future<void> addTask();
}

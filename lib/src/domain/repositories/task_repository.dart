import 'package:gestion_tareas/src/domain/entities/tasks.dart';

abstract class TaskRepository {
  Future<List<Tasks>> getTasks();
}

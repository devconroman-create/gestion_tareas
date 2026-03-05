import 'package:flutter/foundation.dart';
import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart'
    show TasksDetailModel;
import 'package:gestion_tareas/tasks/domain/entities/task_detail.dart';
import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/add_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/delete_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/get_task_by_id.dart';
import 'package:gestion_tareas/tasks/domain/use_case/get_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/update_tasks.dart';

enum TaskState { initial, loading, succes, error }

class TaskProvider extends ChangeNotifier {
  final GetTasks getTasks;
  final AddTasks addTasks;
  final DeleteTasks deleteTasks;
  final UpdateTasks updateTasks;
  final GetTaskById getTaskById;

  TaskProvider({
    required this.getTasks,
    required this.addTasks,
    required this.deleteTasks,
    required this.updateTasks,
    required this.getTaskById,
  });

  TaskState _state = TaskState.initial;
  List<Tasks> _tasks = [];
  TaskDetail? _selectedTask;

  String? _errorMessage;

  TaskState get state => _state;
  List<Tasks> get tasks => _tasks;
  TaskDetail? get selectedTask => _selectedTask;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == TaskState.loading;

  Future<void> fetchTasks() async {
    _setState(TaskState.loading);
    try {
      _tasks = await getTasks();
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al obtener tareas: ${e.toString()}");
      _setError("Error al obtener tareas");
    }
  }

  Future<void> fetchTasksbyId(int idTask) async {
    _setState(TaskState.loading);
    try {
      _selectedTask = await getTaskById(idTask);
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al obtener tarea: ${e.toString()}");
      _setError("Error al obtener tarea");
    }
  }

  Future<dynamic> createTask(List<TasksDetailModel> tasks) async {
    _setState(TaskState.loading);
    try {
      await addTasks(tasks);
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al agregar tarea: ${e.toString()}");
      _setError("Error al agregar tarea");
    }
  }

  Future<dynamic> deleteTaskId(int idTasks) async {
    _setState(TaskState.loading);
    try {
      await deleteTasks(idTasks);
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al eliminar tarea: ${e.toString()}");
      _setError("Error al eliminar tarea");
    }
  }

  Future<dynamic> updateTaskStatus(
    int idTasks,
    List<TasksDetailModel> tasks,
  ) async {
    _setState(TaskState.loading);
    try {
      await updateTasks(idTasks, tasks);
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al actualizar estado de tarea: ${e.toString()}");
      _setError("Error al actualizar estado de tarea");
    }
  }

  void _setState(TaskState state) {
    _state = state;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _state = TaskState.error;
    _errorMessage = message;
    notifyListeners();
  }
}

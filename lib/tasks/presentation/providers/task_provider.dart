import 'package:flutter/foundation.dart';
import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart'
    show TasksDetailModel;
import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/add_tasks.dart';
import 'package:gestion_tareas/tasks/domain/use_case/get_tasks.dart';

enum TaskState { initial, loading, succes, error }

class TaskProvider extends ChangeNotifier {
  final GetTasks getTasks;
  final AddTasks addTasks;

  TaskProvider({required this.getTasks, required this.addTasks});

  TaskState _state = TaskState.initial;
  List<Tasks> _tasks = [];
  String? _errorMessage;

  TaskState get state => _state;
  List<Tasks> get tasks => _tasks;
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

  Future<dynamic> createTask(List<TasksDetailModel> tasks) async {
    _setState(TaskState.loading);
    try {
      await addTasks(tasks);
      _setState(TaskState.succes);
    } catch (e) {
      debugPrint("Error al agregar tarea: ${e.toString()}");
      _setError("Error al agregar tareas");
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

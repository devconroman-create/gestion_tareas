import 'dart:convert';

import 'package:gestion_tareas/tasks/data/models/task_model.dart';
import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_tareas/tasks/domain/repositories/task_repository.dart';

class TaskRespositoryImpl implements TaskRepository {
  final http.Client client;
  String baseUrl = "ecsdevapi.nextline.mx";

  TaskRespositoryImpl({required this.client});

  Map<String, String> get _headers => {
    "Content-Type": "application/json; charset=utf-8",
    'Authorization':
        'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
  };

  @override
  Future<List<Tasks>> getTasks() async {
    String tasksPath = "/vdev/tasks-challenge/tasks";

    final uri = Uri.https(baseUrl, tasksPath, {"token": "lgrsflutterdev2026"});

    final response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TasksModel.fromJson(e)).toList();
    }
    throw Exception("Error al obtener tareas");
  }

  @override
  Future<List<Tasks>> addTask() async {
    String tasksPath = "/vdev/tasks-challenge/tasks";

    final uri = Uri.https(baseUrl, tasksPath);

    final response = await client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TasksModel.fromJson(e)).toList();
    }
    throw Exception("Error al obtener tareas");
  }
}

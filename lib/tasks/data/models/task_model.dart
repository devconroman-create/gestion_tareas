import 'package:gestion_tareas/tasks/domain/entities/tasks.dart';

class TasksModel extends Tasks {
  TasksModel({
    required super.id,
    required super.title,
    required super.isCompleted,
    super.dueDate,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
    id: json["id"] as int,
    title: json["title"] as String,
    isCompleted: json["is_completed"] as int,
    dueDate: json["due_date"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "is_completed": isCompleted,
    "due_date": dueDate,
  };
}

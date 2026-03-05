import 'package:gestion_tareas/tasks/domain/entities/task_detail.dart';

class TasksDetailModel extends TaskDetail {
  TasksDetailModel({
    super.id,
    required super.title,
    required super.isCompleted,
    super.dueDate,
    super.comments,
    super.description,
    super.tags,
    super.token,
    super.createdAt,
    super.updatedAt,
  });

  factory TasksDetailModel.fromJson(Map<String, dynamic> json) {
    return TasksDetailModel(
      id: json["id"].toString(),
      title: json["title"] as String,
      isCompleted: json["is_completed"] as int,
      dueDate: json["due_date"]?.toString(),
      comments: json["comments"]?.toString(),
      description: json["description"]?.toString(),
      tags: json["tags"]?.toString(),
      token: json["token"]?.toString(),
      createdAt: json["created_at"]?.toString(),
      updatedAt: json["updated_date"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "token": token,
      "title": title,
      "is_completed": isCompleted,
    };

    if (dueDate != null) data["due_date"] = dueDate;
    if (comments != null) data["comments"] = comments;
    if (description != null) data["description"] = description;
    if (tags != null) data["tags"] = tags;

    return data;
  }
}

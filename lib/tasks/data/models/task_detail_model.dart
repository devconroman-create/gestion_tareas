class TasksDetailModel {
  final String token;
  final String title;
  final int isCompleted;
  final String? dueDate;
  final String? comments;
  final String? description;
  final String? tags;

  TasksDetailModel({
    required this.token,
    required this.title,
    required this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
  });

  factory TasksDetailModel.fromJson(Map<String, dynamic> json) {
    return TasksDetailModel(
      token: json["token"],
      title: json["title"],
      isCompleted: json["is_completed"],
      dueDate: json["due_date"] as String?,
      comments: json["comments"] as String?,
      description: json["description"] as String?,
      tags: json["tags"] as String?,
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

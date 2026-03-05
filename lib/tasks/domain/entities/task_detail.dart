class TaskDetail {
  String? id;
  final String title;
  final int isCompleted;
  final String? dueDate;
  final String? comments;
  final String? description;
  final String? tags;
  final String? token;
  final String? createdAt;
  final String? updatedAt;

  TaskDetail({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
    this.token,
    this.createdAt,
    this.updatedAt,
  });
}

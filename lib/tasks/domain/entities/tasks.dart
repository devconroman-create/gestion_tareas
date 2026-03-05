class Tasks {
  final int id;
  final String title;
  final int isCompleted;
  final String? dueDate;

  Tasks({
    required this.id,
    required this.title,
    required this.isCompleted,
    this.dueDate,
  });
}

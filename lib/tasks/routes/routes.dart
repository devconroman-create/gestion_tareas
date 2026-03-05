import 'package:flutter/widgets.dart';
import 'package:gestion_tareas/tasks/presentation/screens/new_task_form_screen.dart';
import 'package:gestion_tareas/tasks/presentation/screens/tasks_list_screen.dart';

class AppRoutes {
  static const String tasksListScreen = 'tasksList';
  static const String newTaskFormScreen = 'newTaskForm';

  static Map<String, WidgetBuilder> routes = {
    tasksListScreen: (context) => const TaskListScreen(),
    newTaskFormScreen: (context) => NewTaskFormScreen(),
  };
}

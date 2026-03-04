import 'package:flutter/widgets.dart';
import 'package:gestion_tareas/src/presentation/screens/tasks_list_screen.dart';

class AppRoutes {
  static const String tasksListScreen = 'tasksList';

  static Map<String, WidgetBuilder> routes = {
    tasksListScreen: (context) => const TaskListScreen(),
  };
}

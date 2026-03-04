import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestion_tareas/src/presentation/providers/task_provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      await context.read<TaskProvider>().fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.state == TaskState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.state == TaskState.error) {
            return Center(
              child: Text(provider.errorMessage ?? "Error al obtener tareas"),
            );
          }

          if (provider.tasks.isEmpty) {
            return Center(child: Text("No tienes tareas"));
          }

          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(title: Text(task.title));
            },
          );
        },
      ),
    );
  }
}

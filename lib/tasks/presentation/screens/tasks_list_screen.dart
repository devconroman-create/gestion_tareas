import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart';

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
      appBar: AppBar(
        title: Text(
          "ADT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
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

          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 8,
                        spreadRadius: 1.5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      selectedColor: Colors.red,
                      focusColor: Colors.amber,
                      onTap: () {
                        print(task.id);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(25),
        ),

        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.newTaskFormScreen);
          },
          icon: Icon(Icons.add, color: Colors.white, size: 33),
        ),
      ),
    );
  }
}

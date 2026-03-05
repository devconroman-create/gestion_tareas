// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/presentation/screens/new_task_form_screen.dart';
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
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 4,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: task.isCompleted == 1
                            ? const Color.fromARGB(255, 204, 244, 205)
                            : Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 74, 83, 90),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(task.title),
                        selectedColor: Colors.red,
                        focusColor: Colors.amber,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                task.isCompleted == 1
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.isCompleted == 1
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Delete task"),
                                    content: Text(
                                      "Are you sure you want to delete this task?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await provider.deleteTaskId(task.id);
                                          Navigator.of(context).pop();

                                          if (!mounted) return;
                                          context
                                              .read<TaskProvider>()
                                              .fetchTasks();
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        onTap: () {
                          print(task.id);
                        },
                      ),
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
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewTaskFormScreen()),
            );

            if (!mounted) return;
            context.read<TaskProvider>().fetchTasks();
          },
          icon: Icon(Icons.add, color: Colors.white, size: 33),
        ),
      ),
    );
  }
}

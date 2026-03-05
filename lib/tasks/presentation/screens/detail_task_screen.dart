// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart';
import 'package:gestion_tareas/tasks/presentation/screens/new_task_form_screen.dart';
import 'package:provider/provider.dart';

class DetailTaskScreen extends StatefulWidget {
  final int? idTask;

  const DetailTaskScreen({super.key, this.idTask});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    if (widget.idTask != null) {
      Future.microtask(() async {
        await context.read<TaskProvider>().fetchTasksbyId(widget.idTask!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 33),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          final task = taskProvider.selectedTask;

          if (task == null) return const CircularProgressIndicator();
          (task.isCompleted == 1) ? isCompleted = true : isCompleted = false;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),

                _data(
                  title: "Description",
                  description: task.description,
                  width: size.width * 0.8,
                  height: size.height * 0.18,
                ),
                SizedBox(height: 20),
                _data(
                  title: "Comments",
                  description: task.comments,
                  width: size.width * 0.8,
                  height: size.height * 0.12,
                ),

                SizedBox(height: 20),
                _data(
                  title: "Due Date",
                  description: task.dueDate,
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                ),

                SizedBox(height: 20),
                _data(
                  title: "Tags",
                  description: task.tags,
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Completed "),
                    Switch(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {});
                        isCompleted = value;
                      },
                      activeThumbColor: Colors.lightBlue,
                    ),
                  ],
                ),
              ],
            ),
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
              MaterialPageRoute(
                builder: (_) =>
                    NewTaskFormScreen(isEdit: true, idTask: widget.idTask),
              ),
            );
            if (!mounted) return;
            await context.read<TaskProvider>().fetchTasksbyId(widget.idTask!);
          },
          icon: Icon(Icons.edit, color: Colors.white, size: 33),
        ),
      ),
    );
  }

  Widget _data({
    required String title,
    String? description,
    required double width,
    required double height,
  }) {
    return Visibility(
      visible: description != null && description.isNotEmpty,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: const Color.fromARGB(255, 74, 83, 90),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 8,
                  spreadRadius: 1.5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(description ?? ''),
          ),
        ],
      ),
    );
  }
}

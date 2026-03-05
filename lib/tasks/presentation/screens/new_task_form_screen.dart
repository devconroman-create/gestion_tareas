import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/data/models/task_detail_model.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_form_privider.dart'
    show TaskFormProvider;
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart'
    show TaskProvider, TaskState;
import 'package:gestion_tareas/tasks/presentation/widgets/new_task_form_widget.dart'
    show NewTaskFormWidget;
import 'package:provider/provider.dart';

class NewTaskFormScreen extends StatefulWidget {
  const NewTaskFormScreen({super.key});

  @override
  State<NewTaskFormScreen> createState() => _NewTaskFormScreenState();
}

class _NewTaskFormScreenState extends State<NewTaskFormScreen> {
  final TextEditingController dueDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 33),
          onPressed: () {
            if (!mounted) return;
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: ChangeNotifierProvider(
        create: (context) => TaskFormProvider(),
        child: Consumer<TaskFormProvider>(
          builder: (context, provider, _) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: Column(
                  children: [
                    Text(
                      "New Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    NewTaskFormWidget().textField(
                      provider: provider.title,
                      icon: Icons.title,
                      hintText: "Title",
                      errorText: provider.titleError,
                      onChanged: provider.updateTitle,
                    ),
                    NewTaskFormWidget().textField(
                      provider: provider.description,
                      icon: Icons.comment,
                      hintText: "Comments",
                      errorText: provider.commentsError,
                      onChanged: provider.updateComments,
                    ),
                    NewTaskFormWidget().textField(
                      provider: provider.title,
                      icon: Icons.task,
                      hintText: "Description",
                      errorText: provider.descriptionError,
                      onChanged: provider.updateDescription,
                    ),
                    NewTaskFormWidget().textField(
                      provider: provider.description,
                      icon: Icons.edit_note,
                      hintText: "Tag",
                      errorText: provider.tagsError,
                      onChanged: provider.updateTags,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: Row(
                            children: [
                              const Text("Completed "),
                              Switch(
                                value: provider.isCompleted,
                                onChanged: provider.updateCompleted,
                                activeThumbColor: Colors.lightBlue,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.46,
                          child: NewTaskFormWidget().textField(
                            provider: provider.description,
                            icon: Icons.calendar_today,
                            hintText: "Date",
                            controller: dueDateController,
                            errorText: provider.dueDateError,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                const Duration(milliseconds: 100),
                              );
                              if (!context.mounted) return;
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                provider.updateDueDate(pickedDate);
                                dueDateController.text = provider.dueDate;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Consumer<TaskProvider>(
                      builder: (context, taskProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: size.width * 0.35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                onPressed: taskProvider.isLoading
                                    ? null
                                    : () {
                                        provider.resetForm();
                                        if (!mounted) return;
                                        Navigator.pop(context);
                                      },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                ),
                                onPressed: taskProvider.isLoading
                                    ? null
                                    : () async {
                                        final scaffoldMessenger =
                                            ScaffoldMessenger.of(context);
                                        if (provider.isValidForm) {
                                          final navigator = Navigator.of(
                                            context,
                                          );

                                          List<TasksDetailModel> listTask = [];
                                          listTask.add(
                                            TasksDetailModel(
                                              token: "lgrsflutterdev2026",
                                              title: provider.title,
                                              isCompleted:
                                                  (provider.isCompleted == true)
                                                  ? 1
                                                  : 0,
                                              description: provider.description,
                                              comments: provider.comments,
                                              tags: provider.tags,
                                              dueDate: provider.dueDateError,
                                            ),
                                          );

                                          await taskProvider.addTasks(listTask);

                                          if (!mounted) return;

                                          if (taskProvider.state ==
                                              TaskState.error) {
                                            scaffoldMessenger.showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  taskProvider.errorMessage ??
                                                      'Unexpected error',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Added successfully',
                                              ),
                                              backgroundColor:
                                                  Colors.lightGreen,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );

                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                          );
                                          if (!mounted) return;

                                          provider.resetForm();
                                          navigator.pop();
                                        } else {
                                          scaffoldMessenger.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Complete all fields',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                    255,
                                                    201,
                                                    185,
                                                    44,
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                child: taskProvider.isLoading
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.red,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 4,
                                        ),
                                      )
                                    : Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

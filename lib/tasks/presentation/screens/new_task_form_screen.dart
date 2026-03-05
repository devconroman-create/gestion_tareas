import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_form_privider.dart'
    show TaskFormProvider;
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
                    _textField(
                      provider: provider.title,
                      icon: Icons.title,
                      hintText: "Title",
                      errorText: provider.titleError,
                      onChanged: provider.updateTitle,
                    ),
                    _textField(
                      provider: provider.description,
                      icon: Icons.comment,
                      hintText: "Comments",
                      errorText: provider.commentsError,
                      onChanged: provider.updateComments,
                    ),
                    _textField(
                      provider: provider.title,
                      icon: Icons.task,
                      hintText: "Description",
                      errorText: provider.descriptionError,
                      onChanged: provider.updateDescription,
                    ),
                    _textField(
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
                          child: _textField(
                            provider: provider.description,
                            icon: Icons.calendar_today,
                            hintText: "Date",
                            controller: dueDateController,

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {
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
                            onPressed: () {},
                            child: const Text(
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

  Widget _textField({
    required dynamic provider,
    required String hintText,
    TextEditingController? controller,
    String? errorText,
    required IconData icon,
    ValueChanged<String?>? onChanged,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: hintText == "Date",
        controller: controller,
        style: const TextStyle(fontSize: 14),
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,

          errorText: errorText,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

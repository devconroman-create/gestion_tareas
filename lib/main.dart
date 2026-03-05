import 'package:flutter/material.dart';
import 'package:gestion_tareas/tasks/presentation/providers/task_form_privider.dart'
    show TaskFormProvider;
import 'package:gestion_tareas/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

import 'package:gestion_tareas/tasks/routes/routes.dart';

import 'injection_container.dart' as i_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await i_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => i_container.getIt<TaskProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => i_container.getIt<TaskFormProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'ADT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: const Color.fromARGB(255, 33, 147, 185),
          ),
        ),
        initialRoute: AppRoutes.tasksListScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}

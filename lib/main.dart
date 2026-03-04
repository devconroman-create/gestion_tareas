import 'package:flutter/material.dart';
import 'package:gestion_tareas/src/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

import 'package:gestion_tareas/src/routes/routes.dart';

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

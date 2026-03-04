import 'package:get_it/get_it.dart';

import 'package:gestion_tareas/src/records/injection_container.dart'
    as injector_container;

final getIt = GetIt.instance;

Future<void> init() async {
  await injector_container.init(getIt);
}

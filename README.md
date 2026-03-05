# gestion_tareas

Aplicación móvil desarrollada para uso basico de gestion de tareas,con las siguientes funcionalidades: - Visualizar lista de tareas. - Ver el detalle individual de una tarea. - Crear nueva tarea. - Editar tarea existente. - Eliminar tarea.

Para utilizar este proyecto se requiere:

Flutter 3.41.2

url de descarga para fluter SDK:
https://docs.flutter.dev/install/archive

En esta aplicación utilice la arquitectura de clean architecture, ya que permite
separar las capas.
Domain tiene la logica de negocio
Data contine los model que se utiliza en la API
Presentation mandeja toda la interfaz y el provider
Para el manejo de estados utilice provider ya que nos permite estar escuchando, los estados de peticones y cambios.

Utilice GetIt es una libreria donde se almacena todos los objetos que necesito en la app
Y con esto se realiza mas facil la inyeccion de mis casos de uso y providers.

La app muestra un listado de tareas
existe un boton para agregar tareas
en la tarea existe un boton para eliminarlas
click a la tarea y me envia a detalle de tareas - boton de editar y me envia al formularios para poder editar los datos

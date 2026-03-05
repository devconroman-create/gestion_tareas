import 'package:flutter/material.dart';

class TaskFormProvider extends ChangeNotifier {
  String title = "";
  bool isCompleted = false;
  String dueDate = "";
  String comments = "";
  String description = "";
  String tags = "";

  String? titleError;
  String? dueDateError;
  String? commentsError;
  String? descriptionError;
  String? tagsError;

  void updateTitle(String? value) {
    title = value?.trim() ?? '';
    titleError = title.isEmpty ? 'El título es obligatorio' : null;
    notifyListeners();
  }

  void updateCompleted(bool? value) {
    isCompleted = value ?? false;
    notifyListeners();
  }

  void updateDueDate(DateTime? value) {
    if (value == null) {
      dueDate = '';
      dueDateError = null;
    } else {
      dueDate =
          "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
      dueDateError = null;
    }

    notifyListeners();
  }

  void updateComments(String? value) {
    comments = value ?? '';
    notifyListeners();
  }

  void updateDescription(String? value) {
    description = value ?? '';

    if (description.isNotEmpty && description.length < 5) {
      descriptionError = 'Mínimo 5 caracteres';
    } else {
      descriptionError = null;
    }

    notifyListeners();
  }

  void updateTags(String? value) {
    tags = value ?? '';
    notifyListeners();
  }

  String? _validateDate(String value) {
    try {
      DateTime.parse(value);
      return "";
    } catch (_) {
      return 'Formato de fecha inválido (yyyy-mm-dd)';
    }
  }

  bool get isValidForm {
    updateTitle(title);
    updateDescription(description);

    return [titleError, descriptionError].every((e) => e == null);
  }

  void resetForm() {
    title = '';
    dueDate = '';
    comments = '';
    description = '';
    tags = '';

    titleError = null;
    dueDateError = null;
    descriptionError = null;

    notifyListeners();
  }
}

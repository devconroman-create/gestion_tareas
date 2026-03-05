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
    if (title.isEmpty) {
      titleError = 'Title is required';
    } else if (title.length < 3) {
      titleError = 'Title must be at least 3 characters';
    } else {
      titleError = null;
    }
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
      notifyListeners();
      return;
    }

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final selectedDate = DateTime(value.year, value.month, value.day);

    if (selectedDate.isBefore(todayDate)) {
      dueDate = '';
      dueDateError = "Date cannot be earlier than today";
    } else {
      dueDate =
          "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
      dueDateError = null;
    }

    notifyListeners();
  }

  void updateComments(String? value) {
    comments = value?.trim() ?? '';
    if (comments.isEmpty) {
      commentsError = null;
    } else if (comments.length > 60) {
      commentsError = "Maximum 60 characters";
    } else {
      commentsError = null;
    }

    notifyListeners();
  }

  void updateDescription(String? value) {
    description = value ?? '';

    if (description.isNotEmpty && description.length < 20) {
      descriptionError = 'Minimum 20 characters';
    } else if (description.isNotEmpty && description.length > 200) {
      descriptionError = 'Maximum 200 characters';
    } else {
      descriptionError = null;
    }

    notifyListeners();
  }

  void updateTags(String? value) {
    tags = value ?? '';
    if (tags.isNotEmpty && tags.length > 20) {
      tagsError = 'Maximum 20 characters';
    } else {
      tagsError = null;
    }
    notifyListeners();
  }

  bool get isValidForm {
    updateTitle(title);
    updateComments(comments);
    updateDescription(description);
    updateTags(tags);
    return [
      titleError,
      commentsError,
      descriptionError,
      tagsError,
      dueDateError,
    ].every((e) => e == null);
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
    commentsError = null;
    tagsError = null;

    notifyListeners();
  }
}

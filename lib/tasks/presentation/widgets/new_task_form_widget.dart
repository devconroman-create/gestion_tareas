import 'package:flutter/material.dart';

class NewTaskFormWidget {
  Widget textField({
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
          errorMaxLines: 2,
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

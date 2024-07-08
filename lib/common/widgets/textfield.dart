import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const BasicTextField({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}

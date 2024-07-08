import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  const BasicTextField(
      {super.key, required this.hint, required this.controller, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}

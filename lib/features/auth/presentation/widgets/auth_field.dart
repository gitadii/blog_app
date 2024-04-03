import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isObscure;
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
      ),
      controller: controller,
      obscureText: isObscure,
      validator: (value) {
        if (value == null) {
          return "$hint is empty!";
        }
        return null;
      },
    );
  }
}

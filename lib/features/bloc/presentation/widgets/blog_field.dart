import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const BlogField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      maxLines: null,
    );
  }
}

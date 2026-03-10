import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hint,
    required this.submit,
    this.controller,
  });

  final String hint;
  final Function(String text) submit;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        contentPadding: .symmetric(horizontal: 24, vertical: 18),
        hintText: hint,
        hintStyle: TextStyle(fontFamily: font2, color: Colors.white),
      ),

      onSubmitted: submit,
    );
  }
}

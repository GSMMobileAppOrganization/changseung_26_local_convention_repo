import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.hint,
    this.controller,
    required this.submit,
  });

  final TextEditingController? controller;
  final String hint;
  final Function(String text) submit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white, fontFamily: font2),
        border: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: .symmetric(horizontal: 24, vertical: 16),
      ),
      onSubmitted: submit,
      style: TextStyle(color: Colors.white),
      controller: controller,
    );
  }
}

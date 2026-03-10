import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/name_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_2/widgets/input.dart';
import 'package:flutter/material.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final TextEditingController _controller = TextEditingController();

  void submit(String text) {
    final number = int.tryParse(text.trim());

    if (number == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: purpleAccent,
          content: Text(
            "나이 입력은 필수이며 숫자만 입력가능합니다.",
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
        ),
      );
      return;
    }

    appController.age = number;

    appController.move(context, GenderInputScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      title: "나이를 입력해주세요.",
      prevPage: NameInputScreen(),
      count: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        child: Input(
          controller: _controller,
          hint: "나이를 입력해주세요.",
          submit: submit,
        ),
      ),
    );
  }
}

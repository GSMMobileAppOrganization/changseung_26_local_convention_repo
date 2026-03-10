import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_2/widgets/input.dart';
import 'package:flutter/material.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController();

  void submit(String text) {
    final trim = text.trim();

    if (trim.length < 2 || trim.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: purpleAccent,
          content: Text(
            "이름은 최소 2자, 최대 20자까지 가능합니다.",
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
        ),
      );
      return;
    }

    appController.name = trim;

    appController.move(context, AgeInputScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      title: "이름을 입력해주세요.",
      prevPage: OnboardingScreen(),
      count: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        child: Input(
          controller: _controller,
          hint: "이름을 입력해주세요.",
          submit: submit,
        ),
      ),
    );
  }
}

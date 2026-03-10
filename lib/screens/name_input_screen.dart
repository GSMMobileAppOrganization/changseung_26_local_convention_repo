import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_1/widgets/background.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/page_indicator.dart';
import 'package:daily_tarot_poc_app_1/widgets/text_input.dart';
import 'package:flutter/material.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController(
    text: appController.name ?? "",
  );

  void _submit(String text) {
    final String trim = text.trim();

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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgeInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      prevPage: OnboardingScreen(),
      title: "이름을 입력해주세요",
      count: 1,
      child: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: .symmetric(horizontal: 32),
            child: TextInput(
              controller: _controller,
              hint: "이름을 입력해주세요.",
              submit: _submit,
            ),
          ),
        ],
      ),
    );
  }
}

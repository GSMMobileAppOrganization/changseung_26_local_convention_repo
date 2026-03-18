import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String error = "";

  void submit(String m) {
    final res = m.trim();

    if (res.length < 2 || res.length > 20) {
      error = res.isEmpty ? "이름 입력은 필수 입니다." : "이름은 최소 2자, 최대 20자까지 가능합니다.";
      setState(() {});
      return;
    }
    appController.name = res;
    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      prevPage: OnboardingScreen(),
      progress: 1,
      title: "이름을 입력해주세요.",
      child: Padding(
        padding: .symmetric(horizontal: 48, vertical: 24),
        child: Column(
          children: [
            input(h: "이름을 입력해주세요.", submit: submit),

            SizedBox(height: 24),
            if (error.isNotEmpty)
              title14W(error, color: Colors.red, font: f2, weight: .w500),
          ],
        ),
      ),
    );
  }
}

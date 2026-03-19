import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/age_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String error = "";

  void submit(String m) {
    final trim = m.trim();
    if (trim.length < 2 || trim.length > 20) {
      error = trim.isEmpty ? "이름 입력은 필수입니다." : "이름은 최소 2자\n최대 20자까지 가능합니다.";
      setState(() {});
      return;
    }

    appController.name = trim;
    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "이름을 입력해주세요.",
      prevPage: OnboardingScreen(),
      progress: 1,
      child: Padding(
        padding: .all(48),
        child: Column(
          spacing: 24,
          children: [
            input(
              "이름을 입력해주세요.",
              submit,
              initialValue: appController.name ?? "",
            ),
            if (error.isNotEmpty)
              title14W(
                error,
                color: Colors.red,
                font: f2,
                weight: .w500,
                align: .center,
              ),
          ],
        ),
      ),
    );
  }
}

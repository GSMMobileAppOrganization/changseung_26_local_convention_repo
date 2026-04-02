import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
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
      error = res.isEmpty ? "이름 입력은 필수 입니다." : "이름은 최소 2자,\n최대 20자까지 가능합니다";
      setState(() {});
      return;
    }

    appController.saveName(res);
    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "이름을 입력해주세요.",
      prevPage: OnboardingScreen(),
      count: 1,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          spacing: 48,
          crossAxisAlignment: .center,
          children: [
            input(
              hint: "이름을 입력해주세요.",
              submit: submit,
              initialValue: appController.name ?? "",
            ),
            if (error.isNotEmpty)
              title14W(error, color: Colors.red, font: f2, align: .center),
          ],
        ),
      ),
    );
  }
}

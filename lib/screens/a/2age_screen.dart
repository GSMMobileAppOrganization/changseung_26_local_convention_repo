import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  void submit(String m) {
    final res = int.parse(m.trim());

    if (res < 1 || res > 120) {
      error = m.trim().isEmpty
          ? "나이 입력은 필수 입니다."
          : "나이는 나이는 1 이상\n120 이하의 숫자까지 입력 가능합니다";
      setState(() {});
      return;
    }
    appController.saveAge(res);
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      count: 2,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          spacing: 48,
          crossAxisAlignment: .center,
          children: [
            input(
              isN: true,
              hint: "나이를 입력해주세요.",
              submit: submit,
              initialValue: appController.age?.toString() ?? "",
            ),
            if (error.isNotEmpty)
              title14W(error, color: Colors.red, font: f2, align: .center),
          ],
        ),
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  void submit(String m) {
    final res = int.tryParse(m.trim());

    if (res == null) {
      error = "나이는 숫자만 입력 가능합니다.";
      setState(() {});
      return;
    }

    appController.age = res;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      prevPage: NameScreen(),
      progress: 2,
      title: "나이를 입력해주세요.",
      child: Padding(
        padding: .all(48),
        child: Column(
          children: [
            input(h: "나이를 입력해주세요.", submit: submit),

            SizedBox(height: 24),

            if (error.isNotEmpty)
              title14W(error, color: Colors.red, font: f2, weight: .w500),
          ],
        ),
      ),
    );
  }
}

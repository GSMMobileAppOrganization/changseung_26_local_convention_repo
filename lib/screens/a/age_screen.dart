import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  void submit(String m) {
    final n = int.tryParse(m.trim());

    if (n == null) {
      appController.showSnack(context, "나이 입력은 필수이며, 숫자만 입력 가능합니다.");
      return;
    }

    appController.age = n;
    appController.move(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      progress: 2,
      prevPage: NameScreen(),
      child: Padding(
        padding: .symmetric(vertical: 36, horizontal: 38),
        child: input("나이를 입력해주세요.", submit),
      ),
    );
  }
}

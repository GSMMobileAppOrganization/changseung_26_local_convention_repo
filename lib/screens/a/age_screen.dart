import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  void sub(String m) {
    final res = int.tryParse(m.trim());

    if (res == null) {
      appController.showSnack(context, "나이는 숫자만 입력 가능합니다.");
      return;
    }

    appController.age = res;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      progress: 2,
      child: Padding(
        padding: .symmetric(horizontal: 32, vertical: 48),
        child: input("나이를 입력해주세요.", sub),
      ),
    );
  }
}

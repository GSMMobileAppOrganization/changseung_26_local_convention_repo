import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background1.dart';
import 'package:daily_tarot_poc_app_4/widgets/input_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  void submit(String m) {
    final trim = m.trim();

    if (trim.length < 2 || trim.length > 20) {
      appController.showSnack(context, "이름은 최소 2자, 최대 20자까지 가능합니다.");
      return;
    }

    appController.name = trim;

    appController.move(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "이름을 입력해주세요.",
      progress: 1,
      prevPage: OnboardingScreen(),
      child: Padding(
        padding: .symmetric(vertical: 36, horizontal: 36),
        child: input("이름을 입력해주세요.", submit),
      ),
    );
  }
}

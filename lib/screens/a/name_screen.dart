import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  void sub(String m) {
    final res = m.trim();

    if (res.length < 2 || res.length > 20) {
      appController.showSnack(context, "이름은 최소 2자, 최대 20자까지 가능헙나다.");
      return;
    }

    appController.name = res;

    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "이름을 입력해주세요.",
      prevPage: OnboardingScreen(),
      progress: 1,
      child: Padding(
        padding: .symmetric(horizontal: 42, vertical: 48),
        child: input("이름을 입력해주세요.", sub),
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/age_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
    return BaseInputScreen(
      title: "이름을 입력해주세요.",
      progress: 1,
      prevPage: OnboardingScreen(),
      child: Padding(
        padding: .symmetric(horizontal: 36),
        child: input("이름을 입력해주세요.", submit),
      ),
    );
  }
}

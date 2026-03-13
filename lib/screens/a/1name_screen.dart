import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '2age_screen.dart';
import 'onboarding_screen.dart';

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
      prevPage: OnboardingScreen(),
      progress: 1,
      child: Padding(
        padding: .only(top: 38),
        child: SizedBox(width: 320, child: input("이름을 입력해주세요.", submit)),
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "성별을 선택해주세요.",
      progress: 3,
      prevPage: AgeScreen(),
      child: Padding(
        padding: .symmetric(vertical: 120),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 32,
          children: [
            genderButton(false, () {
              appController.isMale = false;
              appController.move(context, DateScreen());
            }),
            genderButton(true, () {
              appController.isMale = true;
              appController.move(context, DateScreen());
            }),
          ],
        ),
      ),
    );
  }
}

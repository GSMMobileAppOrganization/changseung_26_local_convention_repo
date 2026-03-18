import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "성별을 선택해주세요.",
      prevPage: AgeScreen(),
      progress: 3,
      child: Padding(
        padding: .only(top: 120),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            genderButton(false, () {
              appController.isMale = false;
              appController.go(context, DateScreen());
            }),
            genderButton(true, () {
              appController.isMale = true;
              appController.go(context, DateScreen());
            }),
          ],
        ),
      ),
    );
  }
}

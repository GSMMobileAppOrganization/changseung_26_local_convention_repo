import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "성별을 선택해주세요.",
      prevPage: AgeScreen(),
      count: 3,
      child: Padding(
        padding: .only(top: 84),
        child: Row(
          spacing: 24,
          mainAxisAlignment: .center,
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

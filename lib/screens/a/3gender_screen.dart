import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
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
        padding: const EdgeInsets.only(top: 72),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            genderButton(false, () {
              appController.saveIsMale(false);
              appController.go(context, DateScreen());
            }),
            genderButton(true, () {
              appController.saveIsMale(true);
              appController.go(context, DateScreen());
            }),
          ],
        ),
      ),
    );
  }
}

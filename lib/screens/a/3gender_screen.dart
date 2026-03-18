import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      prevPage: AgeScreen(),
      progress: 3,
      title: "성별을 선택해주세요.",
      child: Padding(
        padding: .only(top: 72),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            SizedBox.square(
              dimension: 72,
              child: genderButton(false, () {
                appController.isMale = false;
                appController.go(context, DateScreen());
              }),
            ),
            SizedBox.square(
              dimension: 72,
              child: genderButton(true, () {
                appController.isMale = true;
                appController.go(context, DateScreen());
              }),
            ),
          ],
        ),
      ),
    );
  }
}

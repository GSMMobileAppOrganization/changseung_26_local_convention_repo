import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/age_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/date_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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
      prevPage: AgeScreen(),
      progress: 3,
      child: Padding(
        padding: .only(top: 96),
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

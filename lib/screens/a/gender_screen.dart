import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/input_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
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
        padding: .only(top: 120),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            genderButton(false, () {
              appController.isMale = false;
              appController.move(context, DateScreen());
            }, width: 64),
            genderButton(true, () {
              appController.isMale = true;
              appController.move(context, DateScreen());
            }, width: 64),
          ],
        ),
      ),
    );
  }
}

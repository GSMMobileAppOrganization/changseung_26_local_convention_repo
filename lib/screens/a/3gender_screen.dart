import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '2age_screen.dart';
import '4date_screen.dart';

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
        padding: .only(top: 82),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            genderButton(false, 48, () {
              appController.isMale = false;
              appController.move(context, DateScreen());
            }),
            genderButton(true, 48, () {
              appController.isMale = true;
              appController.move(context, DateScreen());
            }),
          ],
        ),
      ),
    );
  }
}

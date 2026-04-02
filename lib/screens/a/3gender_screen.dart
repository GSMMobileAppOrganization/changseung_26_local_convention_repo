import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '4date_screen.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "성별을 선택해주세요.",
      prevPage: AgeScreen(),
      count: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 72),
        child: Row(
          spacing: 24,
          mainAxisAlignment: .center,
          children: [
            genderButton(false, () {
              appController.saveIsMale(false);
              appController.go(context, DateScreen());
            }, initialValue: appController.isMale),
            genderButton(true, () {
              appController.saveIsMale(true);
              appController.go(context, DateScreen());
            }, initialValue: appController.isMale),
          ],
        ),
      ),
    );
  }
}

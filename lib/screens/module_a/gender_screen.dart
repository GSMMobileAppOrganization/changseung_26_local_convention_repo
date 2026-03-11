import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/age_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/date_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  void submit(String m) {
    final n = int.tryParse(m.trim());

    if (n == null) {
      appController.showSnack(context, "나이 입력은 필수이며, 숫자만 입력 가능합니다.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputScreen(
      title: "성별을 선택해주세요.",
      progress: 3,
      prevPage: AgeScreen(),
      child: Padding(
        padding: .only(top: 64),
        child: Row(
          spacing: 24,
          mainAxisAlignment: .center,
          children: [
            genderButton("assets/icons/female.svg", () {
              appController.isMale = false;
              appController.move(context, DateScreen());
            }),
            genderButton("assets/icons/male.svg", () {
              appController.isMale = true;
              appController.move(context, DateScreen());
            }),
          ],
        ),
      ),
    );
  }
}

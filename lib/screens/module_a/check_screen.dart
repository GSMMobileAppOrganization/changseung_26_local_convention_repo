import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/age_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/date_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/name_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/time_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/home_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseInputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      progress: null,
      prevPage: null,
      child: Padding(
        padding: .symmetric(horizontal: 38),
        child: Column(
          spacing: 12,
          children: [
            outButton(
              "이름: ${appController.name}",
              () => appController.moveReplace(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton(
                    "나이: ${appController.age}세",
                    () => appController.moveReplace(context, AgeScreen()),
                  ),
                ),
                genderButton(
                  isCircle: true,
                  size: 32,
                  appController.isMale!
                      ? "assets/icons/male.svg"
                      : "assets/icons/female.svg",
                  () => appController.moveReplace(context, GenderScreen()),
                ),
              ],
            ),
            outButton(
              "생일: ${appController.dateFormat("y.MM.dd", appController.birthDate!)}",
              () => appController.moveReplace(context, DateScreen()),
            ),
            outButton(
              "태어난 시간: ${appController.birthTime == null ? "모름" : appController.timeFormat("HH:mm", appController.birthTime!)}",
              () => appController.moveReplace(context, TimeScreen()),
            ),

            SizedBox(height: 24),

            SizedBox(
              width: 200,
              child: button1(
                "시작하기",
                () => appController.moveReplace(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

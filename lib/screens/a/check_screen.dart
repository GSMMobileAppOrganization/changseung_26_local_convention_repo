import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/time_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      progress: null,
      child: Padding(
        padding: .symmetric(horizontal: 38),
        child: Column(
          spacing: 12,
          children: [
            SizedBox(height: 48),

            outButton(
              "이름: ${appController.name}",
              () => appController.goReset(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton(
                    "나이: ${appController.age}",
                    () => appController.goReset(context, AgeScreen()),
                  ),
                ),
                genderButton(
                  pad: 4,
                  size: 48,
                  isCircle: true,
                  appController.isMale!,
                  () => appController.goReset(context, GenderScreen()),
                ),
              ],
            ),
            outButton(
              "생일: ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.goReset(context, DateScreen()),
            ),
            outButton(
              "태어난 시간: ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () => appController.goReset(context, TimeScreen()),
            ),

            SizedBox(height: 18),

            SizedBox(
              width: 180,
              child: button1(
                "시작하기",
                () => appController.go(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/time_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      progress: null,
      prevPage: null,
      child: Padding(
        padding: .symmetric(horizontal: 42, vertical: 48),
        child: Column(
          spacing: 18,
          children: [
            outButton(
              "이름: ${appController.name}",
              () => appController.moveReset(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton(
                    "나이: ${appController.age}",
                    () => appController.moveReset(context, AgeScreen()),
                  ),
                ),

                genderButton(
                  size: 42,
                  padding: 8,
                  isCircle: true,
                  appController.isMale!,
                  () => appController.moveReset(context, GenderScreen()),
                ),
              ],
            ),
            outButton(
              "생일: ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.moveReset(context, DateScreen()),
            ),
            outButton(
              "태어난 시간: ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () => appController.moveReset(context, TimeScreen()),
            ),

            SizedBox(height: 12),

            SizedBox(
              width: 200,
              child: button1(
                "시작하기",
                () => appController.moveReset(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

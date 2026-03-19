import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/age_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/date_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/name_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/time_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/b/home_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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
        padding: .symmetric(horizontal: 36, vertical: 48),
        child: Column(
          spacing: 12,
          children: [
            outButton(
              "이름: ${appController.name}",
              () => appController.go(context, NameScreen()),
            ),
            Row(
              spacing: 18,
              children: [
                Expanded(
                  child: outButton(
                    "나이: ${appController.age}",
                    () => appController.go(context, AgeScreen()),
                  ),
                ),
                genderButton(
                  isCircle: true,
                  size: 42,
                  pad: 8,
                  appController.isMale!,
                  () => appController.go(context, GenderScreen()),
                ),
              ],
            ),
            outButton(
              "생일: ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.go(context, DateScreen()),
            ),
            outButton(
              "태어난 시간: ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () => appController.go(context, TimeScreen()),
            ),

            SizedBox(height: 24),

            SizedBox(
              width: 180,
              child: button1(
                "시작하기",
                () => appController.goReset(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

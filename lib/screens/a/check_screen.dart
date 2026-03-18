import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      prevPage: null,
      progress: null,
      title: "입력한 정보가 맞는지 확인해주세요.",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          spacing: 12,
          children: [
            SizedBox(height: 36),

            outButton(
              "이름 : ${appController.name}",
              () => appController.goReset(context, NameScreen()),
              alpha: 160,
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton(
                    "나이 : ${appController.age}세",
                    () => appController.goReset(context, AgeScreen()),
                    alpha: 160,
                  ),
                ),
                genderButton(
                  appController.isMale!,
                  () => appController.goReset(context, GenderScreen()),
                  rad: 99,
                  width: 36,
                  pad: 8,
                ),
              ],
            ),
            outButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.goReset(context, DateScreen()),
              alpha: 160,
            ),
            outButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () => appController.goReset(context, TimeScreen()),
              alpha: 160,
            ),

            SizedBox(height: 36),

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

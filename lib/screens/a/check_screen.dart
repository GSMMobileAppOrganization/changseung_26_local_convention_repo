import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      pro: null,
      prevPage: null,
      child: Padding(
        padding: .symmetric(horizontal: 36, vertical: 36),
        child: Column(
          spacing: 12,
          children: [
            outButton(
              "이름 : ${appController.name}",
              () => appController.goRest(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton(
                    "나이 : ${appController.age}세",
                    () => appController.goRest(context, AgeScreen()),
                  ),
                ),
                SizedBox.square(
                  dimension: 60,
                  child: genderButton(
                    isCircle: true,
                    appController.isMale!,
                    () => appController.go(context, GenderScreen()),
                  ),
                ),
              ],
            ),
            outButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.goRest(context, DateScreen()),
            ),
            outButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () => appController.goRest(context, TimeScreen()),
            ),

            SizedBox(height: 28),

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

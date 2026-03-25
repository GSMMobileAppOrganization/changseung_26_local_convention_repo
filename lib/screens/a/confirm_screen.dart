import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      count: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 48),
        child: Column(
          spacing: 10,
          children: [
            outlineButton("이름 : ${appController.name}", () {
              appController.goReset(context, NameScreen());
            }),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outlineButton("나이 : ${appController.age}세", () {
                    appController.goReset(context, AgeScreen());
                  }),
                ),
                genderButton(
                  isCircle: true,
                  size: 38,
                  pad: 6,
                  appController.isMale!,
                  () {
                    appController.goReset(context, GenderScreen());
                  },
                ),
              ],
            ),
            outlineButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () {
                appController.goReset(context, NameScreen());
              },
            ),
            outlineButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "잘 모르겠어요."}",
              () {
                appController.goReset(context, NameScreen());
              },
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

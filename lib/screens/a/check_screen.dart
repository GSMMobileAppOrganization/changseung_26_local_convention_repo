import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      count: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          spacing: 12,
          children: [
            Padding(
              padding: .symmetric(vertical: 12),
              child: titleW(
                "수정 횟수 : ${appController.fixCount <= 0 ? "N" : appController.fixCount}회",
                font: f2,
              ),
            ),

            outButton("이름 : ${appController.name}", () {
              appController.fixCount += 1;
              appController.goReset(context, NameScreen());
            }),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton("나이 : ${appController.age}", () {
                    appController.fixCount += 1;
                    appController.goReset(context, AgeScreen());
                  }),
                ),

                genderButton(
                  pad: 6,
                  size: 42,
                  isCircle: true,
                  appController.isMale!,
                  () {
                    appController.fixCount += 1;
                    appController.goReset(context, GenderScreen());
                  },
                ),
              ],
            ),
            outButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () {
                appController.fixCount += 1;
                appController.goReset(context, DateScreen());
              },
            ),
            outButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "모름"}",
              () {
                appController.fixCount += 1;
                appController.goReset(context, TimeScreen());
              },
            ),

            SizedBox(height: 24),

            SizedBox(
              width: 160,
              child: button1("시작하기", () {
                appController.goReset(context, HomeScreen());
              }),
            ),
          ],
        ),
      ),
    );
  }
}

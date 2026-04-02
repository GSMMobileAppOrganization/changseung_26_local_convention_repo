import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      count: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          spacing: 12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: title14W("수정 횟수: ${appController.fixCount}회", isF2: true),
            ),

            outButton("이름 : ${appController.name}", () {
              appController.fixCount += 1;
              appController.goReset(context, NameScreen());
            }),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outButton("나이 : ${appController.age}세", () {
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
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "잘 모르겠어요."}",
              () {
                appController.fixCount += 1;
                appController.goReset(context, TimeScreen());
              },
            ),

            SizedBox(height: 24),

            SizedBox(
              width: 180,
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

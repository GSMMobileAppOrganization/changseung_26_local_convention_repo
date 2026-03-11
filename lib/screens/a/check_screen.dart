import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/time_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background1.dart';
import 'package:daily_tarot_poc_app_4/widgets/input_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      progress: 1,
      hasIcon: false,
      prevPage: OnboardingScreen(),
      child: Padding(
        padding: .symmetric(horizontal: 36, vertical: 56),
        child: Column(
          spacing: 16,
          children: [
            outButton(
              "이름: ${appController.name}",
              () => appController.moveReset(context, NameScreen()),
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: outButton(
                    "나이: ${appController.age}세",
                    () => appController.moveReset(context, AgeScreen()),
                  ),
                ),

                genderButton(
                  isCircle: true,
                  width: 38,
                  iconBig: true,
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
              "태어난 시간: ${appController.time == null ? "모름" : appController.timeFormat("HH:mm", appController.time!)}",
              () => appController.moveReset(context, TimeScreen()),
            ),

            SizedBox(height: 26,),

            SizedBox(
              width: 200,
              child: button1(
                "시작하기",
                isBack: false,
                () => appController.moveReset(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

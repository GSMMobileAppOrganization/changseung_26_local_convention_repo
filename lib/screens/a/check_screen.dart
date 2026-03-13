import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '2age_screen.dart';
import '3gender_screen.dart';
import '4date_screen.dart';
import '5time_screen.dart';

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
      prevPage: null,
      progress: null,
      child: Center(
        child: Padding(
          padding: .symmetric(horizontal: 38),
          child: Column(
            spacing: 18,
            children: [
              SizedBox(height: 24),

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
                    isCircle: true,
                    pad: 8,
                    appController.isMale!,
                    42,
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
                width: 180,
                child: button1(
                  "시작하기",
                  () => appController.moveReset(context, HomeScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

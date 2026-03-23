import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/name_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  void submit(String m) {
    final n = int.tryParse(m.trim());
    if (n == null) {
      error = m.trim().isEmpty ? "나이 입력은 필수 입니다." : "나이는 숫자만 입력 가능합니다.";
      setState(() {});
      return;
    }

    appController.age = n;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      progress: 2,
      child: Padding(
        padding: .symmetric(vertical: 38, horizontal: 58),
        child: Column(
          spacing: 24,
          children: [
            input(
              "나이를 입력해주세요.",
              submit,
              isNumber: true,
              initialValue: appController.age?.toString(),
            ),
            if (error.isNotEmpty)
              title14W(
                error,
                color: Colors.red,
                font: f2,
                weight: .w500,
                align: .center,
              ),
          ],
        ),
      ),
    );
  }
}

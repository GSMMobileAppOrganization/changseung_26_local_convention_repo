import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  void submit(String m) {
    if (m.trim().isEmpty) {
      error = "나이 입력은 필수 입니다.";
      setState(() {});
      return;
    }
    final res = int.parse(m.trim());

    if (res < 1 || res > 120) {
      error = "나이는 1 이상,\n120 이하의 숫자만 가능합니다.";
      setState(() {});
      return;
    }

    appController.saveAge(res);
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      count: 2,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          spacing: 24,
          children: [
            input(
              "나이를 입력해주세요.",
              submit,
              appController.age?.toString() ?? "",
              isN: true,
            ),
            if (error.isNotEmpty)
              title14W(error, color: Colors.red, isF2: true),
          ],
        ),
      ),
    );
  }
}

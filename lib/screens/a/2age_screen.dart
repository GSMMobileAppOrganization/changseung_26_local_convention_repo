import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  void submit(String m) {
    if (m.trim().isEmpty) {
      appController.showSnack(context, "나이 입력은 필수 입니다. 나이를 입력해 주세요");
      return;
    }

    final res = int.tryParse(m.trim());

    if (res == null) {
      appController.showSnack(context, "나이는 숫자만 입력 가능합니다.");
      return;
    }

    appController.age = res;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      count: 2,
      child: Padding(
        padding: .symmetric(vertical: 48, horizontal: 48),
        child: input(
          h: "나이를 입력해주세요.",
          submit: submit,
          isNum: true,
          initialValue: appController.age?.toString(),
        ),
      ),
    );
  }
}

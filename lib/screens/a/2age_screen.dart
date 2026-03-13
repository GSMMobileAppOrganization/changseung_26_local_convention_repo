import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '3gender_screen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  void submit(String m) {
    final num = int.tryParse(m.trim());

    if (num == null) {
      appController.showSnack(context, "나이는 숫자만 입력가능합니다.");
      return;
    }

    appController.age = num;
    appController.move(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      progress: 2,
      child: Padding(
        padding: .only(top: 38),
        child: SizedBox(width: 320, child: input("나이를 입력해주세요.", submit)),
      ),
    );
  }
}

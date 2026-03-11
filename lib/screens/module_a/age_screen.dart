import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/name_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  void submit(String m) {
    final n = int.tryParse(m.trim());

    if (n == null) {
      appController.showSnack(context, "나이 입력은 필수이며, 숫자만 입력 가능합니다.");
      return;
    }

    appController.age = n;
    appController.move(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputScreen(
      title: "나이를 입력해주세요.",
      progress: 2,
      prevPage: NameScreen(),
      child: Padding(
        padding: .symmetric(horizontal: 36),
        child: input("나이를 입력해주세요.", submit),
      ),
    );
  }
}

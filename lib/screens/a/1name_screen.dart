import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String error = "";

  void submit(String m) {
    final res = m.trim();

    if (res.length < 2 || res.length > 20) {
      error = res.isEmpty ? "이름 입력은 필수 입니다." : "이름은 최소 2자,\n최대 20자까지 가능합니다.";
      setState(() {});
      return;
    }

    appController.saveName(res);
    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "이름을 입력해주세요.",
      prevPage: SplashScreen(),
      count: 1,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          spacing: 24,
          children: [
            input("이름을 입력해주세요.", submit, appController.name ?? ""),
            if (error.isNotEmpty)
              title14W(error, color: Colors.red, isF2: true),
          ],
        ),
      ),
    );
  }
}

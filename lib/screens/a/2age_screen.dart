import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  void submit(String m) {
    final res = m.trim();
    final resInt = int.tryParse(res);

    if (resInt == null) {
      error = "나이 입력은 필수 입니다.";
      setState(() {});
      return;
    }

    appController.age = resInt;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      count: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 48),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white54, width: 1.6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white, width: 1.6),
                ),
                hint: titleW("나이를 입력해주세요.", isF2: true, color: Colors.white54),
                contentPadding: .symmetric(vertical: 14, horizontal: 24),
              ),
              keyboardType: .number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onSubmitted: submit,
              style: TextStyle(
                color: Colors.white,
                fontFamily: f2,
                fontWeight: .bold,
              ),
              controller: TextEditingController(
                text: appController.age?.toString() ?? "",
              ),
            ),

            if (error.isNotEmpty)
              titleW(
                error,
                color: Colors.red,
                isF2: true,
                align: .center,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }
}
